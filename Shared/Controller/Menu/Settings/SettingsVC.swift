//
//  SettingsVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit
import FirebaseAuth

class SettingsVC: ViewController , UITableViewDelegate, UITableViewDataSource {
    
    let SettingsId = "Setting"
    var SettingsArray = ["Change Password".localizable,"Language".localizable,"Notification Settings".localizable]
    override func viewDidLoad() {
    super.viewDidLoad()
    SetUpTableView()
    TableView.SetAnimations()
    }
    
    fileprivate func SetUpTableView() {
    view.backgroundColor = .white
        
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Settings".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
            
    view.addSubview(TableView)
    TableView.frame = CGRect(x: ControlX(15), y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width - ControlX(30), height: view.frame.height - ControlHeight(80))
    }

    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.register(SettingsCell.self, forCellReuseIdentifier: SettingsId)
        return tv
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return SettingsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SettingsId, for: indexPath) as! SettingsCell
    cell.selectionStyle = .none
    cell.SettIngsLabel.text = SettingsArray[indexPath.row]
        
    return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
    return getUserObject().SqlId == nil ? 0 : ControlWidth(50)
    }else{
    return ControlWidth(50)
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
    Present(ViewController: self, ToViewController: ChangePasswordVC())
    case 1:
    Present(ViewController: self, ToViewController: LanguageVC())
    case 2:
    Present(ViewController: self, ToViewController: NotificationSettingsVC())
    default: break}
    }


}
