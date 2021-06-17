//
//  FeedService.swift
//  Payback_Project
//
//  Created on 12/06/2021.
//

import Foundation

class FeedServiceAPI: FeedServiceProtocol {
    var nextHandler: FeedServiceProtocol?
    
    func setNextHandler(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
    
    func saveFeed(results: Feed) {
        // empty stub
    }
    
    required init(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
    
    let defaultSession = URLSession(configuration: .ephemeral)
    var dataTask: URLSessionDataTask?
    var cache = FeedCache(nextHandler: nil)
    var persistenceLayer = PersistenceLayer(nextHandler: nil)
    
    var feedURL : String {
        return "https://firebasestorage.googleapis.com/v0/b/payback-test.appspot.com/o/feed.json?alt=media&token=0f3f9a33-39df-4ad2-b9df-add07796a0fa"
    }
    
    var validCall : Bool = {
        if let lastCall = UserDefaults.standard.object(forKey: Keys.lastApiCallTime) as? Date{
            
            if lastCall.isOneDayAgo() {
                
                print("API will return data")
                return true
            }
            else {
                print("Cache will handle")
                return false
            }
        }
        else{
            return true
        }
    }()
    
    
    func fetchFeed(completion: @escaping (FeedResult)) {
        
        if !validCall{
            print("Cache will handle")
            nextHandler?.fetchFeed(completion: completion)
            return
        }
        
        print("API will handle")
        dataTask?.cancel()
        
        guard let url = URL(string: feedURL) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            if let error = error {
                let error = FeedError.noInternet(error.localizedDescription)
                completion(.failure(error))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let feed = try decoder.decode(Feed.self, from: data)
                    self?.nextHandler?.saveFeed(results: feed)
//                    self?.cache.saveToCache(results: feed)
//                    self?.persistenceLayer.saveFeed(results: feed)
//                    print("Setting Cache after API call")
                    UserDefaults.standard.set(Date(), forKey: Keys.lastApiCallTime)
                    completion(.success(feed))
                } catch {
                    
                    self?.nextHandler?.fetchFeed(completion: completion)
                    //completion(.failure(FeedError.decodingError))
                }
            }
        }
        dataTask?.resume()
    }
}
