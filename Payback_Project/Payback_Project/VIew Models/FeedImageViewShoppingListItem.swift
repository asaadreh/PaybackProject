//
//  FeedImageViewShoppingListItem.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation

class FeedViewModelShoppingListItem: FeedViewModelItem {
    
    var subline: String?
    var coordinator: MainCoordinator?
    var headline: String
    var score: Int
    var shoppingList : [String]?
    
    lazy var selected: (FeedViewModelItem) -> Void = {item in
        
    }
    
    
    var cellIdentifier: String {
        return FeedShoppingListCell.identifier
    }
    
    init(headline: String, score: Int) {
        self.headline = headline
        self.score = score
    }
    
    func refresh(_ handler: @escaping () -> Void) {}
}
