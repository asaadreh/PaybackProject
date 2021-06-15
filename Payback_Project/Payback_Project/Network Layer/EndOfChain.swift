//
//  EndOfChain.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 15/06/2021.
//

import Foundation

class EndOfChain : FeedServiceProtocol {
    func saveFeed(results: Feed) {
        //empty stub
    }
    
    func fetchFeed(completion: @escaping (FeedResult)) {
        completion(.failure(FeedError.EndOfChain))
    }
    
    required init(nextHandler: FeedServiceProtocol?) {
        
    }
}


