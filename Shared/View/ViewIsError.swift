//
//  ViewIsError.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 13/12/2021.
//

import UIKit

class ViewIsError: UIView {

    
    @IBInspectable var TextRefresh:String = "" {
      didSet {
        RefreshButton.setTitle(TextRefresh, for: .normal)
      }
    }
    
    @IBInspectable var ImageIcon:String = "" {
      didSet {
        IconImage.image = UIImage(named: ImageIcon)
      }
    }
    
    @IBInspectable var MessageTitle:String = "" {
      didSet {
      TitleLabel.text = MessageTitle
      }
    }
    
    @IBInspectable var MessageDetails:String = "" {
      didSet {
      Details.text = MessageDetails
      }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(IconImage)
        addSubview(TitleLabel)
                
        IconImage.frame = CGRect(x: rect.midX - ControlWidth(110), y:  rect.midY - ControlWidth(220), width: ControlWidth(220), height: ControlWidth(220))
            
        TitleLabel.frame = CGRect(x: ControlX(20), y: IconImage.frame.maxY + ControlX(20), width: rect.width - ControlWidth(40), height: ControlWidth(30))
        
        addSubview(Details)
        addSubview(RefreshButton)
          
        Details.frame = CGRect(x: 0, y: TitleLabel.frame.maxY + ControlX(10), width: rect.width, height: ControlWidth(90))
            
        RefreshButton.frame = CGRect(x: 0, y: Details.frame.maxY + ControlX(10), width: rect.width, height: ControlWidth(50))
    }

    lazy var IconImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .clear
        return ImageView
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.font = UIFont(name: "Muli-Bold", size: ControlWidth(18))
        Label.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var Details : UITextView = {
        let TV = UITextView()
        TV.textAlignment = .center
        TV.font = UIFont(name: "Muli-Bold", size: ControlWidth(16))
        TV.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        TV.spasing = ControlHeight(4)
        TV.isSelectable = false
        TV.isEditable = false
        TV.backgroundColor = .clear
        TV.keyboardAppearance = .light
        return TV
    }()
    
    lazy var RefreshButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        return Button
    }()

}
