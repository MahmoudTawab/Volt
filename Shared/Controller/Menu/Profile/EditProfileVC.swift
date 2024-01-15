//
//  EditProfileVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 07/03/2022.
//

import UIKit
import FlagPhoneNumber

class EditProfileVC: ViewController ,FPNTextFieldDelegate {
    
    var ProfileData : ProfileVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUp()
        SetData()
    }
    
    fileprivate func SetUp() {
        
    view.addSubview(ViewScroll)
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Edit Profile".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))

    ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
    
    let StackVertical = UIStackView(arrangedSubviews: [EmailTF,FirstNameTF,LastNameTF,PhoneNumberTF,GenderTF])
    StackVertical.axis = .vertical
    StackVertical.spacing = ControlWidth(48)
    StackVertical.distribution = .fillEqually
    StackVertical.alignment = .fill
    StackVertical.backgroundColor = .clear
    ViewScroll.addSubview(StackVertical)
    StackVertical.frame = CGRect(x: ControlX(15), y: ControlY(25) , width: view.frame.width - ControlX(30), height: ControlWidth(430))
        
    ViewScroll.addSubview(SaveChangesButton)
    SaveChangesButton.frame = CGRect(x: ControlX(15), y: StackVertical.frame.maxY  + ControlX(30) , width: view.frame.width - ControlX(30), height: ControlWidth(50))
        
    SetUpPhoneNumber()
    ViewScroll.updateContentViewSize(0)
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .white
        Scroll.keyboardDismissMode = .interactive
        return Scroll
    }()

    lazy var FirstNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "First Name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var LastNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Last Name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.alpha = 0.5
        tf.isEnabled = false
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
    
    var isValidNumber = true
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
        tf.TitleHidden = false
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
    
    lazy var SaveChangesButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Save Changes".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSaveChanges() {
    if FirstNameTF.NoError() && EmailTF.NoError() && EmailTF.NoErrorEmail() && PhoneNumberTF.NoError() && !isValidNumber && GenderTF.NoError() {
    }else{
    if GenderTF.text == ProfileData?.GenderTF.text &&
    EmailTF.text == ProfileData?.EmailTF.text &&
    FirstNameTF.text == ProfileData?.FirstNameTF.text &&
    LastNameTF.text == ProfileData?.LastNameTF.text &&
    PhoneNumberTF.text == ProfileData?.PhoneNumberTF.text {
    ShowMessageAlert("warning","Error".localizable, "There is no change in the data".localizable, true){}
    }else{
    if PhoneNumberTF.text != ProfileData?.PhoneNumberTF.text {
    let OTPUpdate = OTPUpdateProfile()
    OTPUpdate.ProfileSettings = self
    OTPUpdate.modalPresentationStyle = .overFullScreen
    OTPUpdate.modalTransitionStyle = .crossDissolve
    present(OTPUpdate, animated: true)
    }else{
    ProfileSaveChanges()
    }
    }
    }
    }
    

    func ProfileSaveChanges() {
    let LastName = LastNameTF.text ?? ""
    guard let Email = EmailTF.text else{return}
    guard let FirstName = FirstNameTF.text else{return}
    guard let PhoneNumber = PhoneNumberTF.text else{return}
    guard let gender = self.GenderTF.text == "Male".localizable ? 1:0 else{return}
        
    guard let url = defaults.string(forKey: "API") else{return}
    guard let uid = getUserObject().Uid else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + EditProfile)"
    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid ,
                                    "Email": Email,
                                    "fName": FirstName,
                                    "lName": LastName,
                                    "gender": gender,
                                    "Phone": PhoneNumber]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.ProfileData?.SetProfile()
    self.ViewDots.endRefreshing("Success Save Changes".localizable, .success) {}
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.SetUpIsError(error,false) {}
    }
    }
    
    func SetData()  {
    GenderTF.text = ProfileData?.GenderTF.text ?? ""
    EmailTF.text = ProfileData?.EmailTF.text ?? "E-mail".localizable
    FirstNameTF.text = ProfileData?.FirstNameTF.text ?? "First Name".localizable
    LastNameTF.text = ProfileData?.LastNameTF.text ?? "Last Name".localizable
    PhoneNumberTF.text = ProfileData?.PhoneNumberTF.text ?? "Phone numbe".localizable
    }
}
