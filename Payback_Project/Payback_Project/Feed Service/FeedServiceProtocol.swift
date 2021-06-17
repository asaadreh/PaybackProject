//
//  FeedServiceProtocol.swift
//  Payback_Project
//
//  Created on 16/06/2021.
//

import Foundation

typealias FeedResult = (Result<Feed,FeedError>) -> Void

protocol FeedServiceProtocol {
    var nextHandler: FeedServiceProtocol? { get set }
    func fetchFeed(completion: @escaping (FeedResult))
    init(nextHandler: FeedServiceProtocol?)
    func saveFeed(results: Feed)
    func setNextHandler(nextHandler: FeedServiceProtocol?)
}

enum FeedError: Error, Equatable {
    case noInternet(String)
    case decodingError
    case emptyCache
    case EndOfChain
    case emptyPersistenceLayer
    case mockError
}
