//
//  ResetPassword.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit
import FirebaseAuth

class ResetPassword: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9116356969, green: 0.9114078879, blue: 0.9287173748, alpha: 1)

        
        ViewScroll.frame = view.bounds
        view.addSubview(ViewScroll)
        
        ViewScroll.addSubview(Dismiss)
        SetUpDismiss(text: "", ShowSearch: true, ShowShopping: true)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(25), width: view.frame.width - ControlX(30), height: ControlWidth(40))
    
        LogoImage.frame = CGRect(x: view.center.x - ControlWidth(90), y: 0, width: ControlWidth(200), height: ControlWidth(180))
        ViewScroll.addSubview(LogoImage)

        ViewScroll.addSubview(ContentView)
        ContentView.frame = CGRect(x: ControlX(20), y: view.frame.maxY , width: view.frame.width - ControlX(40), height: ControlWidth(360))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.65, options: []) {
        self.ContentView.frame = CGRect(x: ControlX(20), y: self.LogoImage.frame.maxY - ControlY(5), width: self.view.frame.width - ControlX(40), height: ControlWidth(360))
        }
        }
        
        SetUp()
    }
    
    func SetUp() {
        ContentView.addSubview(SignInLabel)
        SignInLabel.frame = CGRect(x: ControlX(20), y: ControlY(25), width: ContentView.frame.width - ControlX(40), height: ControlWidth(35))
        
        ContentView.addSubview(MassageLabel)
        MassageLabel.frame = CGRect(x: ControlX(20), y: SignInLabel.frame.maxY + ControlY(25), width: ContentView.frame.width - ControlX(40), height: ControlWidth(60))
        
        ContentView.addSubview(EmailTF)
        EmailTF.frame = CGRect(x: ControlX(20), y: MassageLabel.frame.maxY + ControlY(25), width: ContentView.frame.width - ControlX(40), height: ControlWidth(50))
        
        ContentView.addSubview(ResetPassword)
        ResetPassword.frame = CGRect(x: ControlX(20), y: EmailTF.frame.maxY + ControlY(45), width: ContentView.frame.width - ControlX(40), height: ControlWidth(50))
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height - ControlX(20))
        return Scroll
    }()

    lazy var LogoImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.image = UIImage(named: "Logo")
        return ImageView
    }()
    
    lazy var ContentView:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.borderWidth = 1
        View.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        View.layer.cornerRadius = ControlWidth(20)
        return View
    }()

    lazy var SignInLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.06105268747, green: 0.1525729597, blue: 0.5339061618, alpha: 1)
        Label.text = "Forgot your password?".localizable
        Label.font = UIFont(name: "Muli-SemiBold" ,size: ControlWidth(23))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "E-mail".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    
    lazy var MassageLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.text = "Enter your email , to help you to reset your password.".localizable
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(13))
        return Label
    }()
    
    lazy var ResetPassword : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Reset password".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionResetPassword), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionResetPassword() {
    if EmailTF.NoError() && EmailTF.NoErrorEmail() {
    guard let email = EmailTF.text else { return }
    self.ViewDots.beginRefreshing()
    Auth.auth().sendPasswordReset(withEmail: email) { (err) in
    if let err = err {
    self.ViewDots.endRefreshing() {ShowMessageAlert("warning", "Error".localizable, err.localizedDescription, false,self.ActionResetPassword)}
    return
    }

    self.ViewDots.endRefreshing() {
    self.EmailTF.text = ""
    ShowMessageAlert("confirm", "Password Reset link".localizable, "Password reset link has been successfully sent to your email".localizable, true) {}
    }
    }
    }
    }
    
    
}



