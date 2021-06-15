//
//  FeedShoppingListCell.swift
//  Payback_Project
//
//  Created by Agha Saad Rehman on 14/06/2021.
//

import UIKit

class FeedShoppingListCell: UITableViewCell, BaseTableViewCell {
    
    func refresh(_ handler: @escaping () -> Void) {
        self.onRefresh = handler
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        //stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
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
    
    let shoppingListTextField : UITextField = {
       let tf = UITextField()
        tf.placeholder = "e.g. Milk"
        tf.borderStyle = .roundedRect
        tf.isUserInteractionEnabled = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let addButton : UIButton = {
       let button = UIButton()
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.setTitle("Add Item", for: .normal)
        button.setTitleColor(AppColors.backgroundColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        return button
    }()


    private var onRefresh: (() -> Void)?
    
    private var shoppingList = [String]()
    
    var item : FeedViewModelItem? {
        didSet {
            guard let item = item as? FeedViewModelShoppingListItem else {
                return
            }
            headlineLabel.text = item.headline
            item.shoppingList = self.shoppingList
            //displayShoppingList(shoppingList: item.shoppingList)
        }
    }
    
    @objc func addButtonTapped(_ sender: Any) {
        shoppingListTextField.resignFirstResponder()
        guard let text = shoppingListTextField.text,
              !text.isEmpty,
              let item = item as? FeedViewModelShoppingListItem else {
            return
        }
        let count = item.shoppingList.count
        item.shoppingList.append(text)
        stackView.addArrangedSubview(getNewLabel(text: text,count: count))
        print(item.shoppingList)
        onRefresh?()
        shoppingListTextField.text = nil
        //layoutIfNeeded()
        UserDefaults.standard.set(item.shoppingList,forKey: Keys.shoppingList)
        
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
        stackView.addArrangedSubview(shoppingListTextField)
        stackView.addArrangedSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        
        shoppingListTextField.widthAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.widthAnchor, constant: -50).isActive = true
        
        // getting shopping list
        
        if let shoppingListItems = UserDefaults.standard.object(forKey: Keys.shoppingList) as? [String] {
            
            for (index,item) in shoppingListItems.enumerated() {
                stackView.addArrangedSubview(getNewLabel(text: item, count: index))
            }
            self.shoppingList = shoppingListItems
        }
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
    
    func getNewLabel(text: String, count: Int) -> UILabel{
        let itemLabel = UILabel()
        itemLabel.text = "\(count+1). \(text)"
        return itemLabel
    }
    
    override func prepareForReuse() {
        
    }

}
