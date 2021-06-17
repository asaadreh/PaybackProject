//
//  FeedViewModelImageItem.swift
//  Payback_Project
//
//  Created on 08/06/2021.
//

import Foundation
import UIKit

class FeedViewModelImageItem: FeedViewModelItem {
    var headline: String
    var coordinator : MainCoordinator?
    var score: Int
    var data: String
    var subline: String?
    var image: UIImage?
    
    lazy var selected: (_ item: FeedViewModelItem) -> Void = { [weak self] item in
        
        guard let strongSelf = self else { return }
        strongSelf.coordinator?.showDetail(item: item)
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
