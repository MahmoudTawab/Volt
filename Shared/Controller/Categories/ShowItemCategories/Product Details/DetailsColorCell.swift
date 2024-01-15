//
//  DetailsColorCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 15/02/2022.
//

import UIKit

class DetailsColorCell: UICollectionViewCell {
    
    lazy var ImageSelect : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.borderWidth = ControlWidth(2)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.image = UIImage(named: "Select")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        return ImageView
    }()
    
    lazy var ViewColor:UIView = {
        let View = UIView()
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.8
        View.layer.shadowOffset = .zero
        View.layer.shadowRadius = 8
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        addSubview(ViewColor)
        ViewColor.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ViewColor.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ViewColor.widthAnchor.constraint(equalToConstant: frame.width - 12).isActive = true
        ViewColor.heightAnchor.constraint(equalToConstant: frame.height - 12).isActive = true
        ViewColor.layer.cornerRadius = (frame.height - 12) / 2
        
        addSubview(ImageSelect)
        ImageSelect.topAnchor.constraint(equalTo: topAnchor,constant: 1).isActive = true
        ImageSelect.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -1).isActive = true
        ImageSelect.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 1).isActive = true
        ImageSelect.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -1).isActive = true
        ImageSelect.layer.cornerRadius = (frame.height - 2) / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
