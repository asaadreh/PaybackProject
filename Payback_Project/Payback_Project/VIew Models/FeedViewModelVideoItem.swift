//
//  FeedViewModelVideoItem.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation
import UIKit

class FeedViewModelVideoItem: FeedViewModelItem {
    var subline: String?
    var refresh: (() -> Void)?
    var coordinator: MainCoordinator?
    var headline: String
    var score: Int
    var data: String
    var thumbnailImage : UIImage?
    
    lazy var selected: (FeedViewModelItem) -> Void = { [weak self] item in
        guard let item = item as? FeedViewModelVideoItem,
              let strongSelf = self else {
            
            print("Item could not be cast into Video Item")
            return
        }
        self?.coordinator?.playVideo(item: item)
    }
    
    var cellIdentifier: String {
        return FeedVideoTableViewCell.identifier
    }
    
    init(headline: String, score: Int, data: String) {
        self.headline = headline
        self.score = score
        self.data = data
    }
}
