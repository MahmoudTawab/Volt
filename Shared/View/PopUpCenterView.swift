//
//  PopUpCenterView.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 28/07/2021.
//

import UIKit

class PopUpCenterView: UIViewController {
    
  
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
    Details.spasing = ControlHeight(4)
    }
  }
  
  @IBInspectable var RightButtonText:String = "" {
    didSet {
    RightButton.setTitle(RightButtonText, for: .normal)
    }
  }
    
    @IBInspectable var StackIsHidden:Bool = true {
      didSet {
      }
    }
  
  override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated)
  SetUp()
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
  UIView.animate(withDuration: 0.5, animations: {
    self.Background.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY, width: self.view.frame.width - ControlX(30), height: self.Background.frame.height)
  }) { (End) in
  self.Background.transform = .identity
  }
  }
  
  func SetUp() {
    view.addSubview(DismissView)
    DismissView.frame = view.bounds
      
    view.addSubview(Background)
    Background.addSubview(Dismiss)
    Background.addSubview(IconImage)
    Background.addSubview(TitleLabel)
    Background.addSubview(Details)
    Background.addSubview(LeftButton)
    Background.addSubview(StackVertical)
    StackVertical.isHidden = StackIsHidden
      
    guard let DetailHeight = MessageDetails.heightWithConstrainedWidth(view.frame.width - ControlWidth(90), font: UIFont.boldSystemFont(ofSize:ControlWidth(15)), Spacing: ControlWidth(4)) else{return}
  
    
    let StackHeight = StackIsHidden == true ? 0:ControlWidth(70)
      
    let Height = ControlWidth(280) + DetailHeight + StackHeight
    
    let BackgroundHeight = Height < (view.frame.height - ControlWidth(170)) ? Height : (view.frame.height - ControlWidth(170))
      
    Background.frame = CGRect(x: ControlX(15), y: view.frame.maxY, width: view.frame.width - ControlX(30), height: BackgroundHeight)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.65, options: []) {
    self.Background.frame = CGRect(x: ControlX(15), y: self.view.center.y - (BackgroundHeight / 2), width: self.view.frame.width - ControlX(30), height: BackgroundHeight)
    }
    }
      
    self.Dismiss.frame = CGRect(x: self.Background.frame.width - ControlWidth(50), y: ControlWidth(10), width: ControlWidth(40), height: ControlWidth(40))
    IconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    IconImage.topAnchor.constraint(equalTo: Dismiss.bottomAnchor).isActive = true
    IconImage.widthAnchor.constraint(equalToConstant: ControlWidth(115)).isActive = true
    IconImage.heightAnchor.constraint(equalToConstant: ControlWidth(115)).isActive = true
    
    TitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
    TitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
    TitleLabel.topAnchor.constraint(equalTo: IconImage.bottomAnchor, constant: ControlX(25)).isActive = true
    TitleLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
      
    Details.leadingAnchor.constraint(equalTo: TitleLabel.leadingAnchor).isActive = true
    Details.trailingAnchor.constraint(equalTo: TitleLabel.trailingAnchor).isActive = true
    Details.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: ControlX(5)).isActive = true
    Details.heightAnchor.constraint(equalToConstant: DetailHeight + ControlX(15)).isActive = true
  
    self.StackVertical.frame = CGRect(x: ControlX(40), y: BackgroundHeight - ControlWidth(80), width: self.Background.frame.width - ControlX(80), height: ControlWidth(50))
  }
  
  
  lazy var DismissView : UIView = {
      let View = UIView()
      View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
      View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
      return View
  }()

  lazy var Background:UIView = {
      let View = UIView()
      View.backgroundColor = .white
      return View
  }()

  lazy var IconImage:UIImageView = {
      let ImageView = UIImageView()
      ImageView.contentMode = .scaleAspectFit
      ImageView.layer.masksToBounds = true
      ImageView.backgroundColor = .clear
      ImageView.tintColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
      ImageView.translatesAutoresizingMaskIntoConstraints = false
      return ImageView
  }()

  lazy var TitleLabel : UILabel = {
      let Label = UILabel()
      Label.textColor = #colorLiteral(red: 0.06105268747, green: 0.1525729597, blue: 0.5339061618, alpha: 1)
      Label.textAlignment = .center
      Label.font = UIFont(name: "PlayfairDisplay-Bold" ,size: ControlWidth(22))
      Label.backgroundColor = .clear
      Label.translatesAutoresizingMaskIntoConstraints = false
      return Label
  }()
  
  lazy var Details : UITextView = {
      let TV = UITextView()
      TV.textAlignment = .center
      TV.textColor = .black
      TV.isSelectable = false
      TV.isEditable = false
      TV.backgroundColor = .clear
      TV.font = UIFont(name: "Muli" ,size: ControlWidth(14))
      TV.translatesAutoresizingMaskIntoConstraints = false
      return TV
  }()
    
    
    lazy var StackVertical : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LeftButton,RightButton])
    Stack.axis = .horizontal
    Stack.spacing = ControlWidth(30)
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()
    
  lazy var LeftButton : UIButton = {
      let Button = UIButton(type: .system)
      Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      Button.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
      Button.setTitle("Close".localizable, for: .normal)
      Button.layer.borderWidth = ControlWidth(1)
      Button.layer.cornerRadius = ControlWidth(25)
      Button.titleLabel?.font = UIFont(name: "Muli-Bold", size: ControlWidth(14))
      Button.setTitleColor(UIColor.black, for: .normal)
      Button.addTarget(self, action: #selector(ActionDismiss), for: .touchUpInside)
      return Button
  }()
    
    lazy var RightButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.layer.cornerRadius = ControlWidth(25)
        Button.titleLabel?.font = UIFont(name: "Muli-Bold", size: ControlWidth(14))
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.addTarget(self, action: #selector(ActionDismiss), for: .touchUpInside)
        return Button
    }()
      
    lazy var Dismiss : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "plus_icn_pink"), for: .normal)
        Button.addTarget(self, action: #selector(ActionDismiss), for: .touchUpInside)
        return Button
    }()
        
    @objc func ActionDismiss() {
      self.dismiss(animated: true)
    }
  
}
