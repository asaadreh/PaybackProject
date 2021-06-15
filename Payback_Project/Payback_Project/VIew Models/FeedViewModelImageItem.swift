//
//  FeedViewModelImageItem.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation

class FeedViewModelImageItem: FeedViewModelItem {
    var headline: String
    
    var coordinator : MainCoordinator?
    
    var score: Int
    var data: String
    var subline: String?
    
    lazy var selected: (_ item: FeedViewModelItem) -> Void = { [weak self] item in
        self?.coordinator?.showDetail(item: item)
        
    }
    
    var cellIdentifier: String {
        
        return FeedImageCell.identifier
    }
    
    init(headline: String, score: Int, data: String, subline: String?) {
        self.headline = headline
        self.score = score
        self.data = data
        self.subline = subline
    }
}
