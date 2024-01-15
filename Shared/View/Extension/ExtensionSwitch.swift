//
//  ExtensionSwitch.swift
//  Volt (iOS)
//
//  Created by Emojiios on 06/08/2022.
//

import UIKit

extension UISwitch {
    func set(offTint color: UIColor ) {
        let minSide = min(bounds.size.height, bounds.size.width)
        layer.cornerRadius = minSide / 2
        backgroundColor = color
        tintColor = color
    }
}
