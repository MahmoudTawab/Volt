//
//  Reviews.swift
//  Volt (iOS)
//
//  Created by Emojiios on 16/02/2022.
//

import UIKit

class ReviewsRatingCell: UITableViewCell  {

    func SetDataIndex(indexPath:IndexPath,ButtonRatingTitle:[String],DataDetails:ItemDetails) {
        let one = DataDetails.Rate?.oneStarsCount?.toDouble() ?? 0
        let two = DataDetails.Rate?.twoStarsCount?.toDouble() ?? 0
        let three = DataDetails.Rate?.threeStarsCount?.toDouble() ?? 0
        let four = DataDetails.Rate?.fourStarsCount?.toDouble() ?? 0
        let five = DataDetails.Rate?.fiveStarsCount?.toDouble() ?? 0
        let AllRate = one + two + three + four + five
            
        if AllRate != 0.0 {
        switch indexPath.row {
        case 1:
        LabelRating.text = "lang".localizable == "en" ? "(\(Int(one / AllRate * 100))%)":"(\(Int(one / AllRate * 100))%)".NumAR()
        ProgressView.setProgress(Float(one / AllRate), animated: false)
            
        let RatingTitle = "lang".localizable == "en" ? ButtonRatingTitle[0]:ButtonRatingTitle[0].NumAR()
        ButtonRating.setTitle("\(RatingTitle) ", for: .normal)
        case 2:
        LabelRating.text = "lang".localizable == "en" ? "(\(Int(two / AllRate * 100))%)":"(\(Int(two / AllRate * 100))%)".NumAR()
        ProgressView.setProgress(Float(two / AllRate), animated: false)
            
        let RatingTitle = "lang".localizable == "en" ? ButtonRatingTitle[1]:ButtonRatingTitle[1].NumAR()
        ButtonRating.setTitle("\(RatingTitle) ", for: .normal)
        case 3:
        LabelRating.text = "lang".localizable == "en" ? "(\(Int(three / AllRate * 100))%)":"(\(Int(three / AllRate * 100))%)".NumAR()
        ProgressView.setProgress(Float(three / AllRate), animated: false)
            
        let RatingTitle = "lang".localizable == "en" ? ButtonRatingTitle[2]:ButtonRatingTitle[2].NumAR()
        ButtonRating.setTitle("\(RatingTitle) ", for: .normal)
        case 4:
        LabelRating.text = "lang".localizable == "en" ? "(\(Int(four / AllRate * 100))%)":"(\(Int(four / AllRate * 100))%)".NumAR()
        ProgressView.setProgress(Float(four / AllRate), animated: false)
            
        let RatingTitle = "lang".localizable == "en" ? ButtonRatingTitle[3]:ButtonRatingTitle[3].NumAR()
        ButtonRating.setTitle("\(RatingTitle) ", for: .normal)
        case 5:
        LabelRating.text = "lang".localizable == "en" ? "(\(Int(five / AllRate * 100))%)":"(\(Int(five / AllRate * 100))%)".NumAR()
        ProgressView.setProgress(Float(five / AllRate), animated: false)
            
        let RatingTitle = "lang".localizable == "en" ? ButtonRatingTitle[4]:ButtonRatingTitle[4].NumAR()
        ButtonRating.setTitle("\(RatingTitle) ", for: .normal)
        default:
        break
        }
        }
    }
    
