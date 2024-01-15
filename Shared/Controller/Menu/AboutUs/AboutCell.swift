//
//  AboutCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 13/03/2022.
//

import UIKit

class AboutCell: UITableViewCell {

    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        return ImageView
    }()
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var LabelBody : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(18))
        return Label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        let Stack = UIStackView(arrangedSubviews: [Image,LabelTitle,LabelBody])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(Stack)
        Stack.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlWidth(230)).isActive = true
        Stack.topAnchor.constraint(equalTo: topAnchor,constant: ControlX(10)).isActive = true
        Stack.bottomAnchor.constraint(equalTo: bottomAnchor,constant: ControlX(-10)).isActive = true
        Stack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(15)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
