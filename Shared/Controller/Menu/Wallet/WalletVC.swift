//
//  WalletVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/02/2022.
//

import UIKit

class WalletVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        view.addSubview(Dismiss)
        SetUpDismiss(text: "Wallet".localizable)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
        view.addSubview(BackgroundView)
        BackgroundView.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width - ControlX(30), height: ControlWidth(120))
        
        view.addSubview(StackView)
        StackView.frame = CGRect(x: BackgroundView.frame.minX + ControlX(10), y: BackgroundView.frame.minY + ControlY(20), width: BackgroundView.frame.width - ControlX(20), height: BackgroundView.frame.height - ControlY(40))
    }

 
    lazy var BackgroundView:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9694760442, green: 0.9694761634, blue: 0.9694761634, alpha: 1)
        View.layer.borderWidth = 1
        View.layer.borderColor = #colorLiteral(red: 0.8974402547, green: 0.8974402547, blue: 0.8974402547, alpha: 1)
        return View
    }()
    
    
    lazy var StackView : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [WalletCredit,WalletMessage])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    var Wallet = 32
    lazy var WalletCredit : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.textAlignment = .center
        Button.setImage(UIImage(named: "Menu5"), for: .normal)
        
        let attributedString = NSMutableAttributedString(string: "Wallet Credit".localizable, attributes: [
            .font: UIFont(name: "Muli-SemiBold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])

        let wallet = "lang".localizable == "en" ? "\(Wallet)" : "\(Wallet)".NumAR()
        attributedString.append(NSAttributedString(string: "\("EGP".localizable) \(wallet)", attributes: [
            .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ]))
        Button.contentHorizontalAlignment = .left
        Button.setAttributedTitle(attributedString, for: .normal)
        return Button
    }()
    
    
    
    lazy var WalletMessage : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.titleLabel?.textAlignment = .center
        Button.contentHorizontalAlignment = .left
        Button.setImage(UIImage(named: "Group 26030"), for: .normal)
        Button.setTitleColor(#colorLiteral(red: 0.878931284, green: 0.2352250218, blue: 0.2290514708, alpha: 1), for: .normal)
        Button.setTitle("Wallet credit isn’t available for usage at the moment".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli" ,size: ControlWidth(11))
        Button.backgroundColor = .clear
        return Button
    }()
    
}
