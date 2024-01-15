//
//  HelpCell.swift
//  Bnkit
//
//  Created by Mohamed Tawab on 05/02/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//

import UIKit

class HelpCell: UITableViewCell {
        
    lazy var leftIcon : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "HelpIcon")
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var OpenClose : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Path")
        Image.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()

    lazy var TextTitle : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(19))
        return Label
    }()
    
    lazy var TheDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.4391748011, green: 0.4392418265, blue: 0.4391601086, alpha: 1)
        Label.backgroundColor = .clear
        Label.numberOfLines = 0
        Label.font = UIFont(name: "Mulit" ,size: ControlWidth(14))
        return Label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white

        let childStackView = UIStackView(arrangedSubviews: [leftIcon,TextTitle, OpenClose])
        childStackView.axis = .horizontal
        childStackView.distribution = .fillProportionally
        childStackView.alignment = .bottom
        childStackView.spacing = ControlWidth(10)
        childStackView.backgroundColor = .clear
        childStackView.translatesAutoresizingMaskIntoConstraints = false
        childStackView.arrangedSubviews[0].widthAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
        childStackView.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
        childStackView.arrangedSubviews[2].widthAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
        childStackView.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
                 
        let StackVertical = UIStackView(arrangedSubviews: [childStackView,TheDetails])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(20)
        StackVertical.backgroundColor = .clear
        StackVertical.distribution = .equalSpacing
        StackVertical.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(StackVertical)
        StackVertical.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        StackVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        StackVertical.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        StackVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
        
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }

}



