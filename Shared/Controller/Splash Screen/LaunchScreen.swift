//
//  LaunchScreen.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 27/12/2021.
//

import UIKit
import FirebaseAuth

class LaunchScreen: ViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUp()
        Device()
        view.backgroundColor = #colorLiteral(red: 0.9116356969, green: 0.9114078879, blue: 0.9287173748, alpha: 1)
    }
    
    func SetUp() {
        LogoImage.frame = CGRect(x: ControlX(40), y: view.center.y - ControlHeight(140), width: view.frame.width - ControlWidth(80), height: ControlHeight(280))
        view.addSubview(LogoImage)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LogoImage.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
        self.LogoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        }
    }
    
    lazy var LogoImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.layer.masksToBounds = true
        ImageView.image = UIImage(named: "Logo")
        return ImageView
    }()

    
    var token : JWT?
    func Device(_ ShowDots:Bool = false) {
    IfNotUser()
    guard let url = defaults.string(forKey: "API") else{return}
    let api = "\(url + AddDevice)"
    
    let lang = "lang".localizable
    let modelName = UIDevice.modelName
    let version = UIDevice.current.systemVersion
    let fireToken = defaults.string(forKey: "fireToken")  ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
    let parameters:[String:Any] = ["token": "07XkreQli3noSErCb_J7r3i4C9mTfsM_bf-7q8v2ikg",
                                   "lang": lang,
                                   "fireToken": fireToken,
                                   "deviceID": udid,
                                   "deviceModel": modelName,
                                   "manufacturer": "IOS",
                                   "osVersion": version,
                                   "versionCode": "1"]
     
    if ShowDots {self.ViewDots.beginRefreshing()}
    PostAPI(api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.token = JWT(dictionary: data)
    self.ViewDots.endRefreshing(){}
    self.perform(#selector(self.Presentd), with: self, afterDelay: 1)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.perform(#selector(self.Presentd), with: self, afterDelay: 2)
    }
    }
    
    
    func IfNotUser() {
    if getUserObject().SqlId == nil {
    do {
    try Auth.auth().signOut()
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
    if key == "User" || key == "Cart" {
    defaults.removeObject(forKey: key)
    }
    }
    }catch let signOutErr {
    print(signOutErr.localizedDescription)
    }
    }
    }
    
    @objc func Presentd() {
     let Controller = TabBarController()
     Controller.modalPresentationStyle = .fullScreen
     Controller.modalTransitionStyle = .crossDissolve
     present(Controller, animated: true)
    }
    
}
