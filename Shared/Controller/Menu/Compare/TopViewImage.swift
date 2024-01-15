//
//  TopViewImage.swift
//  Volt (iOS)
//
//  Created by Emojiios on 14/03/2022.
//

import UIKit


class TopViewImage: UIView {
    
    lazy var ImageProduct : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "Group")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelProduct : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(13))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var IconRemove : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setBackgroundImage(UIImage(named: "plus_icn_pink"), for: .normal)
        return Button
    }()
  
    lazy var StackAdd : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [AddImage,AddLabel])
        Stack.axis = .vertical
        Stack.isHidden = true
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.isUserInteractionEnabled = true
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var AddImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "Group 25802")
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return ImageView
    }()
    
    lazy var AddLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = "Add another product\n to start comparing"
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9694760442, green: 0.9694761634, blue: 0.9694761634, alpha: 1)
        
        addSubview(ImageProduct)
        ImageProduct.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlWidth(15)).isActive = true
        ImageProduct.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlWidth(30)).isActive = true
        ImageProduct.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlWidth(-30)).isActive = true
        ImageProduct.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlWidth(-50)).isActive = true
        
        addSubview(LabelProduct)
        LabelProduct.topAnchor.constraint(equalTo: ImageProduct.bottomAnchor).isActive = true
        LabelProduct.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlWidth(5)).isActive = true
        LabelProduct.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlWidth(-5)).isActive = true
        LabelProduct.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlWidth(-5)).isActive = true

        addSubview(IconRemove)
        IconRemove.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        IconRemove.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        IconRemove.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlWidth(3)).isActive = true
        IconRemove.trailingAnchor.constraint(equalTo: self.trailingAnchor ,constant: ControlWidth(-3)).isActive = true
        
        addSubview(StackAdd)        
        StackAdd.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlWidth(45)).isActive = true
        StackAdd.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlWidth(15)).isActive = true
        StackAdd.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlWidth(-15)).isActive = true
        StackAdd.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlWidth(-35)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
