//
//  MenuCell.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 30/12/2021.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
     lazy var MenuLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli", size: ControlWidth(17))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
        }()

       lazy var ImageView:UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
       }()
    
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    addSubview(MenuLabel)
    addSubview(ImageView)
    
        
    ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(20)).isActive = true
    ImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(28)).isActive = true
    ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(28)).isActive = true
            
    MenuLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    MenuLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: ControlWidth(-20)).isActive = true
    MenuLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: ControlX(20)).isActive = true
    MenuLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
