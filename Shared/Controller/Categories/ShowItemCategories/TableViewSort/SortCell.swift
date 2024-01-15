//
//  SortCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 07/02/2022.
//

import UIKit

class SortCell: UITableViewCell {

    var LabelleadingAnchor : NSLayoutConstraint?
    var LabelleadingAnchorSelect : NSLayoutConstraint?
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(18))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        addSubview(Label)
        Label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        Label.trailingAnchor.constraint(equalTo: self.trailingAnchor ,constant: ControlX(-40)).isActive = true

        LabelleadingAnchor = Label.leadingAnchor.constraint(equalTo: self.leadingAnchor ,constant: ControlX(20))
        LabelleadingAnchor?.isActive = true
        
        LabelleadingAnchorSelect = Label.leadingAnchor.constraint(equalTo: self.leadingAnchor ,constant: ControlX(30))
        LabelleadingAnchorSelect?.isActive = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
