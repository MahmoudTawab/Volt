//
//  SwitchCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit

class SwitchView: UIView {

    lazy var SettIngsLabel : UILabel = {
       let Label = UILabel()
       Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
       Label.backgroundColor = .clear
       Label.isUserInteractionEnabled = true
       Label.font = UIFont(name: "Muli", size: ControlWidth(17))
       Label.translatesAutoresizingMaskIntoConstraints = false
       return Label
    }()

    lazy var Switch : UISwitch = {
    let Switch = UISwitch()
    Switch.onTintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    Switch.translatesAutoresizingMaskIntoConstraints = false
    Switch.addTarget(self, action: #selector(Update), for: .valueChanged)
    return Switch
    }()
    
    @objc func Update() {
    Switch.thumbTintColor = Switch.isOn == true ? #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    Update()
    backgroundColor = .white
    addSubview(Switch)
    addSubview(SettIngsLabel)
                  
    SettIngsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    SettIngsLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    SettIngsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    SettIngsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-40)).isActive = true
        
    Switch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-10)).isActive = true
    Switch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

