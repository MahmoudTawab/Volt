//
//  LanguageVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit

class LanguageVC: ViewController {
    
    override func viewDidLoad() {
    super.viewDidLoad()
    SetUpTableView()
    }

    fileprivate func SetUpTableView() {
    view.backgroundColor = .white
        
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Language".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
                
    view.addSubview(SwitchStack)
        SwitchStack.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width - ControlX(30), height: ControlWidth(140))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetLang(localizable:"lang".localizable)
    }
    
    lazy var SwitchStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Arabic,English])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var Arabic:SwitchView = {
        let View = SwitchView()
        View.SettIngsLabel.text = "Arabic".localizable
        View.Switch.addTarget(self, action: #selector(ActionArabic), for: .valueChanged)
        return View
    }()
    
    @objc func ActionArabic() {
        if MOLHLanguage.currentAppleLanguage() == "en" {
        MOLH.setLanguageTo("ar")
        SetLang(localizable:"ar")
        ViewDots.beginRefreshing()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
        self.ViewDots.endRefreshing() {MOLH.reset(duration: 0.5)}
        }
        }
    }

    lazy var English:SwitchView = {
        let View = SwitchView()
        View.SettIngsLabel.text = "English".localizable
        View.Switch.addTarget(self, action: #selector(ActionEnglish), for: .valueChanged)
        return View
    }()
    
    @objc func ActionEnglish() {
        if MOLHLanguage.currentAppleLanguage() == "ar" {
        MOLH.setLanguageTo("en")
        SetLang(localizable:"en")
        ViewDots.beginRefreshing()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
        self.ViewDots.endRefreshing() {MOLH.reset(duration: 0.5)}
        }
        }
    }

    func SetLang(localizable:String) {
    Arabic.Switch.isOn = localizable == "ar" ? true:false
    English.Switch.isOn = localizable != "ar" ? true:false
    Arabic.Switch.thumbTintColor = Arabic.Switch.isOn == true ? #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    English.Switch.thumbTintColor = English.Switch.isOn == true ? #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
}

