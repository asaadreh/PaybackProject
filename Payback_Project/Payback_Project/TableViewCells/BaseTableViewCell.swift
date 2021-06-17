//
//  BaseTableViewCell.swift
//  Payback_Project
//
//  Created on 09/06/2021.
//

import Foundation
import UIKit

protocol BaseTableViewCell: UITableViewCell {
    var item: FeedViewModelItem? { get set }
    func refresh(_ handler: @escaping () -> Void)
}
