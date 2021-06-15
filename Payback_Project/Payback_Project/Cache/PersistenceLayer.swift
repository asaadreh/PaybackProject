//
//  PersistenceLayer.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 15/06/2021.
//

import Foundation

class PersistenceLayer: FeedServiceProtocol {
    
    var nextHandler : FeedServiceProtocol?
    
    func fetchFeed(completion: @escaping (FeedResult)) {
        
        print("Fetching from persistence layer")
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedData = defaults.data(forKey: Keys.feed),
              let savedFeed = try? decoder.decode(Feed.self, from: savedData) {
            nextHandler?.saveFeed(results: savedFeed)
            completion(.success(savedFeed))
            return
        }
        else {
            nextHandler?.fetchFeed(completion: { [weak self] res in
                switch res {
                case .success(let feed):
                    completion(.success(feed))
                    self?.saveFeed(results: feed)
                case .failure(let err):
                    completion(.failure(err))
                }
            })
        }
    }
    
    func saveFeed(results: Feed) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let savedData = try? encoder.encode(results) else {
            fatalError("Unable to encode transformers data.")
        }
        defaults.set(savedData,forKey: Keys.feed)
    }
    
    required init(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
}
