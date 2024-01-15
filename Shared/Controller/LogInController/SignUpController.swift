//
//  SignUpController.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FlagPhoneNumber
import AuthenticationServices

class SignUpController: ViewController ,FPNTextFieldDelegate {
    
    var uid = String()
    var Social = String()
    var ProfileImageUrl : URL?
    var HeightSignUp = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9116356969, green: 0.9114078879, blue: 0.9287173748, alpha: 1)

        ViewScroll.frame = view.bounds
        view.addSubview(ViewScroll)
    
        LogoImage.frame = CGRect(x: view.center.x - ControlWidth(90), y: 0, width: ControlWidth(200), height: ControlWidth(180))
        ViewScroll.addSubview(LogoImage)

        if SignInLabel.text == "Sign Up".localizable {
        PasswordTF.isHidden = false
        PasswordTF.isHidden = false
        HeightSignUp = ControlWidth(730)
        }else{
        isValidNumber = true
        PasswordTF.text = "123456"
        PasswordTF.isHidden = true
        HeightSignUp = ControlWidth(650)
        }
        
        ViewScroll.addSubview(ContentView)
        ContentView.frame = CGRect(x: ControlX(20), y: view.frame.maxY , width: view.frame.width - ControlX(40), height: HeightSignUp)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.65, options: []) {
        self.ContentView.frame = CGRect(x: ControlX(20), y: self.LogoImage.frame.maxY - ControlY(5), width: self.view.frame.width - ControlX(40), height: self.HeightSignUp)
        }
        self.ViewScroll.updateContentViewSize(ControlWidth(50))
        }
        
        SetUp()
    }
    
    func SetUp() {
        
        ContentView.addSubview(SignInLabel)
        SignInLabel.frame = CGRect(x: ControlX(20), y: ControlX(10), width: ContentView.frame.width - ControlX(40), height: ControlWidth(35))
            

        let StackVertical = UIStackView(arrangedSubviews: [FirstNameTF,LastNameTF,EmailTF,PasswordTF,PhoneNumberTF,GenderTF])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlWidth(33)
        StackVertical.distribution = .fillEqually
        StackVertical.alignment = .fill
        StackVertical.backgroundColor = .clear
        ContentView.addSubview(StackVertical)
        StackVertical.frame = CGRect(x: ControlX(20), y: SignInLabel.frame.maxY + ControlX(20), width: ContentView.frame.width - ControlX(40), height: ContentView.frame.height - ControlWidth(290))

        ContentView.addSubview(CheckboxButton)
        CheckboxButton.frame = CGRect(x: ControlX(20), y: StackVertical.frame.maxY + ControlX(20), width: ContentView.frame.width - ControlX(40), height: ControlWidth(30))

        ContentView.addSubview(SignIn)
        SignIn.frame = CGRect(x: ControlX(20), y: CheckboxButton.frame.maxY + ControlX(30), width: ContentView.frame.width - ControlX(40), height: ControlWidth(50))

        ContentView.addSubview(SignUpNow)
        SignUpNow.frame = CGRect(x: ControlX(20), y: SignIn.frame.maxY + ControlX(20), width: ContentView.frame.width - ControlX(40), height: ControlWidth(30))

        SetUpPhoneNumber()
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
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
        Label.text = "Sign Up".localizable
        Label.font = UIFont(name: "Muli-SemiBold" ,size: ControlWidth(20))
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var FirstNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.attributedPlaceholder = NSAttributedString(string: "First Name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var LastNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.attributedPlaceholder = NSAttributedString(string: "Last Name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "E-mail".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var PasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.IconImage = UIImage(named: "visibility-1")
        tf.Icon.addTarget(self, action: #selector(ActionPassword), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Password".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionPassword() {
        if PasswordTF.IconImage == UIImage(named: "visibility-1") {
            PasswordTF.isSecureTextEntry = false
            PasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            PasswordTF.isSecureTextEntry = true
            PasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }

    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.attributedPlaceholder = NSAttributedString(string: "Phone numbe".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        tf.addTarget(self, action: #selector(PhoneEditingDidEnd), for: .editingDidEnd)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1)
        return tf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    func SetUpPhoneNumber() {
    listController.setup(repository: PhoneNumberTF.countryRepository)
    listController.didSelect = { [weak self] country in
    self?.PhoneNumberTF.setFlag(countryCode: country.code)
    }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    print(name, dialCode, code)
    }
    
    var isValidNumber = false
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    PhoneNumberTF.layer.borderColor = isValid ?  #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1).cgColor : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).cgColor
    PhoneNumberTF.PhoneLabel.alpha = isValid ? 0 : 1
    isValidNumber = isValid
    }
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Select your country".localizable
        listController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCountries))
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCountries))
        listController.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        listController.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        listController.searchController.searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        listController.searchController.searchBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        navigationViewController.modalPresentationStyle = .fullScreen
        navigationViewController.modalTransitionStyle = .coverVertical
        present(navigationViewController, animated: true)
    }
    
    @objc func refreshCountries() {
    listController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func dismissCountries() {
    listController.dismiss(animated: true, completion: nil)
    }
    
    @objc func PhoneEditingDidEnd() {
    PhoneNumberTF.layer.borderColor = #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1)
    PhoneNumberTF.PhoneLabel.alpha = 0
    }
    
    
    lazy var GenderTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.IconImage = UIImage(named: "Path")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.Icon.addTarget(self, action: #selector(ActionGender), for: .touchUpInside)
        tf.addTarget(self, action: #selector(ActionGender), for: .editingDidBegin)
        tf.attributedPlaceholder = NSAttributedString(string: "Gender".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionGender() {
    GenderTF.resignFirstResponder()
    let title = "Gender".localizable
    let attributeString = NSMutableAttributedString(string: title)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)],//3
                                                  range: NSMakeRange(0, title.utf8.count))
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    alertController.setValue(attributeString, forKey: "attributedTitle")
    alertController.addAction(UIAlertAction(title: "Male".localizable, style: .default , handler: { (_) in
    self.GenderTF.text = "Male".localizable
    }))
 

    alertController.addAction(UIAlertAction(title: "FeMale".localizable, style: .default , handler: { (_) in
    self.GenderTF.text = "FeMale".localizable
    }))
        
    alertController.view.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
    present(alertController, animated: true)
    }
    
//    let underlinedMessage = NSMutableAttributedString(string: "Forgot password?", attributes: [
//        .font: UIFont(name: "Raleway-Bold", size: ControlWidth(12)) ?? UIFont.systemFont(ofSize: ControlWidth(12)),
//        .foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1),
//        NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue
//        ])
//
//    Button.setAttributedTitle(underlinedMessage, for: .normal)
//    Button.contentHorizontalAlignment = .left
//    Button.backgroundColor = .clear
    

    lazy var CheckboxButton : Checkbox = {
        let Button = Checkbox(type: .system)
        let underlinedMessage = NSMutableAttributedString(string: "I agree to Terms of Service and Privacy Policy".localizable, attributes: [
        .font: UIFont(name: "Muli", size: ControlWidth(11)) ?? UIFont.systemFont(ofSize: ControlWidth(11)),
        .foregroundColor: #colorLiteral(red: 0.7036916041, green: 0.7036916041, blue: 0.7036916041, alpha: 1),
        .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        Button.Label.attributedText = underlinedMessage
        Button.Label.backgroundColor = .clear
        return Button
    }()

    lazy var SignIn : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Sign Up".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSignIn), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignIn() {
    if FirstNameTF.NoError() && EmailTF.NoError() && PasswordTF.NoError() && PasswordTF.NoErrorPassword() && EmailTF.NoErrorEmail() && PhoneNumberTF.NoError() && isValidNumber && GenderTF.NoError() {
    if CheckboxButton.Button.tag != 1 {
    CheckboxButton.Shake()
    }else{
    let OTP = OTPController()
    OTP.SignUp = self
    Present(ViewController: self, ToViewController: OTP)
    }
    }
    }
    
    lazy var SignUpNow : UIButton = {
        let Button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString(string: "Already a member?".localizable, attributes: [
            .font: UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: UIColor.black
        ])
        
        attributedString.append(NSAttributedString(string: "     ", attributes: [
            .font: UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: "Sign In".localizable, attributes: [
            .font: UIFont(name: "Muli-SemiBold", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
            .foregroundColor: #colorLiteral(red: 0.06105268747, green: 0.1525729597, blue: 0.5339061618, alpha: 1)
        ]))
        
        Button.contentHorizontalAlignment = .center
        Button.setAttributedTitle(attributedString, for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionSignUpNow), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignUpNow() {
    self.navigationController?.popViewController(animated: true)
    }

}

