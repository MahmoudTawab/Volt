//
//  CategoriesAndBrandCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 19/02/2022.
//

import UIKit

protocol CategoriesAndBrandDelegate {
    func CategoriesAndBrandAction(_ Cell:CategoriesAndBrandCell)
}

class CategoriesAndBrandCell: UITableViewCell {

    var Delegate : CategoriesAndBrandDelegate?
    lazy var CheckboxButton : Checkbox = {
        let Button = Checkbox(type: .system)
        Button.isEnabled = false
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    @objc func ActionCheckbox() {
        Delegate?.CategoriesAndBrandAction(self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(CheckboxButton)
        CheckboxButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        CheckboxButton.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        CheckboxButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        CheckboxButton.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
        contentView.isHidden = true
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionCheckbox)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
