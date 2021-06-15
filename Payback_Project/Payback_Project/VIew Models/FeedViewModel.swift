//
//  FeedViewModel.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import Foundation
import UIKit

protocol FeedViewModelDelagate {
    func feedfetched()
}

class FeedViewModel: NSObject {
    var items = [FeedViewModelItem]()
    var coordinator : MainCoordinator
    var service: FeedServiceProtocol?
    
    var feedViewModelDelegate : FeedViewModelDelagate?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init()
        
        guard let data = dataFromFile("ServerData"),
              let feed = Feed(data: data) else {
            fatalError("ServerData could not be loaded")
        }
        
        setupViewModels(feed: feed, coordinator: coordinator)
    }
    
    func setupViewModels(feed: Feed, coordinator: MainCoordinator) {
        
        // TODO: Make sure there are no unsafe unwrappings here, find out which attributes are optional
        
        for feed in feed.tiles {
            
            switch feed.name {
            case .image:
                let vm = FeedViewModelImageItem(headline: feed.headline,
                                               score: feed.score,
                                               data: feed.data!, subline: feed.subline)
                vm.coordinator = self.coordinator
                items.append(vm)
            case .shopping_list:
                let vm = FeedViewModelShoppingListItem(headline: feed.headline,
                                                       score: feed.score)
                items.append(vm)
            case .video:
                let vm = FeedViewModelVideoItem(headline: feed.headline,
                                                score: feed.score,
                                                data: feed.data!)
                vm.coordinator = self.coordinator
                items.append(vm)
            case .website:
                let vm = FeedViewModelWebsiteItem(headline: feed.headline,
                                                  score: feed.score,
                                                  data: feed.data!)
                items.append(vm)
            }
        }
        
        // Fulfilling requirement of displaying cells according to decsending score
        items.sort(by: {$0.score > $1.score})
        print(items)
    }
    
    init(coordinator: MainCoordinator, service: FeedServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
        super.init()

        service.fetchFeed { [weak self] result in
            switch result {
            case .success(let feed):
                self?.setupViewModels(feed: feed, coordinator: coordinator)
                self?.feedViewModelDelegate?.feedfetched()
            case .failure(let err):
                print(err)
                
            }
        }
    }
}


extension FeedViewModel : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier) as? BaseTableViewCell {

            cell.item = item
            cell.refresh {
                //tableView.reloadRows(at: [indexPath], with: .automatic)
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension FeedViewModel : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        item.selected(item)
    }
    
    
}
