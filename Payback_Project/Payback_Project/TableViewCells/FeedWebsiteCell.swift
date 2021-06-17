//
//  FeedWebsiteTableViewCell.swift
//  Payback_Project
//
//  Created on 14/06/2021.
//

import Foundation
import UIKit
import LinkPresentation

class FeedWebsiteCell: UITableViewCell, BaseTableViewCell {
    
    
    // Declared properties
    
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
    
    private var websitePreview : LPLinkView = {
        let wp = LPLinkView()
        wp.translatesAutoresizingMaskIntoConstraints = false
        wp.backgroundColor = .clear
        return wp
    }()
    
    private var containerView : UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    var sublineLabel : UILabel?
    
    private var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var item : FeedViewModelItem? {
        didSet {
            guard let item = item as? FeedViewModelWebsiteItem else {
                return
            }
            
            headlineLabel.text = item.headline
            
            if let url = URL(string: item.data) {
                if let meta = item.meta {
                    
                    websitePreview.metadata = meta
                    websitePreview.isHidden = false
                }
                else {
                    
                    addPreview(url: url)
                }
            }
            if let subline = item.subline {
                addSublineLabel(subline: subline)
            }
        }
    }
    
    var provider = LPMetadataProvider()
    private var onRefresh: (() -> Void)?
    
    
    // initializer and helper functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    
    func setupViews() {
        contentView.addSubview(stackView)
        
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        bottomConstraint.priority = UILayoutPriority(749)
        bottomConstraint.isActive = true
        
        
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(websitePreview)
        containerView.addSubview(self.activityIndicator)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            bottomConstraint,
            
            containerView.widthAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.widthAnchor, constant: -50),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            
            websitePreview.topAnchor.constraint(equalTo: containerView.topAnchor),
            websitePreview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            websitePreview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            websitePreview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            
            headlineLabel.heightAnchor.constraint(equalToConstant: 25),
            
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
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
        websitePreview.isHidden = true
        provider.cancel()
        websitePreview.metadata = LPLinkMetadata()
        
        sublineLabel?.removeFromSuperview()
        sublineLabel = nil
    }
    
    
    func refresh(_ handler: @escaping () -> Void) {
        self.onRefresh = handler
    }
    
    
    // adding preview when viewmodel is set
    
    func addPreview(url: URL){
        provider = LPMetadataProvider()
        activityIndicator.startAnimating()
 
        
        provider.startFetchingMetadata(for: url) { meta, err in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {
                    print("Webview error")
                    return
                }
                strongSelf.activityIndicator.stopAnimating()
                guard let data = meta,
                      err == nil else {
                    print("Link Presentation error", err?.localizedDescription ?? "Some Error")
                    return
                }
                strongSelf.websitePreview.metadata = data
                strongSelf.websitePreview.isHidden = false
                
                if let vm = strongSelf.item as? FeedViewModelWebsiteItem {
                    print("Saving meta for \(vm.headline)")
                    vm.meta = data
                }
            }
        }
    }
    
    // adding sublineLabel if required
    
    func addSublineLabel(subline: String) {
        
        if sublineLabel == nil {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = subline
            label.font = AppFonts.sublineFont
            stackView.addArrangedSubview(label)
            label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            sublineLabel = label
        }
        else {
            sublineLabel?.text = subline
        }
    }
    
    
    
}
