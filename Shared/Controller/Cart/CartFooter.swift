//
//  CartFooter.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/03/2022.
//

import UIKit

protocol CartFooterDelegate {
    func ActionProceed()
}

class CartFooter: UICollectionViewCell {
    
    var Delegate : CartFooterDelegate?
    lazy var SubtotalLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ProceedToItems : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionProceed), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionProceed() {
    Delegate?.ActionProceed()
    }
    
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SubtotalLabel,ProceedToItems])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .white
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(Stack)
        Stack.frame = CGRect(x: ControlX(10), y: ControlX(15), width: self.frame.width - ControlX(20), height: self.frame.height - ControlX(30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
