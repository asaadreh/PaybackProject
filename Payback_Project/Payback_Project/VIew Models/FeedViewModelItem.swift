//
//  FeedViewModelItem.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation

protocol FeedViewModelItem {
    var selected : (FeedViewModelItem) -> Void { get set }
    var cellIdentifier: String { get }
    
    var headline: String { get set }
    var score : Int { get set }
    var subline : String? { get set }
    var coordinator: MainCoordinator? { get set }
}


