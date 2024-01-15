//
//  ItemCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 04/01/2022.
//

import UIKit

protocol ItemCellDelegate {
    func ActionBackground(_ Cell:ItemCell)
    func ActionHeart(_ Cell: ItemCell)
    func GoToLogIn()
}

class ItemCell: UICollectionViewCell {

    var Delegate : ItemCellDelegate?
    lazy var ViewOffer : UILabel = {
        let Label = UILabel()
        Label.isHidden = true
        Label.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Label.clipsToBounds = true
        Label.textColor = .black
        Label.textAlignment = .center
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(11.5))
        return Label
    }()
    
    lazy var ImageItem : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 2
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()

    lazy var PriceAfterLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli", size: ControlWidth(13))
        return Label
    }()
    
    lazy var PriceBeforeLabel : UILabel = {
        let Label = UILabel()
        return Label
    }()
    
    lazy var heart : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heartSelected")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.tintColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        image.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        image.layer.shadowOpacity = 0.6
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 6
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageSelect)))
        return image
    }()
    
    @objc func ImageSelect() {
    if getUserObject().Uid  != nil {
    Delegate?.ActionHeart(self)
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

    
    lazy var ViewRating : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.9998577237, green: 0.8516119123, blue: 0.2453690469, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.updateOnTouch = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.textFont = UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13))
        return view
    }()
    
    lazy var PriceStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [PriceAfterLabel,PriceBeforeLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    func update(icon: String?, Rating: String? , Details:String? , PriceAfter:String? , PriceBefore:String?, Favourite:Bool?,discount:Int?) {
    if let Discount = discount {
    ViewOffer.isHidden = discount == 0 ? true:false
    ViewOffer.text = "lang".localizable == "en" ? "\(Discount)% OFF":"٪\(Discount) خصم".NumAR()
    }
    LabelDetails.text = Details ?? ""
    PriceAfterLabel.text = "lang".localizable == "en" ? PriceAfter ?? "":PriceAfter?.NumAR() ?? ""
    PriceBeforeLabel.text = "lang".localizable == "en" ? PriceBefore ?? "":PriceBefore?.NumAR() ?? ""
    ViewRating.rating = Rating?.toDouble() ?? 1.0
    HeartAnimate(isFavourite:Favourite ?? false)
    ImageItem.sd_setImage(with: URL(string: icon ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    }
    
    var ImageItemWidthAnchor1:NSLayoutConstraint?
    var ImageItemWidthAnchor2:NSLayoutConstraint?
    
    var ImageItemHeightAnchor1:NSLayoutConstraint?
    var ImageItemHeightAnchor2:NSLayoutConstraint?
    
    var LabelTopAnchor1:NSLayoutConstraint?
    var LabelTopAnchor2:NSLayoutConstraint?
    
    var LabelleadingAnchor1:NSLayoutConstraint?
    var LabelleadingAnchor2:NSLayoutConstraint?
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .white
    contentView.addSubview(heart)
    contentView.addSubview(ViewOffer)
    contentView.addSubview(ImageItem)
    contentView.addSubview(LabelDetails)
    contentView.addSubview(ViewRating)
    contentView.addSubview(PriceStack)
        
    heart.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(8)).isActive = true
    heart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-8)).isActive = true
    heart.widthAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
    heart.heightAnchor.constraint(equalTo: heart.widthAnchor).isActive = true
        
    ViewOffer.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(8)).isActive = true
    ViewOffer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(8)).isActive = true
    ViewOffer.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
    ViewOffer.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    ViewOffer.layer.cornerRadius = ControlWidth(15)
        
    ImageItem.topAnchor.constraint(equalTo: self.topAnchor , constant: ControlWidth(45)).isActive = true
    ImageItem.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        
    ImageItemWidthAnchor1 = ImageItem.widthAnchor.constraint(equalTo: self.widthAnchor , constant: ControlX(-30))
    ImageItemWidthAnchor1?.isActive = true
        
    ImageItemWidthAnchor2 = ImageItem.widthAnchor.constraint(equalTo: self.heightAnchor , constant: ControlX(-60))
    ImageItemWidthAnchor2?.isActive = false
        
    ImageItemHeightAnchor1 = ImageItem.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlWidth(-120))
    ImageItemHeightAnchor1?.isActive = true
        
    ImageItemHeightAnchor2 = ImageItem.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlX(-30))
    ImageItemHeightAnchor2?.isActive = false
           
    LabelDetails.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
    LabelDetails.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: ControlX(-8)).isActive = true
        
    LabelTopAnchor1 = LabelDetails.topAnchor.constraint(equalTo: ImageItem.bottomAnchor , constant: ControlX(6))
    LabelTopAnchor1?.isActive = true
       
    LabelTopAnchor2 = LabelDetails.topAnchor.constraint(equalTo: ImageItem.topAnchor)
    LabelTopAnchor2?.isActive = false
        
    LabelleadingAnchor1 = LabelDetails.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(8))
    LabelleadingAnchor1?.isActive = true
        
    LabelleadingAnchor2 = LabelDetails.leadingAnchor.constraint(equalTo: ImageItem.trailingAnchor , constant: ControlX(15))
    LabelleadingAnchor2?.isActive = false
            
    ViewRating.leadingAnchor.constraint(equalTo: LabelDetails.leadingAnchor).isActive = true
    ViewRating.widthAnchor.constraint(equalToConstant: ControlWidth(90)).isActive = true
    ViewRating.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    ViewRating.topAnchor.constraint(equalTo: LabelDetails.bottomAnchor , constant: ControlX(4)).isActive = true
                
    PriceStack.leadingAnchor.constraint(equalTo: LabelDetails.leadingAnchor).isActive = true
    PriceStack.trailingAnchor.constraint(equalTo: LabelDetails.trailingAnchor).isActive = true
    PriceStack.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
    PriceStack.topAnchor.constraint(equalTo: ViewRating.bottomAnchor , constant: ControlX(4)).isActive = true
        
    self.isUserInteractionEnabled = true
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))
    }
    

    @objc func ActionBackground() {
    Delegate?.ActionBackground(self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
