//
//  CompareCollectionCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 14/03/2022.
//

import UIKit

class CompareCollectionCell: UICollectionViewCell {
   
    lazy var FirstRating : CosmosView = {
        let view = CosmosView()
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.9998577237, green: 0.8516119123, blue: 0.2453690469, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.updateOnTouch = false
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.textFont = UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13))
        return view
    }()
    
    lazy var SecondRating : CosmosView = {
        let view = CosmosView()
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.9998577237, green: 0.8516119123, blue: 0.2453690469, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.updateOnTouch = false
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.textFont = UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13))
        return view
    }()
    
    lazy var StackRating : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FirstRating,SecondRating])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(2)
        Stack.distribution = .equalSpacing
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var FirstValue : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(13))
        return Label
    }()
    
    lazy var SecondValue : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(13))
        return Label
    }()
    
    lazy var View:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FirstValue,SecondValue])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(2)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(TitleLabel)
        TitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(5)).isActive = true
        TitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(20)).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        addSubview(StackRating)
        StackRating.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor).isActive = true
        StackRating.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        StackRating.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackRating.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-10)).isActive = true
        
        addSubview(StackLabel)
        StackLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-10)).isActive = true
      
        addSubview(View)
        View.widthAnchor.constraint(equalToConstant: ControlX(2)).isActive = true
        View.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        View.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: ControlX(5)).isActive = true
        View.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
