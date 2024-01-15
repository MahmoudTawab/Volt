//
//  ContactUsVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit
import FlagPhoneNumber

class ContactUsVC: ViewController ,FPNTextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUp()
    }
    
    fileprivate func SetUp() {
        
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Contact Us".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
        
    let StackVertical = UIStackView(arrangedSubviews: [NameTF,EmailTF,PhoneNumberTF])
    StackVertical.axis = .vertical
    StackVertical.spacing = ControlWidth(48)
    StackVertical.distribution = .fillEqually
    StackVertical.alignment = .fill
    StackVertical.backgroundColor = .clear
    ViewScroll.addSubview(StackVertical)
    StackVertical.frame = CGRect(x: ControlX(15), y: ControlY(25) , width: view.frame.width - ControlWidth(30), height: ControlWidth(240))
            
    ViewScroll.addSubview(TextView)
    TextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
    TextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
    TextView.topAnchor.constraint(equalTo: StackVertical.bottomAnchor, constant: ControlX(48)).isActive = true
    TextView.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true

    ViewScroll.addSubview(SendButton)
    SendButton.leadingAnchor.constraint(equalTo: TextView.leadingAnchor).isActive = true
    SendButton.trailingAnchor.constraint(equalTo: TextView.trailingAnchor).isActive = true
    SendButton.topAnchor.constraint(equalTo: TextView.bottomAnchor, constant: ControlY(40)).isActive = true
    SendButton.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
    SetUpPhoneNumber()
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .white
        Scroll.keyboardDismissMode = .interactive
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height - ControlHeight(90))
        return Scroll
    }()

    lazy var NameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Full name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "E-mail".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.TitleHidden = false
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
    
    lazy var TextView : GrowingTextView = {
    let TV = GrowingTextView()
    TV.placeholder = "Message".localizable
    TV.minHeight = ControlWidth(50)
    TV.maxHeight = ControlWidth(200)
    TV.placeholderColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)
    TV.font = UIFont(name: "Muli", size: ControlWidth(15))
    TV.backgroundColor = .clear
    TV.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    TV.clipsToBounds = true
    TV.textColor = .black
    TV.autocorrectionType = .no
    TV.layer.borderColor = #colorLiteral(red: 0.8661956191, green: 0.8661957383, blue: 0.8661957383, alpha: 1)
    TV.layer.borderWidth = ControlWidth(0.8)
    TV.translatesAutoresizingMaskIntoConstraints = false
    return TV
    }()

    lazy var SendButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Send Message".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSendMessage), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSendMessage() {
    if NameTF.NoError() && EmailTF.NoError() && EmailTF.NoErrorEmail() && PhoneNumberTF.NoError() && isValidNumber && TextView.NoError() {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let Name = NameTF.text else{return}
    guard let Email = EmailTF.text else{return}
    guard let Message = TextView.text else{return}
    guard let phone = PhoneNumberTF.text else{return}
    guard let Uid = getUserObject().Uid else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + AddContactUs)"
        
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "platform": "I",
                                    "deviceID": udid,
                                    "email": Email,
                                    "message": Message,
                                    "mobile": phone,
                                    "name": Name,
                                    "uid": Uid]
            
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing("Success Send Your Message".localizable, .success) {
    self.NameTF.text = ""
    self.EmailTF.text = ""
    self.TextView.text = ""
    self.PhoneNumberTF.text = ""
    }
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    }
}
