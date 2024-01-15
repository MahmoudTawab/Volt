//
//  ProfileVC.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 30/12/2021.
//

import UIKit

class ProfileVC: ViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUp()
        SetProfile()
    }
    
    fileprivate func SetUp() {
        
    view.addSubview(ViewScroll)
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Profile".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
    ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
        
    let StackVertical = UIStackView(arrangedSubviews: [EmailTF,FirstNameTF,LastNameTF,PhoneNumberTF,GenderTF])
    StackVertical.axis = .vertical
    StackVertical.spacing = ControlWidth(50)
    StackVertical.distribution = .fillEqually
    StackVertical.alignment = .fill
    StackVertical.backgroundColor = .clear
    ViewScroll.addSubview(StackVertical)
    StackVertical.frame = CGRect(x: ControlX(15), y: ControlY(25) , width: view.frame.width - ControlX(30), height: ControlWidth(400))
        
    ViewScroll.addSubview(SaveChangesButton)
    SaveChangesButton.frame = CGRect(x: ControlX(15), y: StackVertical.frame.maxY  + ControlX(30) , width: view.frame.width - ControlX(30), height: ControlWidth(50))
                
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.keyboardDismissMode = .interactive
        Scroll.backgroundColor = .white
        Scroll.isHidden = true
        return Scroll
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
        tf.layer.borderWidth = 0
        tf.attributedPlaceholder = NSAttributedString(string: "E-mail".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    lazy var PhoneNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.layer.borderWidth = 0
        tf.attributedPlaceholder = NSAttributedString(string: "Phone numbe".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var GenderTF : FloatingTF = {
        let tf = FloatingTF()
        tf.layer.borderWidth = 0
        tf.attributedPlaceholder = NSAttributedString(string: "Gender".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    func AddBorder(_ TF:FloatingTF,_ text:String) {
        TF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: TF.frame.height))
        TF.leftViewMode = .always

        TF.text = text
        TF.title.alpha = 1.0
        TF.isEnabled = false
        TF.TitleHidden = false
        TF.layer.borderWidth = 0

        let border = UIView()
        border.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        border.translatesAutoresizingMaskIntoConstraints = false
        TF.addSubview(border)
        border.bottomAnchor.constraint(equalTo: TF.bottomAnchor).isActive = true
        border.leadingAnchor.constraint(equalTo: TF.leadingAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: TF.trailingAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: ControlWidth(0.8)).isActive = true
    }
    
    lazy var SaveChangesButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Edit Profile".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSaveChanges() {
    let EditProfile = EditProfileVC()
    EditProfile.ProfileData = self
    Present(ViewController: self, ToViewController: EditProfile)
    }
    
    func SetProfile() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    guard let uid = getUserObject().Uid else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let api = "\(url + GetProfile)"    
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                    "Platform": "I",
//                                    "uid": uid]
         
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["user": [ "Uid": "",
                            "SqlId": "Mahmoud",
                            "fName": "Mahmoud",
                            "lName": "Tawab",
                            "gender": "1",
                            "Email": "Mahmoud@mail.com",
                            "phone": "01204474410",
                            "Photo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNkFR4p_Wq3oaLpiIVBj_CwERYCgjPEVf6Qpx0SryZsbfFkxGoYLbOmQ-7XqzQ57na4uY&usqp=CAU",
                            "ReceiveNotifications": true,
                            "ReceiveEmail": true]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.SetData(Profile(dictionary: data))
                
            self.ViewScroll.isHidden = false
            self.ViewNoData.isHidden = true
            self.ViewDots.endRefreshing(){}
        }

//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ViewScroll.isHidden = true
//    self.SetUpIsError(error,true) {self.SetProfile()}
//    }
    }
    
    func SetData(_ Data:Profile)  {
    AddBorder(PhoneNumberTF,Data.user?.phone ?? "Phone numbe".localizable)
    AddBorder(GenderTF, Data.user?.gender ?? "" == "1" ? "Male".localizable:"FeMale".localizable)
    AddBorder(EmailTF, Data.user?.Email ?? "E-mail".localizable)
    AddBorder(FirstNameTF, Data.user?.fName ?? "First Name".localizable)
    AddBorder(LastNameTF, Data.user?.lName ?? "Last Name".localizable)
    }
}
