//
//  MockFeedService.swift
//  Payback_ProjectTests
//
//  Created on 16/06/2021.
//

import Foundation
@testable import Payback_Project

enum ServiceFlow {
    case failure,success
}


class MockFeedServiceAPI : FeedServiceProtocol {
    func setNextHandler(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
    
    func saveFeed(results: Feed) {
        
    }
    
    var nextHandler: FeedServiceProtocol?
    
    func fetchFeed(completion: @escaping (FeedResult)) {
        guard let data = dataFromFile("ServerData"),
              let feed = Feed(data: data) else {
            fatalError("ServerData could not be loaded")
        }
        
        
        switch serviceFlow {
        case .failure:
            nextHandler?.fetchFeed(completion: completion)
        case .success:
            completion(.success(feed))
        case .none:
            completion(.failure(FeedError.mockError))
        }
    }
    
    var serviceFlow: ServiceFlow?
    
    convenience init(serviceFlow: ServiceFlow, nextHandler: FeedServiceProtocol?) {
        self.init(nextHandler: nextHandler)
        self.serviceFlow = serviceFlow
        
    }
    
    required init(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
        
    }
    
}

class MockCacheService: FeedServiceProtocol {
    func saveFeed(results: Feed) {
        
    }
    
    func setNextHandler(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
    
    var nextHandler: FeedServiceProtocol?

    
    func fetchFeed(completion: @escaping (FeedResult)) {
        
        guard let data = dataFromFile("ServerData"),
              let feed = Feed(data: data) else {
            fatalError("ServerData could not be loaded")
        }
        
        switch serviceFlow {
        case .failure:
            nextHandler?.fetchFeed(completion: completion)
        case .success:
            completion(.success(feed))
        case .none:
            completion(.failure(.mockError))
        }
    }
    
    var serviceFlow: ServiceFlow?
    
    convenience init(serviceFlow: ServiceFlow, nextHandler: FeedServiceProtocol?) {
        self.init(nextHandler: nextHandler)
        self.serviceFlow = serviceFlow
        
    }
    
    required init(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
        
    }
}

class MockPersistenceLayerService: FeedServiceProtocol {
    func setNextHandler(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
    
    var nextHandler: FeedServiceProtocol?
    var serviceFlow: ServiceFlow?
    
    convenience init(serviceFlow: ServiceFlow, nextHandler: FeedServiceProtocol?) {
        self.init(nextHandler: nextHandler)
        self.serviceFlow = serviceFlow
        
    }
    
    required init(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
        
    }
    
    func fetchFeed(completion: @escaping (FeedResult)) {
        
        guard let data = dataFromFile("ServerData"),
              let feed = Feed(data: data) else {
            fatalError("ServerData could not be loaded")
        }
        
        switch serviceFlow {
        case .failure:
            nextHandler?.fetchFeed(completion: completion)
        case .success:
            completion(.success(feed))
        case .none:
            completion(.failure(.mockError))
        }
    }

    
    func saveFeed(results: Feed) {
        
    }
}


class MockFeedServiceChain {
    static func mainChain() -> FeedServiceProtocol {
        let endOfChain = EndOfChain(nextHandler: nil)
        let persitenceService = MockPersistenceLayerService(serviceFlow: .success, nextHandler: endOfChain)
        let cacheService = MockCacheService(serviceFlow: .failure, nextHandler: persitenceService)
        let apiService = MockFeedServiceAPI(serviceFlow: .failure, nextHandler: cacheService)
        
        return apiService
    }
}
