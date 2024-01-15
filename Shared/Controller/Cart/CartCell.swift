//
//  CartCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 20/03/2022.
//


import UIKit

protocol CartDelegate {
    func SelectHeart(_ Cell:CartCell)
    func AddValueToCart(_ Cell:CartCell)
    func removeToCart(_ Cell:CartCell)
    func GoToLogIn()
}

class CartCell: UICollectionViewCell {
 
    var Delegate:CartDelegate?
    lazy var heart : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heart")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.tintColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        image.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        image.layer.shadowOpacity = 0.6
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 6
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SelectHeart)))
        return image
    }()
    
    @objc func SelectHeart() {
    if getUserObject().Uid  != nil {
    Delegate?.SelectHeart(self)
    }else{
    ShowMessageAlert("warning", "Log In First".localizable, "You are not logged in yet, please login first in order to continue".localizable, false, self.Delegate?.GoToLogIn ?? {}, "Go LogIn".localizable)
    }
    }
    
    func HeartAnimate(isFavourite:Bool) {
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.image = isFavourite == true ? UIImage(named: "heartSelected") : UIImage(named: "heart")
    self.heart.transform = self.heart.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.transform = .identity
    })
    })
    }

    
    lazy var ViewImage:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowRadius = 6
        View.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = .zero
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ImageItem : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
        
    lazy var Title : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()
    
    lazy var CategoryName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()
    
    lazy var Price : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.06785319746, green: 0.1525618136, blue: 0.5339012146, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()
    
    lazy var ColorLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.text = "Color".localizable
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ColorView : UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = .zero
        View.layer.shadowRadius = 6
        View.layer.cornerRadius = ControlWidth(12.5)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return View
    }()
    
    lazy var SizeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.text = "Size".localizable
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var SizeView : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.9950696826, green: 0.9619323611, blue: 0.889089644, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.9235969782, green: 0.8933065534, blue: 0.8263728023, alpha: 1)
        button.layer.borderWidth = ControlWidth(1)
        button.layer.cornerRadius = ControlWidth(12.5)
        button.titleLabel?.font = UIFont(name: "Muli" ,size: ControlWidth(12))
        button.contentEdgeInsets  = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        return button
    }()

    lazy var ColorAndSize : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ColorLabel,ColorView,SizeLabel,SizeView])
        Stack.axis = .horizontal
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Stack
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Title,CategoryName,Price,ColorAndSize])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(6)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var AddToCartView:GMStepper = {
        let View = GMStepper()
        View.borderWidth = 0
        View.labelTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.buttonsTextColor = .white
        View.buttonsBackgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        View.labelBackgroundColor = .white
        View.limitHitAnimationColor = .red
        View.label.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        View.label.layer.borderWidth = ControlWidth(2)
        View.label.layer.cornerRadius = ControlWidth(8)
        View.leftButton.layer.cornerRadius = ControlWidth(8)
        View.rightButton.layer.cornerRadius = ControlWidth(8)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.labelFont = UIFont(name: "Muli" ,size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14))
        View.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return View
    }()

    
    @objc func stepperValueChanged() {
        Delegate?.AddValueToCart(self)
    }
    
    
    lazy var LabelOutOfStock : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "This item is out of stock!".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        return Label
    }()
    
    lazy var IconRemove : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setBackgroundImage(UIImage(named: "plus_icn_pink"), for: .normal)
        Button.addTarget(self, action: #selector(RemoveToCart), for: .touchUpInside)
        return Button
    }()
    
    @objc func RemoveToCart() {
    Delegate?.removeToCart(self)
    }
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.shadowRadius = 6
    layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    layer.shadowOpacity = 0.6
    layer.shadowOffset = .zero
    
    addSubview(ViewImage)
    ViewImage.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(20)).isActive = true
    ViewImage.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-20)).isActive = true
    ViewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
    ViewImage.widthAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
        
    ViewImage.addSubview(ImageItem)
    ImageItem.topAnchor.constraint(equalTo: ViewImage.topAnchor,constant: ControlX(15)).isActive = true
    ImageItem.bottomAnchor.constraint(equalTo: ViewImage.bottomAnchor,constant: ControlX(-15)).isActive = true
    ImageItem.leadingAnchor.constraint(equalTo: ViewImage.leadingAnchor,constant: ControlX(15)).isActive = true
    ImageItem.trailingAnchor.constraint(equalTo: ViewImage.trailingAnchor,constant: ControlX(-15)).isActive = true
        
    addSubview(heart)
    heart.topAnchor.constraint(equalTo: ViewImage.topAnchor,constant: ControlX(5)).isActive = true
    heart.trailingAnchor.constraint(equalTo: ViewImage.trailingAnchor,constant: ControlX(-5)).isActive = true
    heart.widthAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
    heart.heightAnchor.constraint(equalTo: heart.widthAnchor).isActive = true
        
    addSubview(Stack)
    Stack.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(20)).isActive = true
    Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-60)).isActive = true
    Stack.leadingAnchor.constraint(equalTo: ViewImage.trailingAnchor,constant: ControlX(15)).isActive = true
    Stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-35)).isActive = true
        
    addSubview(AddToCartView)
    AddToCartView.topAnchor.constraint(equalTo: Stack.bottomAnchor,constant: ControlX(8)).isActive = true
    AddToCartView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-18)).isActive = true
    AddToCartView.leadingAnchor.constraint(equalTo: Stack.leadingAnchor).isActive = true
    AddToCartView.trailingAnchor.constraint(equalTo: Stack.trailingAnchor).isActive = true
        
    addSubview(LabelOutOfStock)
    LabelOutOfStock.topAnchor.constraint(equalTo: Stack.bottomAnchor,constant: ControlX(8)).isActive = true
    LabelOutOfStock.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-18)).isActive = true
    LabelOutOfStock.leadingAnchor.constraint(equalTo: Stack.leadingAnchor).isActive = true
    LabelOutOfStock.trailingAnchor.constraint(equalTo: Stack.trailingAnchor).isActive = true
        
    addSubview(IconRemove)
    IconRemove.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    IconRemove.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    IconRemove.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlWidth(3)).isActive = true
    IconRemove.trailingAnchor.constraint(equalTo: self.trailingAnchor ,constant: ControlWidth(-5)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
