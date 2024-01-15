//
//  Checkbox.swift
//  Bnkit
//
//  Created by Mahmoud Tawab on 9/10/20.
//  Copyright © 2020 Mahmoud Tawab. All rights reserved.
//

import UIKit

class Checkbox: UIButton {

     lazy var Button : UIButton = {
     let Button = UIButton(type: .system)
     Button.backgroundColor = .clear
     Button.layer.borderWidth = ControlWidth(1.5)
     Button.layer.borderColor = #colorLiteral(red: 0.6240856554, green: 0.6240856554, blue: 0.6240856554, alpha: 1)
     Button.contentEdgeInsets.bottom = 1
     Button.contentEdgeInsets.right = 1
     Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: ControlWidth(15.5))
     Button.addTarget(self, action: #selector(Targe), for: .touchUpInside)
     return Button
     }()
    
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .left
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        return Label
    }()

     override func draw(_ rect: CGRect) {
     addSubview(Button)
     Button.frame = CGRect(x: ControlX(8.5), y: ControlX(8.5), width: ControlWidth(20), height: ControlWidth(20))
         
     addSubview(Label)
     Label.frame = CGRect(x: Button.frame.maxX + ControlX(10), y: Button.center.y - ControlWidth(10), width: rect.width - ControlWidth(40), height: ControlWidth(20))
         
     }
    
  @objc func Targe() {
    Button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
    self.Button.transform = .identity
    })
    
    UIView.animate(withDuration: 0.2) {
    if self.Button.tag == 0 {
    self.Button.setTitle("✓", for: .normal)
    self.Button.setTitleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), for: .normal)
    self.Button.layer.borderColor = #colorLiteral(red: 0.6240856554, green: 0.6240856554, blue: 0.6240856554, alpha: 1).cgColor
    self.Button.tag = 1
    }else{
    self.Button.setTitle("", for: .normal)
    self.Button.layer.borderColor = #colorLiteral(red: 0.6240856554, green: 0.6240856554, blue: 0.6240856554, alpha: 1)
    self.Button.tag = 0
    }
    }
}
    
    func Select(IsSelect:Bool , text:String) {
    Label.text = text 
    if IsSelect {
    self.Button.setTitle("✓", for: .normal)
    self.Button.setTitleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), for: .normal)
    self.Button.layer.borderColor = #colorLiteral(red: 0.6240856554, green: 0.6240856554, blue: 0.6240856554, alpha: 1).cgColor
    self.Button.tag = 1
    }else{
    self.Button.setTitle("", for: .normal)
    self.Button.layer.borderColor = #colorLiteral(red: 0.6240856554, green: 0.6240856554, blue: 0.6240856554, alpha: 1)
    self.Button.tag = 0
    }
    }

}
