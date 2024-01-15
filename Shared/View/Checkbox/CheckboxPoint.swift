//
//  CheckboxPoint.swift
//  Volt (iOS)
//
//  Created by Emojiios on 22/03/2022.
//

import UIKit

class CheckboxPoint: UIButton {

    lazy var Button : UIButton = {
     let Button = UIButton(type: .system)
     Button.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
     Button.backgroundColor = .clear
     Button.setTitle("●", for: .normal)
     Button.layer.borderWidth = ControlWidth(2)
     Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.2, bottom: 0, right: 0)
     Button.setTitleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), for: .normal)
     return Button
    }()
    
    override func draw(_ rect: CGRect) {
    addSubview(Button)
    Button.frame = rect
    Button.layer.cornerRadius = rect.height / 2
    Button.titleLabel?.font = UIFont.systemFont(ofSize: self.frame.height - 6)
    Button.addTarget(self, action: #selector(Targe), for: .touchUpInside)
    }
    
    @objc func Targe() {
      if self.Button.tag == 0 {
      self.Button.titleLabel?.font = UIFont.systemFont(ofSize: self.frame.height - 6)
      self.Button.tag = 1
      }else{
      self.Button.titleLabel?.font = UIFont.systemFont(ofSize: 0)
      self.Button.tag = 0
      }
    FlashAnimate()
  }
    

    func IsSelect(Select:Bool) {
    if Select {
    self.Button.titleLabel?.font = UIFont.systemFont(ofSize: self.frame.height - 6)
    self.Button.tag = 1
    }else{
    self.Button.titleLabel?.font = UIFont.systemFont(ofSize: 0)
    self.Button.tag = 0
    }
    FlashAnimate()
    }
    
    func FlashAnimate() {
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.4
    flash.fromValue = 1 // alpha
    flash.toValue = 0.2 // alpha
    flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 1
    self.layer.add(flash, forKey: nil)
    }
}
