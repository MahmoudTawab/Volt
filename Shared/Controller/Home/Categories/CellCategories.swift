//
//  CellCategories.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 02/01/2022.
//

import UIKit

class CellCategories: UICollectionViewCell {

    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .black
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
     addSubview(Image)
     Image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
     Image.heightAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
     Image.widthAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
     Image.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        
     addSubview(Label)
     Label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
     Label.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
     Label.leadingAnchor.constraint(equalTo: Image.trailingAnchor ,constant: ControlX(10)).isActive = true
     Label.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
