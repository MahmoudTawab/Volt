//
//  CheckoutPayment.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/03/2022.
//

import UIKit

class CheckoutPayment: UITableViewCell {
        
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.layer.shadowRadius = 6
        View.layer.shadowOpacity = 0.4
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        View.layer.shadowOffset = CGSize(width: 2, height: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var PaymentName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.text = "Cash on delivery"
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.isHidden = true
        addSubview(BackgroundView)
      
        BackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: ControlX(15)).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlY(-10)).isActive = true
        
        BackgroundView.addSubview(PaymentName)
        PaymentName.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(10)).isActive = true
        PaymentName.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor , constant: ControlX(15)).isActive = true
        PaymentName.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor, constant: ControlX(-15)).isActive = true
        PaymentName.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor , constant: ControlY(-10)).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
