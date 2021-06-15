//
//  FeedWebsiteTableViewCell.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 14/06/2021.
//

import Foundation
import UIKit
import LinkPresentation

class FeedWebsiteCell: UITableViewCell, BaseTableViewCell {
    
    
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
    private var activityIndicator = UIActivityIndicatorView()
    
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
    
    var provider = LPMetadataProvider()
    private var onRefresh: (() -> Void)?
    
    func refresh(_ handler: @escaping () -> Void) {
        self.onRefresh = handler
    }
    
    var item : FeedViewModelItem? {
        didSet {
            guard let item = item as? FeedViewModelWebsiteItem else {
                return
            }
            websitePreview.isHidden = true
            
            headlineLabel.text = item.headline
            
            if let url = URL(string: item.data) {
                
                addPreview(url: url)
                
            }
            if let subline = item.subline {
                addSublineLabel(subline: subline)
            }
            
            
        }
    }
    
    func addPreview(url: URL){
        provider = LPMetadataProvider()
        activityIndicator.startAnimating()
        provider.startFetchingMetadata(for: url) { meta, err in
            
            guard let data = meta,
                  err == nil else {
                print("Link Presentation error", err?.localizedDescription ?? "Some Error")
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.websitePreview.metadata = data
                self?.websitePreview.isHidden = false
                self?.onRefresh?()
            }
        }
    }
    
    
    
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
        //layoutIfNeeded()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        bottomConstraint.priority = UILayoutPriority(749)
        bottomConstraint.isActive = true
        
        
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(websitePreview)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.widthAnchor, constant: -50),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            
            websitePreview.topAnchor.constraint(equalTo: containerView.topAnchor),
            websitePreview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            websitePreview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            websitePreview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            
            headlineLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(self.activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        self.activityIndicator.hidesWhenStopped = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        //TODO: [known issue] cell shows url of reused cell

        provider.cancel()
        websitePreview.metadata = LPLinkMetadata()
        
        sublineLabel?.removeFromSuperview()
        sublineLabel = nil
    }
    
}
