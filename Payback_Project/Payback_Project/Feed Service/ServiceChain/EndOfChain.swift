//
//  EndOfChain.swift
//  Payback_Project
//
//  Created on 15/06/2021.
//

import Foundation

class EndOfChain : FeedServiceProtocol {
    func setNextHandler(nextHandler: FeedServiceProtocol?) {
        self.nextHandler = nextHandler
    }
    
    var nextHandler: FeedServiceProtocol?
    
    func saveFeed(results: Feed) {
        //empty stub
    }
    
    func fetchFeed(completion: @escaping (FeedResult)) {
        completion(.failure(FeedError.EndOfChain))
    }
    
    required init(nextHandler: FeedServiceProtocol?) {
        
    }
}