    lazy var ButtonRating : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .left
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.semanticContentAttribute = .forceRightToLeft
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "RatingSelected"), for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-Bold", size:  ControlWidth(16))
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Button
    }()
 
    lazy var ProgressView : UIProgressView = {
    let Prog = UIProgressView()
    Prog.trackTintColor = .white
    Prog.tintColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
    Prog.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Prog.clipsToBounds = true
    Prog.layer.borderWidth = ControlWidth(1)
    Prog.layer.cornerRadius = ControlHeight(5)
    Prog.translatesAutoresizingMaskIntoConstraints = false
    Prog.heightAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
    return Prog
    }()
    
    lazy var LabelRating : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Label
    }()
    
    lazy var StackView : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [ButtonRating,ProgressView,LabelRating])
    Stack.axis = .horizontal
    Stack.spacing = ControlWidth(14)
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    Stack.distribution = .fill
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.isHidden = true
                
        addSubview(StackView)
        StackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlY(15)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlY(-15)).isActive = true
        StackView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(10)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ReviewsViewAllDelegate {
    func ActionViewAll()
}

class ReviewsViewAll : UITableViewCell {
    
    var Delegate:ReviewsViewAllDelegate?
    lazy var ViewAll:UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.06842547655, green: 0.1572898328, blue: 0.537772119, alpha: 1)
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .left
        Button.semanticContentAttribute = .forceRightToLeft
        Button.setTitle("AllReviews".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.titleLabel?.font = UIFont(name: "Muli-Bold", size:  ControlWidth(18))
        Button.addTarget(self, action: #selector(ActionViewAll), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlWidth(20), left: 0, bottom: 0, right: 0)
        Button.setTitleColor(#colorLiteral(red: 0.06842547655, green: 0.1572898328, blue: 0.537772119, alpha: 1), for: .normal)
        Button.setImage(UIImage(named: "right-arrow")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)), for: .normal)
        return Button
    }()
    
    @objc func ActionViewAll() {
    Delegate?.ActionViewAll()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.isHidden = true
                
        addSubview(ViewAll)
        ViewAll.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlY(15)).isActive = true
        ViewAll.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlY(-15)).isActive = true
        ViewAll.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ViewAll.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class OverallRating : UITableViewCell {
    
    var Rate : ItemRate?
    lazy var StackHeaderView: UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [OverallRatingLabel,RatingStack])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(4)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var OverallRatingLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        return Label
    }()

    func SetViewRating() {
    guard let rate = Rate else { return }
    let one = rate.oneStarsCount?.toDouble() ?? 0
    let two = rate.twoStarsCount?.toDouble() ?? 0
    let three = rate.threeStarsCount?.toDouble() ?? 0
    let four = rate.fourStarsCount?.toDouble() ?? 0
    let five = rate.fiveStarsCount?.toDouble() ?? 0
    let AllRate = one + two + three + four + five
        

    if AllRate != 0 {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 2
    let Rate = ((1 * one) + (2 * two) + (3 * three) + (4 * four) + (5 * five))
    let All = "lang".localizable == "en" ? "\(formatter.string(from: NSNumber(value: Rate / AllRate)) ?? "") / 5" : "\(formatter.string(from: NSNumber(value: Rate / AllRate)) ?? "") / 5".NumAR()
    LabelRating.text = All
    }else{
    LabelRating.text = "lang".localizable == "en" ? "0":"0".NumAR()
    }
    
    ViewRating.rating = rate.rating?.toDouble() ?? 0
        let attributedString = NSMutableAttributedString(string: "Overall Rating".localizable, attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    ])

    let AllReviews = "lang".localizable == "en" ? String(Int(AllRate)):String(Int(AllRate)).NumAR()
    attributedString.append(NSAttributedString(string: "(\(AllReviews + " " + "Reviews".localizable))" , attributes: [
    .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    ]))
    OverallRatingLabel.attributedText = attributedString
    }
    
    lazy var LabelRating : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ViewRating : CosmosView = {
        let view = CosmosView()
        view.rating = 4.0
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.updateOnTouch = false
        return view
    }()
    
    lazy var RatingStack : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LabelRating,ViewRating])
    Stack.axis = .vertical
    Stack.spacing = ControlWidth(4)
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.isHidden = true
                
        addSubview(StackHeaderView)
        StackHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlY(15)).isActive = true
        StackHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlY(-15)).isActive = true
        StackHeaderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        StackHeaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
