//
//  FeedCache.swift
//  Payback_Project
//
//  Created on 14/06/2021.
//

import Foundation

class FeedCache : FeedServiceProtocol {
    func setNextHandler(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
    

    let cache = NSCache<NSString, Feed>()
    internal var nextHandler: FeedServiceProtocol?
    
    required init(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }

    
    func fetchFeed(completion: @escaping (FeedResult)) {
        if let fetchedFeed = cache.object(forKey: Keys.feed as NSString) {
            nextHandler?.saveFeed(results: fetchedFeed)
            completion(.success(fetchedFeed))
        }
        else {
            nextHandler?.fetchFeed(completion: { res in
                switch res {
                case .success(let feed):
                    completion(.success(feed))
                    self.saveFeed(results: feed)
                case .failure(let err):
                    completion(.failure(err))
                }
            })
        }
    }
    
    func saveFeed(results: Feed) {
        cache.setObject(results, forKey: Keys.feed as NSString)
        nextHandler?.saveFeed(results: results)
    }

}

extension FeedCache: NSDiscardableContent {
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {}
    
    func discardContentIfPossible() {}
    
    func isContentDiscarded() -> Bool {
        return false
    }
}
