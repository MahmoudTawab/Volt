//
//  MenuTapCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 14/03/2022.
//

import UIKit

class MenuTapCell: UICollectionViewCell {
    
     lazy var MenuLabel : UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        return Label
    }()
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    addSubview(MenuLabel)
    MenuLabel.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
