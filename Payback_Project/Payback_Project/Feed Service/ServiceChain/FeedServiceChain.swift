//
//  FeedServiceChain.swift
//  Payback_Project
//
//  Created on 15/06/2021.
//

import Foundation

class FeedServiceChain {
    static func mainChain() -> FeedServiceProtocol {
        let endOfChain = EndOfChain(nextHandler: nil)
        let persitenceService = PersistenceLayer(nextHandler: endOfChain)
        let cacheService = FeedCache(nextHandler: persitenceService)
        let apiService = FeedServiceAPI(nextHandler: cacheService)
        
        return apiService
    }
    
    static func buildChain(services: [FeedServiceProtocol]) -> FeedServiceProtocol {
        let endOfChain : FeedServiceProtocol = EndOfChain(nextHandler: nil)
        var current = endOfChain
        
        for service in services.reversed() {
            service.setNextHandler(nextHandler: current)
            current = service
        }
        return current
    }
}

