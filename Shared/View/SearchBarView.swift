//
//  SearchBarView.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 02/01/2022.
//

import UIKit

class SearchBarView: UIView {

    
    @IBInspectable var IconLeft:String = "Logo" {
      didSet {
          LeftIcon.image = UIImage(named: IconLeft)
      }
    }
    
    @IBInspectable var IconRight:String = "" {
      didSet {
          RightIcon.image = UIImage(named: IconRight)?.withInset(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
      }
    }
    
    @IBInspectable var PlaceholderTF:String = "" {
      didSet {
      SearchTF.attributedPlaceholder = NSAttributedString(string: PlaceholderTF,
                                                        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
      }
    }
    
    lazy var LeftIcon : UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .white
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    lazy var RightIcon : UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .white
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var SearchTF : UITextField = {
        let tf = UITextField()
        tf.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tf.inputView = nil
        tf.backgroundColor = .white
        tf.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(50) , height: tf.frame.height))
        tf.rightViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(20) , height: tf.frame.height))
        tf.leftViewMode = .always
        tf.font = UIFont(name: "Muli", size: ControlWidth(14))
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var ShoppingHub: BadgeHub?
    lazy var ShoppingButton: UIImageView = {
        let ImageView = UIImageView()
        ShoppingHub = BadgeHub(view: ImageView)
        ShoppingHub?.setCircleAtFrame(CGRect(x: 0, y: 0, width: ControlWidth(18), height: ControlWidth(18)))
        ShoppingHub?.setCircleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), label: UIColor.black)
        ShoppingHub?.moveCircleBy(x: ControlWidth(22), y: ControlWidth(2))
        ShoppingHub?.bump()
            
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.image = UIImage(named: "cart")?.withInset(UIEdgeInsets(top: ControlX(2), left: ControlX(2), bottom: ControlX(2), right: ControlX(2)))
        return ImageView
    }()
    

    override func draw(_ rect: CGRect) {
       super.draw(rect)
        
        addSubview(LeftIcon)
        LeftIcon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        LeftIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        LeftIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        LeftIcon.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        
        addSubview(SearchTF)
        SearchTF.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        SearchTF.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        SearchTF.leadingAnchor.constraint(equalTo: LeftIcon.trailingAnchor,constant: ControlX(15)).isActive = true
        SearchTF.widthAnchor.constraint(equalToConstant: rect.width - rect.height - ControlWidth(100)).isActive = true
        SearchTF.layer.cornerRadius = rect.height / 2
        
        addSubview(RightIcon)
        RightIcon.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlWidth(8)).isActive = true
        RightIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlWidth(-8)).isActive = true
        RightIcon.leadingAnchor.constraint(equalTo: SearchTF.trailingAnchor,constant: ControlX(-30)).isActive = true
        RightIcon.widthAnchor.constraint(equalToConstant: rect.height - ControlWidth(16)).isActive = true
        
        addSubview(ShoppingButton)
        ShoppingButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        ShoppingButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ShoppingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ShoppingButton.widthAnchor.constraint(equalTo: ShoppingButton.heightAnchor).isActive = true
    }


}
