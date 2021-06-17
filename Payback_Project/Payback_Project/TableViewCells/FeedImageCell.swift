//
//  MediaTableViewCell.swift
//  Payback_Project
//
//  Created on 13/06/2021.
//

import UIKit

class FeedImageCell: UITableViewCell, BaseTableViewCell {
    
    // declared attributes
    
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
        label.font = label.font.withSize(20)
        label.font = AppFonts.headlineFont
        return label
    }()
    
    var sublineLabel : UILabel?
    
    var imageItemImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = AppImages.loadingImage
        return iv
    }()

    var item : FeedViewModelItem? {
        didSet {
            guard let item = item as? FeedViewModelImageItem else {
                return
            }
            headlineLabel.text = item.headline
            if let url = URL(string: item.data) {
                imageItemImageView.kf.setImage(with: url, placeholder: AppImages.noImage)
            }
            if let subline = item.subline {
                addSublineLabel(subline: subline)
            }
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func refresh(_ handler: @escaping () -> Void) {
        
    }
    
    // initializer and helper funtions

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setupViews()
    }
    
    
    func setupViews() {
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(imageItemImageView)
        
        
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        bottomConstraint.priority = UILayoutPriority(749)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            bottomConstraint,
            imageItemImageView.widthAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.widthAnchor, constant: -50),
            imageItemImageView.heightAnchor.constraint(equalToConstant: 200),
            
            headlineLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override func prepareForReuse() {
        sublineLabel?.removeFromSuperview()
        
        imageItemImageView.image = nil
        sublineLabel = nil
    }

}
