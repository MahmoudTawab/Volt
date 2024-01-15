//
//  DetailsSizeCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 15/02/2022.
//

import UIKit

class DetailsSizeCell: UICollectionViewCell {

    lazy var SizeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
       
    addSubview(SizeLabel)
    SizeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    SizeLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    SizeLabel.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: ControlX(10)).isActive = true
    SizeLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(-10)).isActive = true
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
