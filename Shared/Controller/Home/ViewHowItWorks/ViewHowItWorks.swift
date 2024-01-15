//
//  ViewHowItWorks.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 02/01/2022.
//

import UIKit

class ViewHowItWorks: UIView {
    
    lazy var HowItWorks : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.text = "How it works"
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ImageFindYourOrder:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "HowItWorks1")
        return ImageView
    }()

    lazy var FindYourOrder : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .left
        Label.text = "Find your order"
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(12))
        Label.backgroundColor = .clear
        return Label
    }()

    lazy var ImageReadyForShipping:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "HowItWorks2")
        return ImageView
    }()
    
    lazy var ReadyForShipping : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.text = "Ready for shipping"
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(12))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ImageTrackYourOrder:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.backgroundColor = .white
        ImageView.image = UIImage(named: "HowItWorks3")  
        return ImageView
    }()
    
    lazy var TrackYourOrder : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .right
        Label.text = "Track your order"
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(12))
        Label.backgroundColor = .clear
        return Label
    }()
    
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.4391748011, green: 0.4392418265, blue: 0.4391601086, alpha: 1)
        return View
    }()
    
    lazy var Dismiss : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Button.backgroundColor = .white
        Button.setBackgroundImage(UIImage(named: "plus_icn_pink"), for: .normal)
        return Button
    }()
    
    override func draw(_ rect: CGRect) {
       super.draw(rect)
        
        addSubview(ViewLine)
        ViewLine.frame = CGRect(x: ControlX(10), y: rect.midY - ControlWidth(0.5), width: rect.width - ControlWidth(20), height: ControlWidth(1))
        
        addSubview(HowItWorks)
        HowItWorks.frame = CGRect(x: 0, y: 0, width: rect.width, height: ControlHeight(30))
        
        addSubview(Dismiss)
        Dismiss.frame = CGRect(x: rect.maxX - ControlWidth(40), y: 0, width: ControlWidth(30), height: ControlWidth(30))
        
        let StackImage = UIStackView(arrangedSubviews: [ImageFindYourOrder,UIView(),ImageReadyForShipping,UIView(),ImageTrackYourOrder])
        StackImage.axis = .horizontal
        StackImage.distribution = .fillEqually
        StackImage.alignment = .fill
        StackImage.backgroundColor = .clear
        addSubview(StackImage)
        StackImage.frame = CGRect(x: ControlX(10), y: ControlY(40), width: rect.width - ControlWidth(20), height: rect.height - ControlHeight(80))

        let StackLabel = UIStackView(arrangedSubviews: [FindYourOrder,ReadyForShipping,TrackYourOrder])
        StackLabel.axis = .horizontal
        StackLabel.distribution = .fillEqually
        StackLabel.alignment = .fill
        StackLabel.backgroundColor = .clear
        addSubview(StackLabel)
        StackLabel.frame = CGRect(x: 0, y: StackImage.frame.maxY + ControlHeight(10), width: rect.width, height: ControlHeight(30))
    }

}
