//
//  ViewController.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 08/06/2021.
//

import UIKit

class FeedViewController: UIViewController, FeedViewModelDelagate {
    
    func feedfetched() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    

    var tableView : UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //weak var coordinator : MainCoordinator?
    fileprivate var viewModel : FeedViewModel {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.feedViewModelDelegate = self
        
        self.title = "PAYBACK"
        //view.backgroundColor = AppColors.backgroundColor
        setUpViews()
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.keyboardDismissMode = .onDrag
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FeedImageCell.self, forCellReuseIdentifier: FeedImageCell.identifier)
        tableView.register(FeedWebsiteCell.self, forCellReuseIdentifier: FeedWebsiteCell.identifier)
        tableView.register(FeedVideoTableViewCell.self, forCellReuseIdentifier: FeedVideoTableViewCell.identifier)
        tableView.register(FeedShoppingListCell.self, forCellReuseIdentifier: FeedShoppingListCell.identifier)
        
//        tableView.register(FeedTableViewCellWebsiteItem.nib, forCellReuseIdentifier: FeedTableViewCellWebsiteItem.identifier)
//        tableView.register(FeedTableViewCellVideoItem.nib, forCellReuseIdentifier: FeedTableViewCellVideoItem.identifier)
//        tableView.register(FeedTableViewCellShoppingListItem.nib, forCellReuseIdentifier: FeedTableViewCellShoppingListItem.identifier)
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        
    }


}

