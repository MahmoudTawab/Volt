//
//  ViewDismiss.swift
//  ViewDismiss
//
//  Created by Emoji Technology on 22/09/2021.
//

import UIKit

class ViewDismiss: UIView {

    @IBInspectable var TextDismiss:String = "" {
      didSet {
          Label.text = TextDismiss
      }
    }
    
    lazy var IconImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        let image = UIImage(named: "right-arrow")?.withInset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        ImageView.image = image
        ImageView.tintColor = .black
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.textColor = .black
        Label.font = UIFont(name: "Muli-Bold", size: ControlWidth(20))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    var ShoppingHub: BadgeHub?
    lazy var ShoppingButton: UIImageView = {
        let ImageView = UIImageView()
        ShoppingHub = BadgeHub(view: ImageView)
        ShoppingHub?.setCircleAtFrame(CGRect(x: 0, y: 0, width: ControlWidth(18), height: ControlWidth(18)))
        ShoppingHub?.setCircleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), label: UIColor.black)
        ShoppingHub?.moveCircleBy(x: ControlWidth(22), y: ControlWidth(2))
        ShoppingHub?.bump()
            
        ImageView.isHidden = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.image = UIImage(named: "cart")?.withInset(UIEdgeInsets(top: ControlX(2), left: ControlX(2), bottom: ControlX(2), right: ControlX(2)))
        return ImageView
    }()

    
    lazy var SearchIcon : UIImageView = {
        let ImageView = UIImageView()
        ImageView.isHidden = true
        ImageView.backgroundColor = .clear
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.image = UIImage(named: "Search")?.withInset(UIEdgeInsets(top: ControlX(2.5), left: ControlX(2.5), bottom: ControlX(2.5), right: ControlX(2.5)))
        return ImageView
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(IconImage)
        IconImage.topAnchor.constraint(equalTo: self.topAnchor ,constant: 4).isActive = true
        IconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        IconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        IconImage.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        IconImage.transform = "lang".localizable == "en" ? .identity : CGAffineTransform(rotationAngle: .pi)
                
        addSubview(ShoppingButton)
        ShoppingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ShoppingButton.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        ShoppingButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ShoppingButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(SearchIcon)
        SearchIcon.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        SearchIcon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        SearchIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        SearchIcon.trailingAnchor.constraint(equalTo: ShoppingButton.leadingAnchor, constant: ControlX(-6)).isActive = true
        
        addSubview(Label)
        Label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Label.leadingAnchor.constraint(equalTo: IconImage.trailingAnchor).isActive = true
        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        Label.trailingAnchor.constraint(equalTo: SearchIcon.leadingAnchor ,constant: ControlX(-5)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
