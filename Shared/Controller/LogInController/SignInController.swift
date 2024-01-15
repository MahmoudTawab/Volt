//
//  SignInController.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

class SignInController: ViewController {

    var AccountData : Account?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9116356969, green: 0.9114078879, blue: 0.9287173748, alpha: 1)
 
        ViewScroll.frame = view.bounds
        view.addSubview(ViewScroll)
    
        LogoImage.frame = CGRect(x: view.center.x - ControlWidth(90), y: ControlX(-10), width: ControlWidth(200), height: ControlWidth(180))
        ViewScroll.addSubview(LogoImage)

        ViewScroll.addSubview(ContentView)
        ContentView.frame = CGRect(x: ControlX(20), y: view.frame.maxY , width: view.frame.width - ControlX(40), height: ControlWidth(470))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.65, options: []) {
        self.ContentView.frame = CGRect(x: ControlX(20), y: self.LogoImage.frame.maxY - ControlX(10), width: self.view.frame.width - ControlX(40), height: ControlWidth(470))
        }
        self.ViewScroll.updateContentViewSize(ControlX(-10))
        }
        
        SetUp()
    }
    
    func SetUp() {
        
        let StackForgotPassword = UIStackView(arrangedSubviews: [UIView(),ForgotPassword])
        StackForgotPassword.axis = .horizontal
        StackForgotPassword.spacing = ControlWidth(20)
        StackForgotPassword.distribution = .fillEqually
        StackForgotPassword.alignment = .fill
        StackForgotPassword.backgroundColor = .clear
    
        let StackLogin = UIStackView(arrangedSubviews: [Facebook,Google])
        StackLogin.axis = .horizontal
        StackLogin.spacing = ControlWidth(20)
        StackLogin.distribution = .fillEqually
        StackLogin.alignment = .fill
        StackLogin.backgroundColor = .clear
        
        let Stack = UIStackView(arrangedSubviews: [SignInLabel,EmailTF,PasswordTF,StackForgotPassword,StackLogin,SignIn,SignInNow])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(25)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        ContentView.addSubview(Stack)
        Stack.frame = CGRect(x: ControlX(20), y: ControlX(10), width: ContentView.frame.width - ControlX(40), height: ContentView.frame.height - ControlX(20))
        
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
        Label.text = "Sign In".localizable
        Label.font = UIFont(name: "Muli-SemiBold" ,size: ControlWidth(25))
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
  
    lazy var PasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
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
    
    lazy var ForgotPassword : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionForgotPasswor)))
        
        let underlinedMessage = NSMutableAttributedString(string: "Forgot password?".localizable, attributes: [
        .font: UIFont(name: "Muli", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
        .foregroundColor: #colorLiteral(red: 0.7036916041, green: 0.7036916041, blue: 0.7036916041, alpha: 1),
        .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        Label.attributedText = underlinedMessage
        Label.backgroundColor = .clear
        return Label
    }()
    
    @objc func ActionForgotPasswor() {
    Present(ViewController: self, ToViewController: ResetPassword())
    }

    lazy var Google : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setImage(UIImage(named: "Google"), for: .normal)
        Button.clipsToBounds = true
        Button.setTitle("   Google".localizable, for: .normal)
        Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        Button.layer.borderWidth = ControlWidth(1)
        Button.contentHorizontalAlignment = .center
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 25)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(13))
        Button.addTarget(self, action: #selector(ActionGoogle), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionGoogle() {
        SignInGoogle()
    }

    lazy var Facebook : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.setImage(UIImage(named: "Facebook"), for: .normal)
        Button.setTitle("   Facebook".localizable, for: .normal)
        Button.backgroundColor = #colorLiteral(red: 0.2763792276, green: 0.3948143721, blue: 0.6395198107, alpha: 1)
        Button.tintColor = .white
        Button.clipsToBounds = true
        Button.contentHorizontalAlignment = .center
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 25)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(13))
        Button.addTarget(self, action: #selector(ActionFacebook), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionFacebook() {
        SignFacebook()
    }
    
    
    lazy var SignIn : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Sign In".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSignIn), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignIn() {
    if EmailTF.NoError() && PasswordTF.NoError() && PasswordTF.NoErrorPassword() && EmailTF.NoErrorEmail() {
        
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
    let loginApi = "\(url + login)"
            
    guard let email = EmailTF.text else {return}
    guard let password = PasswordTF.text else {return}
        
    ViewDots.beginRefreshing()
    Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
    if let err = err {
    self.ViewDots.endRefreshing(err.localizedDescription, .error) {}
    return
    }
    
    guard let UID = user?.user.uid else{return}
    let lang = "lang".localizable
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    let parameters:[String:Any] = ["appID": "bee4a01a-7260-4e33-a315-fe623f223846",
                                   "platform": "i",
                                   "uid": UID,
                                   "lang": lang,
                                   "deviceID": udid,
                                   "cart": GetCartOffLine()]
        
    PostAPI(api: loginApi, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    defaults.set("E", forKey: "SocialLogin")

    self.ViewDots.endRefreshing() {
    FirstController(TabBarController())
    }

    } ArrayOfDictionary: { _ in
    } Err: { (error) in
    self.ViewDots.endRefreshing() {ShowMessageAlert("warning", "Error".localizable, error, false, self.ActionSignIn)}
    }
    }
    }
    }

    
    func LoginSocial(_ uid:String ,_ Social:String ,_ email:String ,_ phone:String ,_ ProfileUrl:URL? ,_ lastName:String ,_ firstName:String) {
        
    guard let url = defaults.string(forKey: "API") else {return}
    let token = defaults.string(forKey: "JWT") ?? ""
    let loginSocial = "\(url + loginSocial)"
        
    let lang = "lang".localizable
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appID": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "platform": "i",
                                    "uid": uid,
                                    "lang": lang,
                                    "deviceID": udid,
                                    "cart": GetCartOffLine()]
        
    PostAPI(api: loginSocial, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.AccountData = Account(dictionary: data)
    let IsUser = self.AccountData?.IsUser ?? false
    self.IfIsUser(IsUser,uid,Social,email,phone,ProfileUrl,lastName,firstName)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
    func IfIsUser(_ IsUser:Bool,_ uid:String ,_ Social:String ,_ email:String ,_ phone:String ,_ ProfileUrl:URL? ,_ lastName:String ,_ firstName:String) {
    if !IsUser {
    let SignUp = SignUpController()
    SignUp.uid = uid
    SignUp.ProfileImageUrl = ProfileUrl
    SignUp.EmailTF.text = email
    SignUp.LastNameTF.text = lastName
    SignUp.FirstNameTF.text = firstName
    SignUp.PhoneNumberTF.text = phone
    defaults.set(Social, forKey: "SocialLogin")
    SignUp.SignInLabel.text = "Complete Sign Up Information".localizable
    Present(ViewController: self, ToViewController: SignUp)

    self.ViewDots.endRefreshing() {}
    }else{
    self.ViewDots.endRefreshing() {
    FirstController(TabBarController())
    }
    }
    }
    
    lazy var SignInNow : UIButton = {
        let Button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString(string: "Not a member yet?".localizable, attributes: [
            .font: UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: UIColor.black
        ])
        
        attributedString.append(NSAttributedString(string: "     ", attributes: [
            .font: UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)),
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: "Sign Up".localizable, attributes: [
            .font: UIFont(name: "Muli-SemiBold", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
            .foregroundColor: #colorLiteral(red: 0.06105268747, green: 0.1525729597, blue: 0.5339061618, alpha: 1)
        ]))
        
        Button.contentHorizontalAlignment = .center
        Button.setAttributedTitle(attributedString, for: .normal)
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionSignInNow), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSignInNow() {
    let SignUp = SignUpController()
    SignUp.SignInLabel.text = "Sign Up".localizable
    Present(ViewController: self, ToViewController: SignUp)
    }
    
}


