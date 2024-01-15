//
//  CollectionOffersCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 07/02/2022.
//

import UIKit

class CollectionOffersCell: UICollectionViewCell {
 
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleToFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
        
    override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(Image)
    Image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    Image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    Image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    Image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
