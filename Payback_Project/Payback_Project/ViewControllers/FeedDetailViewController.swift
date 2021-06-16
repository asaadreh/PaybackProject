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
    
    let headlineLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.headlineFont
        return label
    }()
    
    var sublineLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.sublineFont
        return label
    }()
    
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
            imageViewItem.kf.setImage(with: url, placeholder: AppImages.noImage)
            imageViewItem.contentMode = .scaleAspectFit
        }
        headlineLabel.text = viewModel.headline
        sublineLabel.text = viewModel.subline
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([imageViewItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     imageViewItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageViewItem.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                                     imageViewItem.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
        
                                     headlineLabel.topAnchor.constraint(equalTo: imageViewItem.bottomAnchor,constant: 20),
                                     headlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
                                     sublineLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor,constant: 20),
                                     sublineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }

}
