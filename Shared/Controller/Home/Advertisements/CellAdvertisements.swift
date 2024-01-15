//
//  CellAdvertisements.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 02/01/2022.
//

import UIKit

class CellAdvertisements: UICollectionViewCell {
    
    lazy var Image:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleToFill
        ImageView.layer.masksToBounds = true
        return ImageView
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        addSubview(Image)
        Image.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
