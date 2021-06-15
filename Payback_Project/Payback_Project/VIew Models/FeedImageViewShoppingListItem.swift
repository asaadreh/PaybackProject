//
//  FeedImageViewShoppingListItem.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation

class FeedViewModelShoppingListItem: FeedViewModelItem {
    var subline: String?
    
    func refresh(_ handler: @escaping () -> Void) {
        
    }
    
    var coordinator: MainCoordinator?
    
    var headline: String
    
    var score: Int
    
    lazy var selected: (FeedViewModelItem) -> Void = {item in 
        print("Selected")
    }
    
    var shoppingList : [String]
    
    
    var cellIdentifier: String {
        return FeedShoppingListCell.identifier
    }
    
    init(headline: String, score: Int) {
        self.headline = headline
        self.score = score
        
        // TODO: Make this list persist
        self.shoppingList = [String]()
    }
}
