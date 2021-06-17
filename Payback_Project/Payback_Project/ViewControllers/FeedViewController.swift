//
//  ViewController.swift
//  Payback_Project
//
//  Created on 08/06/2021.
//

import UIKit

class FeedViewController: UIViewController, FeedViewModelDelagate {
    
    func feedfetched() {
        DispatchQueue.main.async {
            //self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private var tableView : UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(feedfetched), name: .feedFetched, object: nil)
        setUpViews()
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.keyboardDismissMode = .onDrag
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FeedImageCell.self, forCellReuseIdentifier: FeedImageCell.identifier)
        tableView.register(FeedWebsiteCell.self, forCellReuseIdentifier: FeedWebsiteCell.identifier)
        tableView.register(FeedVideoTableViewCell.self, forCellReuseIdentifier: FeedVideoTableViewCell.identifier)
        tableView.register(FeedShoppingListCell.self, forCellReuseIdentifier: FeedShoppingListCell.identifier)
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        //activityIndicator.startAnimating()
        
    }
    
    
}

