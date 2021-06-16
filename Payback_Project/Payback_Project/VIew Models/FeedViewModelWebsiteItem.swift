//
//  FeedViewModelWebsiteItem.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation
import LinkPresentation

class FeedViewModelWebsiteItem: FeedViewModelItem {
    
    var refresh: (() -> Void)?
    var coordinator: MainCoordinator?
    var headline: String
    var score: Int
    var data: String
    var subline: String?
    var meta : LPLinkMetadata?
    
    lazy var selected: (FeedViewModelItem) -> Void = { item in
        
    }
    
    var cellIdentifier: String {
        return FeedWebsiteCell.identifier
    }
    
    init(headline: String, score: Int, data: String) {
        self.headline = headline
        self.score = score
        self.data = data
    }
}
