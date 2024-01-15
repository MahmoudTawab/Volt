//
//  ChangePasswordVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit
import FirebaseAuth

class ChangePasswordVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        SetUp()
    }
    
    func SetUp() {
        view.addSubview(Dismiss)
        SetUpDismiss(text: "Change Password".localizable)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
                        
        let StackVertical = UIStackView(arrangedSubviews: [CurrentPasswordTF,NewPasswordTF,UpdatePassword])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(48)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.backgroundColor = .clear
        view.addSubview(StackVertical)
        StackVertical.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlY(50) , width: view.frame.width - ControlX(30), height: ControlWidth(260))
    }

    lazy var CurrentPasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.TitleHidden = false
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.Icon.addTarget(self, action: #selector(ActionPasswordCurrent), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Current Password".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionPasswordCurrent() {
        if CurrentPasswordTF.IconImage == UIImage(named: "visibility-1") {
            CurrentPasswordTF.isSecureTextEntry = false
            CurrentPasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            CurrentPasswordTF.isSecureTextEntry = true
            CurrentPasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    lazy var NewPasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.TitleHidden = false
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.Icon.addTarget(self, action: #selector(ActionPasswordNew), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "New Password".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionPasswordNew() {
        if NewPasswordTF.IconImage == UIImage(named: "visibility-1") {
            NewPasswordTF.isSecureTextEntry = false
            NewPasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            NewPasswordTF.isSecureTextEntry = true
            NewPasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    lazy var UpdatePassword : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Update Password".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionUpdatePassword), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionUpdatePassword() {
    if CurrentPasswordTF.NoErrorPassword() && NewPasswordTF.NoErrorPassword() {
    guard let OldPassword = self.CurrentPasswordTF.text else {return}
    guard let NewPassword = self.NewPasswordTF.text else {return}
    guard let email = Auth.auth().currentUser?.email else {return}
    let user = Auth.auth().currentUser
        
    ViewDots.beginRefreshing()
    let credential = EmailAuthProvider.credential(withEmail: email, password: OldPassword)
    user?.reauthenticate(with: credential, completion: { (Auth, err) in
    if let err = err {
    self.ViewDots.endRefreshing(err.localizedDescription, .error) {}
    return
    }
            
    user?.updatePassword(to: NewPassword, completion: { (err) in
    if let err = err {
    self.ViewDots.endRefreshing(err.localizedDescription, .error) {}
    return
    }
            
    self.CurrentPasswordTF.text = ""
    self.NewPasswordTF.text = ""
    self.ViewDots.endRefreshing("Success Update Password".localizable, .success) {}
    })
    })
    }
    }
}
