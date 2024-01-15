//
//  NotificationSettingsVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit

class NotificationSettingsVC: ViewController {
    
    var Notifications:NotificationsSettings?
    override func viewDidLoad() {
    super.viewDidLoad()
    SetUpTableView()
    }

    fileprivate func SetUpTableView() {
    view.backgroundColor = .white
        
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Notification Settings".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
                
    view.addSubview(SwitchStack)
        SwitchStack.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width - ControlX(30), height: ControlWidth(140))
        
    }
    
    lazy var SwitchStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [AllowNotifications,NewsletterSubscription])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    var NotificationsIsOn = Bool()
    lazy var AllowNotifications:SwitchView = {
        let View = SwitchView()
        View.SettIngsLabel.text = "Allow Notifications".localizable
        View.Switch.isOn = Notifications?.ReceiveNotifications ?? getUserObject().ReceiveNotifications ?? false
        View.Switch.thumbTintColor = View.Switch.isOn == true ? #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.Switch.addTarget(self, action: #selector(UpdateAllowNotifications), for: .valueChanged)
        return View
    }()
    
    @objc func UpdateAllowNotifications() {
    NotificationsIsOn = AllowNotifications.Switch.isOn
    UpdateNotifications()
    }
    
    var letterSubscriptionIsOn = Bool()
    lazy var NewsletterSubscription:SwitchView = {
        let View = SwitchView()
        View.SettIngsLabel.text = "Newsletter Subscription".localizable
        View.Switch.isOn = Notifications?.ReceiveEmail ?? getUserObject().ReceiveEmail ?? false
        View.Switch.thumbTintColor = View.Switch.isOn == true ? #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.Switch.addTarget(self, action: #selector(UpdateletterSubscription), for: .valueChanged)
        return View
    }()
    
    @objc func UpdateletterSubscription() {
    letterSubscriptionIsOn = NewsletterSubscription.Switch.isOn
    UpdateNotifications()
    }
    
    @objc func UpdateNotifications() {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let Uid = getUserObject().Uid else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + UpdateReceiveNotifications)"
            
    let parameters:[String:Any] = ["appId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "platform": "I",
                                    "uid": Uid,
                                    "ReceiveNotifications": NotificationsIsOn,
                                    "ReceiveEmail": letterSubscriptionIsOn]
                
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.SetProfile()
    self.Notifications = NotificationsSettings(dictionary: data)
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing(){}
    self.SwitchStack.isHidden = false
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.SwitchStack.isHidden = true
    self.SetUpIsError(error,true) {self.UpdateNotifications()}
    }
    }
    
    var UpdateProfile:Profile?
    func SetProfile() {
    guard let url = defaults.string(forKey: "API") else{return}
    guard let uid = getUserObject().Uid else{return}
    let token = defaults.string(forKey: "JWT") ?? ""

    let api = "\(url + GetProfile)"
    
    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid]
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.UpdateProfile = Profile(dictionary: data)
    } ArrayOfDictionary: { _ in
    } Err: { _ in
    }
    }
}

