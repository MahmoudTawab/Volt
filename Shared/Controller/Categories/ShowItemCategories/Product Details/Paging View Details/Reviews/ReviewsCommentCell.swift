//
//  ReviewsCommentCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 23/03/2022.
//

import UIKit

class ReviewsCommentCell: UITableViewCell  {
        
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var NameAndDate : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LabelName,LabelDate])
    Stack.axis = .horizontal
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    Stack.distribution = .equalSpacing
    return Stack
    }()
    
    lazy var ViewRating : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.updateOnTouch = false
        return view
    }()
    
    lazy var Comment : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var StackView: UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NameAndDate,ViewRating,Comment])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.isHidden = true
                
        addSubview(StackView)
        StackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackView.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(15)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






