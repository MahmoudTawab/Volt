//
//  Description.swift
//  Volt (iOS)
//
//  Created by Emojiios on 16/02/2022.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        return ImageView
    }()

    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        Label.backgroundColor = .clear
        return Label
    }()
    
    
    lazy var Details : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        Label.backgroundColor = .clear
        return Label
    }()

    
    lazy var StackView : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [Image,TitleLabel,Details])
    Stack.axis = .vertical
    Stack.spacing = ControlWidth(10)
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.isHidden = true
                
        addSubview(StackView)
        StackView.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: ControlWidth(230)).isActive = true
        StackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(10)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


