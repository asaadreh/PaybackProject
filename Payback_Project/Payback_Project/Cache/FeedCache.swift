//
//  FeedCache.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 14/06/2021.
//

import Foundation

class FeedCache : NSObject, NSDiscardableContent, FeedServiceProtocol {
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {
        
    }
    
    func discardContentIfPossible() {
        
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
    
    
    let cache = NSCache<NSString, Feed>()
    private var nextHandler: FeedServiceProtocol?
    
    required init(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }

    
    func fetchFeed(completion: @escaping (FeedResult)) {
        print("Fetching from cache")
        if let fetchedFeed = cache.object(forKey: Keys.feed as NSString) {
            print("Results fetched from cache")
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
        print("Saving to cache")
        cache.setObject(results, forKey: Keys.feed as NSString)
    }

}

