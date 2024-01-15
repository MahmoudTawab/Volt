//
//  ItemCategoriesCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 04/01/2022.
//

import UIKit

protocol ItemCategoriesDelegate {
    func ActionCategories(_ cell:ItemCategoriesCell)
}

class ItemCategoriesCell: UICollectionViewCell {
    
    var Delegate : ItemCategoriesDelegate?
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.06105268747, green: 0.1525729597, blue: 0.5339061618, alpha: 1)
        Label.textAlignment = .center
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
               
     addSubview(Label)
     Label.centerYAnchor.constraint(equalTo: self.centerYAnchor ,constant: ControlWidth(-1)).isActive = true
     Label.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
     Label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
     Label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
         
     self.isUserInteractionEnabled = true
     self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCell)))
    }
    
    @objc func ActionCell() {
    Delegate?.ActionCategories(self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
