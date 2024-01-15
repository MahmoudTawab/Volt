//
//  CheckoutAddress.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/03/2022.
//

import UIKit

protocol CheckoutAddressDelegate {
    func AddNewAddress()
}

class CheckoutAddress: UITableViewCell {
    
    var Delegate:CheckoutAddressDelegate?
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
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(15))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LabelPhone : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelName,LabelDetails,LabelPhone])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var Selection : CheckboxPoint = {
        let Button = CheckboxPoint(type: .system)
        Button.Button.isEnabled = false
        Button.IsSelect(Select:true)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    /// if Address == nil
    lazy var LabelNoAddress : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.isHidden = true
        Label.backgroundColor = .clear
        Label.text = "You don’t have any added address yet"
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        return Label
    }()

    lazy var AddNewButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.isHidden = true
        Button.backgroundColor = .white
        Button.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.contentEdgeInsets.bottom = 1
        Button.layer.borderWidth = ControlWidth(1)
        Button.layer.cornerRadius = ControlWidth(20)
        Button.setTitle("＋ Add new address", for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionAddNew), for: .touchUpInside)
        Button.setTitleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), for: .normal)
        return Button
    }()
    
    
    @objc func ActionAddNew() {
    Delegate?.AddNewAddress()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.isHidden = true
        addSubview(BackgroundView)
        addSubview(StackLabel)
        addSubview(Selection)
        
        BackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: ControlX(15)).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlY(-10)).isActive = true
         
        Selection.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(15)).isActive = true
        Selection.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor , constant: ControlX(15)).isActive = true
        Selection.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        Selection.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        
        StackLabel.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(10)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: Selection.trailingAnchor , constant: ControlX(10)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor , constant: ControlX(-10)).isActive = true
        
        
        /// if Address == nil
        addSubview(AddNewButton)
        addSubview(LabelNoAddress)
        
        LabelNoAddress.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(15)).isActive = true
        LabelNoAddress.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor , constant: ControlX(15)).isActive = true
        LabelNoAddress.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor, constant: ControlX(-15)).isActive = true
        LabelNoAddress.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        
        AddNewButton.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor, constant: ControlX(-20)).isActive = true
        AddNewButton.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor, constant: ControlX(-15)).isActive = true
        AddNewButton.widthAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
        AddNewButton.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