// Sign in Google
extension SignInController {
    func SignInGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in

        if error != nil {
        return
        }
            
        guard let accessToken = user?.user.accessToken.tokenString , let idToken = user?.user.idToken?.tokenString
        else {
        return
        }

        guard let User = user?.user.profile else { return }
        let emailAddress = User.email
        let givenName = User.givenName ?? ""
        let familyName = User.familyName ?? ""
        let profilePicUrl = User.imageURL(withDimension: 320)
    //  let fullName = user.name

            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
        Auth.auth().signIn(with: credential) { authResult, error in
        self.ViewDots.beginRefreshing()
            
        if let error = error {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        guard let uid = authResult?.user.uid else { return }
        self.LoginSocial(uid, "G", emailAddress ,"" , profilePicUrl , familyName, givenName)
        }
        }
    }
}
// Sign in Facebook
extension SignInController {
    func SignFacebook() {
        LoginManager().logIn(permissions: ["email"], from: self) { (result,err) in
        if let error = err {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

            
        if result?.isCancelled == true {return}
        guard let accessToken = AccessToken.current else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)

        Auth.auth().signIn(with: credential) { authResult, error in
        if let error = error {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        self.ViewDots.beginRefreshing()
        GraphRequest(graphPath: "/me", parameters: ["fields": "email, first_name, last_name, name, picture.width(480).height(480)"]).start { (connection,result,err) in
        if let Error = err {
        self.ViewDots.endRefreshing(Error.localizedDescription, .error) {}
        return
        }
            
        if let data = result as? NSDictionary {
        guard let uid = authResult?.user.uid else { return }
        let firstName  = data.object(forKey: "first_name") as? String ?? ""
        let lastName  = data.object(forKey: "last_name") as? String ?? ""
        let email = data.object(forKey: "email") as? String ?? ""

        let profilePictureObj = data.object(forKey: "picture") as? NSDictionary
        let data = profilePictureObj?.value(forKey: "data") as? NSDictionary
        let pictureUrlString = data?.value(forKey: "url") as? String
        let pictureUrl = URL(string: pictureUrlString ?? "")

        self.LoginSocial(uid, "F", email ,"" ,pictureUrl , lastName, firstName)
      }
      }
      }
      }
    }
}
