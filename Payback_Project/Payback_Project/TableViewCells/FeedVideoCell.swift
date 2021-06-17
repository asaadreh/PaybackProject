//
//  FeedVideoTableViewCell.swift
//  Payback_Project
//
//  Created on 14/06/2021.
//

import Foundation
import UIKit
import AVFoundation

class FeedVideoTableViewCell: UITableViewCell, BaseTableViewCell {
    
    
    //declared attributes
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        stackView.backgroundColor = .white
        stackView.layer.borderColor = UIColor.gray.cgColor
        stackView.layer.cornerRadius = 20
        stackView.layer.shadowOffset = CGSize(width: 1, height: 5)
        stackView.layer.shadowRadius = 10
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowColor = UIColor.gray.cgColor
        
        return stackView
    }()
    
    let headlineLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.headlineFont
        return label
    }()
    
    var sublineLabel : UILabel?
    var imageItemImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var playImageView : UIImageView?
    
    private var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func refresh(_ handler: @escaping () -> Void) {
        
    }
    
    var item : FeedViewModelItem? {
        didSet {
            guard let item = item as? FeedViewModelVideoItem else {
                return
            }
            headlineLabel.text = item.headline
            if let url = URL(string: item.data) {
                if let thumbnail = item.thumbnailImage {
                    imageItemImageView.image = thumbnail
                    addPlayButton()
                }
                else {
                    addImageItem(url: url)
                }
            }
            if let subline = item.subline {
                addSublineLabel(subline: subline)
            }
        }
    }
    
    // initializer and helper functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(imageItemImageView)
        imageItemImageView.addSubview(self.activityIndicator)
        
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        bottomConstraint.priority = UILayoutPriority(749)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            bottomConstraint,
            imageItemImageView.widthAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.widthAnchor, constant: -50),
            imageItemImageView.heightAnchor.constraint(equalToConstant: 200),
            
            headlineLabel.heightAnchor.constraint(equalToConstant: 25),
            activityIndicator.centerXAnchor.constraint(equalTo: imageItemImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageItemImageView.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        
        playImageView?.removeFromSuperview()
        sublineLabel?.removeFromSuperview()
        
        imageItemImageView.image = nil
        playImageView = nil
        sublineLabel = nil
    }
    
    
    
    // adding image
    
    func addImageItem(url: URL) {
        activityIndicator.startAnimating()
        AVAsset(url: url).generateThumbnail { [weak self] (image) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                guard let image = image else {
                    self?.imageItemImageView.image = AppImages.noImage
                    return
                    
                }
                self?.imageItemImageView.image = image
                self?.addPlayButton()
                
                if let viewModel = self?.item as? FeedViewModelVideoItem {
                    viewModel.thumbnailImage = image
                }
            }
        }
    }
    
    // adding play button
    
    func addPlayButton() {
        if playImageView == nil {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFit
            let image = UIImage(named: "play-icon")
            let tintedImage = image?.withRenderingMode(.alwaysTemplate)
            iv.image = tintedImage
            iv.tintColor = .white
            
            imageItemImageView.addSubview(iv)
            NSLayoutConstraint.activate([iv.centerXAnchor.constraint(equalTo: imageItemImageView.centerXAnchor),
                                         iv.centerYAnchor.constraint(equalTo: imageItemImageView.centerYAnchor),
                                         
                                         iv.heightAnchor.constraint(equalToConstant: 100),
                                         iv.widthAnchor.constraint(equalToConstant: 100)])
            playImageView = iv
        }
    }
    
    
    func addSublineLabel(subline: String) {
        
        if sublineLabel == nil {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = subline
            label.font = AppFonts.sublineFont
            stackView.addArrangedSubview(label)
            label.heightAnchor.constraint(equalToConstant: 20).isActive = true
            sublineLabel = label
        }
        else {
            sublineLabel?.text = subline
        }
    }
}
