//
//  AddressesCell.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 31/07/2021.
//

import UIKit

protocol MyAddressesDelegate {
    func EditAction(cell:AddressesCell)
    func TrashAction(cell:AddressesCell)
    func CheckBoxAction(cell:AddressesCell)
}

class AddressesCell: UITableViewCell {

    var Delegate : MyAddressesDelegate?
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
    
    
    lazy var EditButton : UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "EditAddresses")?.withInset(UIEdgeInsets(top: 0.6, left: 0.6, bottom: 0.6, right: 0.6)), for: .normal)
        Button.addTarget(self, action: #selector(ActionEdit), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionEdit() {
        Delegate?.EditAction(cell: self)
    }
    
    lazy var TrashButton : UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "TrashAddresses")?.withInset(UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)), for: .normal)
        Button.addTarget(self, action: #selector(ActionTrash), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()

    
    @objc func ActionTrash() {
        Delegate?.TrashAction(cell: self)
    }
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelName,LabelDetails,LabelPhone])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var StackButton : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [EditButton,TrashButton])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(20)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var CheckboxButton : Checkbox = {
        let Button = Checkbox(type: .system)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionCheckbox), for: .touchUpInside)
        Button.Button.addTarget(self, action: #selector(ActionCheckbox), for: .touchUpInside)
        Button.Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCheckbox)))
        return Button
    }()
    
    @objc func ActionCheckbox() {
        Delegate?.CheckBoxAction(cell: self)
    }    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.isHidden = true
        addSubview(BackgroundView)
        addSubview(StackLabel)
        addSubview(StackButton)
      
        BackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: ControlX(15)).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlY(-40)).isActive = true
         
        StackLabel.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(15)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor , constant: ControlX(15)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor , constant: ControlX(-15)).isActive = true
        
        StackButton.topAnchor.constraint(equalTo: BackgroundView.topAnchor, constant: ControlX(10)).isActive = true
        StackButton.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor ,constant: ControlX(-10)).isActive = true
        StackButton.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        StackButton.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        addSubview(CheckboxButton)
        CheckboxButton.topAnchor.constraint(equalTo: BackgroundView.bottomAnchor, constant: ControlX(10)).isActive = true
        CheckboxButton.leadingAnchor.constraint(equalTo: leadingAnchor , constant: ControlX(10)).isActive = true
        CheckboxButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-10)).isActive = true
        CheckboxButton.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-5)).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
