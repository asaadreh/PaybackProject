//
//  FeedDetailViewController.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 09/06/2021.
//

import UIKit
import Kingfisher

class FeedDetailViewController: UIViewController {

    var viewModel: FeedViewModelImageItem
    var imageViewItem : UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    var headlineLabel = UILabel()
    var sublineLabel = UILabel()
    
    
    
    init(viewModel: FeedViewModelItem) {
        self.viewModel = viewModel as! FeedViewModelImageItem // for now. TODO: make sure there is no unsafe unwrapping
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(viewModel.headline)
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(imageViewItem)
        view.addSubview(headlineLabel)
        view.addSubview(sublineLabel)
        
        if let url = URL(string: viewModel.data) {
            imageViewItem.kf.setImage(with: url)
            imageViewItem.contentMode = .scaleAspectFit
        }
        headlineLabel.text = viewModel.headline
        sublineLabel.text = viewModel.subline
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([imageViewItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     imageViewItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageViewItem.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                                     imageViewItem.widthAnchor.constraint(equalTo: imageViewItem.heightAnchor)])
        
    }

}
