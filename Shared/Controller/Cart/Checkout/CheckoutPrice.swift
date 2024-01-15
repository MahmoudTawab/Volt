//
//  CheckoutPrice.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/03/2022.
//

import UIKit

class CheckoutPrice: UITableViewCell {

    lazy var FirstValue : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .left
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var SecondValue : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .right
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FirstValue,SecondValue])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(20)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.isHidden = true
        View.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.9388945275, green: 0.9388945275, blue: 0.9388945275, alpha: 1)
        contentView.isHidden = true
        
        addSubview(StackLabel)
        StackLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(20)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-10)).isActive = true
        
        addSubview(ViewLine)
        ViewLine.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ViewLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ViewLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ViewLine.heightAnchor.constraint(equalToConstant: ControlX(1)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
