//
//  SettingsCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit

class SettingsCell: UITableViewCell {

    lazy var SettIngsLabel : UILabel = {
    let Label = UILabel()
       Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
       Label.backgroundColor = .clear
       Label.font = UIFont(name: "Muli", size: ControlWidth(17))
       Label.translatesAutoresizingMaskIntoConstraints = false
    return Label
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(SettIngsLabel)
                
        SettIngsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        SettIngsLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        SettIngsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        SettIngsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
