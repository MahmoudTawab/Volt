//
//  LocationSearchCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 12/03/2022.
//

import UIKit

class LocationSearchCell: UITableViewCell {

    lazy var TextLabel : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Muli-Bold", size: ControlWidth(15))
    Label.translatesAutoresizingMaskIntoConstraints = false
    return Label
    }()
    
    lazy var DetailTextLabel : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    Label.font = UIFont(name: "Muli" ,size: ControlWidth(12))
    Label.backgroundColor = .clear
    return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .white
    
    let Stack = UIStackView(arrangedSubviews: [TextLabel,DetailTextLabel])
    Stack.axis = .vertical
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
        
    addSubview(Stack)
    Stack.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
    Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-5)).isActive = true
    Stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
    Stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
