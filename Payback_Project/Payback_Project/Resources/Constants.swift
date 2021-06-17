//
//  Constants.swift
//  Payback_Project
//
//  Created on 12/06/2021.
//

import Foundation
import UIKit

class AppColors {
    static let tileColor = UIColor.white
    static let tileColorBlue = UIColor(red: 209/256, green: 220/256, blue: 236/256, alpha: 1)
    static let backgroundColor = UIColor(red: 27/256, green: 69/256, blue: 164/256, alpha: 1)    
}

class AppImages {
    static let noImage = UIImage(named: "no-image")
    static let loadingImage = UIImage(named: "loading-image")
    
}

class AppFonts {
    static let headlineFont = UIFont(name: "Futura", size: 20)
    static let sublineFont = UIFont(name: "Futura", size: 15)
}

class Keys {
    
    static let lastApiCallTime = "last_api_call_time"
    static let feed = "feed"
    static let shoppingList = "shopping_list"
}
