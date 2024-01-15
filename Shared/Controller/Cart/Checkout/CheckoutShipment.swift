//
//  CheckoutShipment.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/03/2022.
//

import UIKit

class CheckoutShipment: UITableViewCell {
    
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
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(15))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LabelPrice : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelName,LabelPrice,LabelDetails])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    lazy var ImageView:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9388945275, green: 0.9388945275, blue: 0.9388945275, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ImageItem : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.isHidden = true
        addSubview(BackgroundView)
        addSubview(StackLabel)

        addSubview(ImageView)
        ImageView.addSubview(ImageItem)
        
        BackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: ControlX(15)).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlY(-10)).isActive = true
         
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        ImageView.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(15)).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor , constant: ControlX(15)).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor , constant: ControlX(-15)).isActive = true
        ImageView.layer.cornerRadius = ControlWidth(20)
        
        ImageItem.topAnchor.constraint(equalTo: ImageView.topAnchor, constant: ControlX(10)).isActive = true
        ImageItem.leadingAnchor.constraint(equalTo: ImageView.leadingAnchor, constant: ControlX(15)).isActive = true
        ImageItem.trailingAnchor.constraint(equalTo: ImageView.trailingAnchor , constant: ControlX(-15)).isActive = true
        ImageItem.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor , constant: ControlX(-10)).isActive = true
        
        StackLabel.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(15)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor , constant: ControlX(10)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor , constant: ControlX(-15)).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
