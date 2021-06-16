//
//  FeedServiceChain.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 15/06/2021.
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
}

