//
//  BaseTableViewCell.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 09/06/2021.
//

import Foundation
import UIKit

protocol BaseTableViewCell: UITableViewCell {
    var item: FeedViewModelItem? { get set }
    func refresh(_ handler: @escaping () -> Void)
}
