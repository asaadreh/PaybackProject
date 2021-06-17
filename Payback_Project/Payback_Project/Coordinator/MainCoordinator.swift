//
//  MainCoordinator.swift
//  Payback_Project
//
//  Created on 08/06/2021.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class MainCoordinator : Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var service: FeedServiceProtocol {
        let service = FeedServiceChain.mainChain()
        return service
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //let viewModel = FeedViewModel(coordinator: self)
        let viewModelWithService = FeedViewModel(coordinator: self, service: service)
        let vc = FeedViewController(viewModel: viewModelWithService)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetail(item: FeedViewModelItem) {
        
        let vc = FeedDetailViewController(viewModel: item)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func playVideo(item: FeedViewModelVideoItem) {
        guard let url = URL(string: item.data) else {
            return
        }
        
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        navigationController.pushViewController(vc, animated: true)
    }
}
