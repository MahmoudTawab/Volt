//
//  CheckoutVoucher.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/03/2022.
//

import UIKit

protocol CheckoutVoucherDelegate {
    func ApplyAction(cell:CheckoutVoucher)
}

class CheckoutVoucher: UITableViewCell {

    var Delegate : CheckoutVoucherDelegate?
    lazy var VoucherCodeTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.rightViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(90), height: self.frame.height))
        tf.attributedPlaceholder = NSAttributedString(string: "Enter voucher code", attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var ApplyButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Apply", for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionApply), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(14))
        return Button
    }()
    
    @objc func ActionApply() {
    Delegate?.ApplyAction(cell: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.isHidden = true
        addSubview(VoucherCodeTF)
        addSubview(ApplyButton)
        
        VoucherCodeTF.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(10)).isActive = true
        VoucherCodeTF.leadingAnchor.constraint(equalTo: leadingAnchor , constant: ControlX(15)).isActive = true
        VoucherCodeTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-15)).isActive = true
        VoucherCodeTF.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-10)).isActive = true
        
        ApplyButton.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        ApplyButton.bottomAnchor.constraint(equalTo: bottomAnchor , constant: ControlX(-10)).isActive = true
        ApplyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-16)).isActive = true
        ApplyButton.topAnchor.constraint(equalTo: VoucherCodeTF.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
