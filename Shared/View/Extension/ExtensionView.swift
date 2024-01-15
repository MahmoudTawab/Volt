//
//  ExtensionView.swift
//  Volt (iOS)
//
//  Created by Emojiios on 03/07/2022.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat ,fillColor:CGColor) {
    self.backgroundColor = UIColor.white
    let path1 = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

    let maskLayer1 = CAShapeLayer()
    maskLayer1.path = path1.cgPath
    maskLayer1.fillColor = fillColor
    maskLayer1.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
    maskLayer1.shadowPath = maskLayer1.path
    maskLayer1.shadowOffset = .zero
    maskLayer1.shadowOpacity = 0.5
    maskLayer1.shadowRadius = 4
    self.layer.insertSublayer(maskLayer1, at: 0)
    }
    
    
    func Shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
                    
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue
                
        layer.add(shake, forKey: "position")
    }
    
    func startShimmeringEffect(animationSpeed: Float = 1.4,repeatCount: Float = 1000) {
      
      let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
      let blackColor = UIColor.black.cgColor
      
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [blackColor, lightColor, blackColor]
      gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
      
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
      gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
      self.layer.mask = gradientLayer
      
      // Add animation over gradient Layer  ->4
      CATransaction.begin()
      let animation = CABasicAnimation(keyPath: "locations")
      animation.fromValue = [0.0, 0.1, 0.2]
      animation.toValue = [0.8, 0.9, 1.0]
      animation.duration = CFTimeInterval(animationSpeed)
      animation.repeatCount = repeatCount
      CATransaction.setCompletionBlock { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.layer.mask = nil
      }
      gradientLayer.add(animation, forKey: "shimmerAnimation")
      CATransaction.commit()
    }
    
    func stopShimmeringEffect() {
      self.layer.mask = nil
    }
}
