//
//  OTPUpdateProfile.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 14/12/2021.
//

import UIKit

class OTPUpdateProfile: ViewController, UITextFieldDelegate {
    
    var ProfileSettings : EditProfileVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Number1TextField.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.ViewScroll.setContentOffset(CGPoint(x: 0, y: ControlWidth(160)), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ContentView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
        self.ContentView.transform = .identity
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.5, animations: {
    self.ContentView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }) { (End) in
    self.ContentView.transform = .identity
    }
    }

    func SetUp() {
        
        ViewScroll.frame = view.bounds
        view.addSubview(ViewScroll)
        
        ContentView.frame = CGRect(x: ControlX(15), y: view.center.y - ControlWidth(220), width: view.frame.width - ControlX(30), height: ControlWidth(420))
        ViewScroll.addSubview(ContentView)

        OTPLabel.frame = CGRect(x: ControlX(20),y: ControlX(10), width: ContentView.frame.width - ControlX(40),height: ControlWidth(160))
        ContentView.addSubview(OTPLabel)
        
        
        let StackTF = UIStackView(arrangedSubviews: [Number1TextField,Number2TextField,Number3TextField,Number4TextField])
        StackTF.axis = .horizontal
        StackTF.spacing = 15
        StackTF.distribution = .fillEqually
        StackTF.alignment = .fill
        StackTF.backgroundColor = .clear
        StackTF.frame = CGRect(x: ControlX(20), y: OTPLabel.frame.maxY + ControlX(15), width: ContentView.frame.width - ControlX(40), height: ControlWidth(65))
        ContentView.addSubview(StackTF)
        
        IsnotCorrect.frame = CGRect(x: ControlX(20), y: StackTF.frame.maxY + ControlX(14), width: ContentView.frame.width - ControlX(40), height: ControlWidth(20))
        ContentView.addSubview(IsnotCorrect)
        
        let StackButton = UIStackView(arrangedSubviews: [ButtonBack,ValidateButton])
        StackButton.axis = .horizontal
        StackButton.spacing = ControlHeight(10)
        StackButton.distribution = .fillEqually
        StackButton.alignment = .fill
        StackButton.backgroundColor = .clear
        
        StackButton.frame = CGRect(x: ControlX(20), y: IsnotCorrect.frame.maxY + ControlX(10), width: ContentView.frame.width - ControlX(40), height: ControlWidth(45))
        ContentView.addSubview(StackButton)
        
        Labeltimer.frame = CGRect(x: ControlX(20), y: StackButton.frame.maxY + ControlX(15), width: ContentView.frame.width - ControlX(40), height: ControlWidth(30))
        ContentView.addSubview(Labeltimer)
    
        Number1TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Number2TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Number3TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Number4TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
               
        StartTimer()
        
        VerificationSend()
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5984370756)
        Scroll.keyboardDismissMode = .interactive
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height - ControlX(20))
        return Scroll
    }()
    

    lazy var ContentView:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = 10
        return View
    }()

    lazy var OTPLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(15)
        
        let style1 = NSMutableParagraphStyle()
        style1.lineSpacing = ControlWidth(7)
        
        let attributedString = NSMutableAttributedString(string: "Verification Code".localizable, attributes: [
            .font: UIFont(name: "Muli-SemiBold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.06105268747, green: 0.1525729597, blue: 0.5339061618, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .font: UIFont(name: "Muli-SemiBold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style1
        ]))

        attributedString.append(NSAttributedString(string: "Please enter the OTP that has been just sent to your mobile number".localizable, attributes: [
            .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style1
        ]))
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style1
        ]))

        if let PhoneNumber = ProfileSettings?.PhoneNumberTF.text {
        let Number = "lang".localizable == "en" ? PhoneNumber:PhoneNumber.NumAR()
        let Phone = String(Number.enumerated().map { $0 > 0 && $0 % 3 == 0 ? [" ",$1] : [$1]}.joined())
        attributedString.append(NSAttributedString(string: "\(Phone) -> ", attributes: [
            .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style1
        ]))
        }
        
        attributedString.append(NSAttributedString(string: "Edit Number".localizable, attributes: [
            .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) ,
            .paragraphStyle:style1
        ]))

        Label.numberOfLines = 4
        Label.attributedText = attributedString
        Label.backgroundColor = .clear
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:))))
        Label.isUserInteractionEnabled = true
        return Label
    }()
    
    @objc func tapLabel(_ gesture: UITapGestureRecognizer) {
    guard let text = OTPLabel.attributedText?.string else {return}

    guard let click_range = text.range(of: "Edit Number".localizable) else {return}
    if OTPLabel.didTapAttributedTextInLabel(gesture: gesture, inRange: NSRange(click_range, in: text)) {
    self.ProfileSettings?.PhoneNumberTF.becomeFirstResponder()
    self.navigationController?.popViewController(animated: true)
    }
    }
    
    lazy var Number1TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = .white
        tf.font = UIFont(name: "Muli-Bold", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    
    lazy var Number2TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = .white
        tf.font = UIFont(name: "Muli-Bold", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    
    lazy var Number3TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = .white
        tf.font = UIFont(name: "Muli-Bold", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    
    lazy var Number4TextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 1)
        tf.backgroundColor = .white
        tf.font = UIFont(name: "Muli-Bold", size: ControlWidth(30))
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        tf.keyboardAppearance = .light
        tf.layer.cornerRadius = ControlHeight(4)
        tf.layer.borderWidth = ControlHeight(1)
        tf.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        return tf
    }()
    

    @objc func textFieldDidChange(textField: UITextField) {
    let text = textField.text
            
    if let t: String = textField.text {
    textField.text = String(t.prefix(1))
    }
        
    if  text?.count == 1 {
    switch textField {
    case Number1TextField:
    Number2TextField.becomeFirstResponder()
    case Number2TextField:
        Number3TextField.becomeFirstResponder()
    case Number3TextField:
        Number4TextField.becomeFirstResponder()
    case Number4TextField:
        Number4TextField.resignFirstResponder()
    default:
    break
    }
    }
    if  text?.count == 0 {
    switch textField{
    case Number1TextField:
        Number1TextField.becomeFirstResponder()
    case Number2TextField:
        Number1TextField.becomeFirstResponder()
    case Number3TextField:
        Number2TextField.becomeFirstResponder()
    case Number4TextField:
        Number3TextField.becomeFirstResponder()
    default:
    break
    }
    }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    lazy var IsnotCorrect : UILabel = {
        let Label = UILabel()
        Label.alpha = 0
        Label.text = "OTP is not correct".localizable
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(15))
        Label.textColor = UIColor(red: 230 / 255.0, green: 96 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        Label.backgroundColor = .clear
        return Label
    }()
    
    lazy var ValidateButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Validate".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionValidate), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionValidate() {
    let Number = "\(random)"

    if let Number1 = Number1TextField.text ,let Number2 = Number2TextField.text ,let Number3 = Number3TextField.text , let Number4 = Number4TextField.text {
    let Text = Number1 + Number2 + Number3 + Number4
    
    if Text != Number || Text.count != 4 {
    Number1TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number2TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number3TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number4TextField.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    IsnotCorrect.alpha = 1
    }else{
    Number1TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number2TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number3TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number4TextField.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    IsnotCorrect.alpha = 0
        
    dismiss(animated: true)
    ProfileSettings?.ProfileSaveChanges()
    }
    }
    }
    
    lazy var Labeltimer : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = false
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LabelTimerAction)))
        return Label
    }()
    
    @objc func LabelTimerAction() {
        StartTimer()
        VerificationSend()
    }

    var timer = Timer()
    var newTimer = 120
    @objc func ActionLabeltimer()  {
    let Timer = "lang".localizable == "en" ? "\(timeFormatted(newTimer))" : "\(timeFormatted(newTimer))".NumAR()
    newTimer -= 1
    AttributedString(Labeltimer, "The code will be resend in".localizable, Timer, "sec".localizable, NSMakeRange(0,Labeltimer.text?.count ?? 0)
                     ,#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    Labeltimer.isUserInteractionEnabled = false
    if newTimer < -1 {
    let Text = "Resend OTP".localizable
        
    AttributedString(Labeltimer, Text, "", "", NSMakeRange(0,Text.count)
                     ,#colorLiteral(red: 0.8754453063, green: 0.2069860697, blue: 0.1997977495, alpha: 1))
    Labeltimer.isUserInteractionEnabled = true
    timer.invalidate()
    }
    }
    
    public func AttributedString(_ Label:UILabel,_ Text1:String,_ Text2:String,_ Text3:String,_ range: NSRange ,_ Color: UIColor) {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
        
    let underlinedMessage = NSMutableAttributedString(string: Text1 + " ", attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: Color,
    .paragraphStyle:style,
    .underlineStyle: NSUnderlineStyle.single.rawValue
    ])
    underlinedMessage.append(NSAttributedString(string: Text2 + " ", attributes: [
    .font: UIFont(name: "Muli-Bold" , size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: Color,
    .paragraphStyle:style
    ]))
    
    underlinedMessage.append(NSAttributedString(string: Text3, attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: Color,
    .paragraphStyle:style,
    .underlineStyle: NSUnderlineStyle.single.rawValue
    ]))
        
    Label.attributedText = underlinedMessage
    }
    

    
    func StartTimer() {
    newTimer = 120
    timer = Timer.scheduledTimer(timeInterval: 1 , target: self , selector:  #selector(ActionLabeltimer) , userInfo: nil , repeats:  true)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    let random = Int.random(in: 1000..<9999)
    func VerificationSend() {
    guard let url = defaults.string(forKey: "API") else{return}
    let Verification = "\(url + SendSms)"
          
    let lang = "lang".localizable
    guard let Profile = ProfileSettings else{return}
    guard let Phone = Profile.PhoneNumberTF.text else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let parameters:[String:Any] = ["lang": lang,
                                   "PhoneNumber": Phone,
                                   "VerificationMessage": "\(random)"]
          

    PostAPI(api: Verification, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    ShowMessageAlert("warning", "Error".localizable, error, false, self.VerificationSend)
    }
    }
    }
    
    
    lazy var ButtonBack : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.setTitle("Cancel".localizable, for: .normal)
        Button.layer.borderWidth = ControlWidth(1)
        Button.layer.cornerRadius = ControlWidth(25)
        Button.titleLabel?.font = UIFont(name: "Muli-Bold", size: ControlWidth(14))
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.addTarget(self, action: #selector(ActionBack), for: .touchUpInside)
        return Button
    }()
      
    
    @objc func ActionBack() {
     dismiss(animated: true)
    }
        
}
