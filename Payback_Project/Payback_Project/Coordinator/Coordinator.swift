//
//  Coordinator.swift
//  Payback_Project
//
//  Created on 08/06/2021.
//

import Foundation

import Foundation
import UIKit


protocol Coordinator {
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController { get set }
    
    func start()
}
