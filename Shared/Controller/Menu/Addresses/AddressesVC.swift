//
//  AddressesVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 12/03/2022.
//

import UIKit

class AddressesVC: ViewController , UITableViewDelegate, UITableViewDataSource ,MyAddressesDelegate {

    var Checkout : CheckoutVC?
    let AddressesId = "Addresses"
    var AddressesData = [Addresses]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(Dismiss)
        SetUpDismiss(text: "Addresses".localizable)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
        SetMyAddresses()
    }
    
    lazy var FooterView:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()
    
    lazy var AddNewButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("＋ Add new address".localizable, for: .normal)
        Button.backgroundColor = .white
        Button.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.contentEdgeInsets.bottom = 1
        Button.layer.borderWidth = ControlWidth(1)
        Button.layer.cornerRadius = ControlWidth(20)
        Button.titleLabel?.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionAddNew), for: .touchUpInside)
        Button.setTitleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), for: .normal)
        return Button
    }()
    
    
    @objc func ActionAddNew() {
    let AddAddress = AddAddressVC()
    AddAddress.isValidNumber = false
    AddAddress.SetUpDismiss(text: "Add Address".localizable)
    AddAddress.SaveAddressButton.setTitle("Save Address".localizable, for: .normal)
    Present(ViewController: self, ToViewController: AddAddress)
    }
    
    lazy var ProceedToSummary : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Proceed to summary".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSaveChanges), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionSaveChanges() {
    self.navigationController?.popViewController(animated: true)
    }
    
    func SetUpFooterView(FromCheckout:Bool) {
        view.addSubview(TableView)
        view.addSubview(FooterView)
        FooterView.addSubview(AddNewButton)
        if !FromCheckout {
        FooterView.frame = CGRect(x: 0, y: view.frame.maxY - ControlWidth(90), width: view.frame.width, height: ControlWidth(60))
        AddNewButton.frame = CGRect(x: view.frame.maxX - ControlWidth(205), y: ControlY(10), width: ControlWidth(190), height: ControlWidth(40))
        TableView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(170))
        }else{
        FooterView.addSubview(ProceedToSummary)
        FooterView.frame = CGRect(x: 0, y: view.frame.maxY - ControlWidth(140), width: view.frame.width, height: ControlWidth(110))
        AddNewButton.frame = CGRect(x: view.frame.maxX - ControlWidth(205), y: ControlY(8), width: ControlWidth(190), height: ControlWidth(40))
        ProceedToSummary.frame = CGRect(x: ControlX(15), y: AddNewButton.frame.maxY + ControlY(10), width: FooterView.frame.width - ControlX(30), height: ControlWidth(50))
        TableView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(220))
        }
    }
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.estimatedRowHeight = 80
        tv.tableFooterView?.isHidden = true
        tv.rowHeight = UITableView.automaticDimension
        tv.register(AddressesCell.self, forCellReuseIdentifier: AddressesId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(10), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddressesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressesId, for: indexPath) as! AddressesCell
        cell.selectionStyle = .none
        cell.Delegate = self
        cell.LabelName.text = AddressesData[indexPath.row].Name
        cell.LabelDetails.text = AddressesData[indexPath.row].landmark
        cell.LabelPhone.text = AddressesData[indexPath.row].phone
        cell.CheckboxButton.Select(IsSelect: AddressesData[indexPath.row].IsDefault ?? false ,text: "Set as default shipping address".localizable)
        return cell
    }
    
    func CheckBoxAction(cell: AddressesCell) {
    if let Index = TableView.indexPath(for: cell) {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let api = "\(url + ChangeDefaultAddress)"
//        
//    guard let uid = getUserObject().Uid else{return}
//    guard let AddressId = AddressesData[Index.row].id else{return}
//        
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//
//    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                    "Platform": "I",
//                                    "uid": uid,
//                                    "deviceID": udid,
//                                    "lang": lang,
//                                    "AddressId": AddressId]
    ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.AddressesData.forEach{ $0.IsDefault = false }
            self.AddressesData[Index.row].IsDefault = true
            self.TableView.reloadData()
            self.ViewDots.endRefreshing() {}
            if let Check = self.Checkout {
                Check.SetAddressDetails()
            }
        }
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ViewDots.endRefreshing(error, .error) {}
//    }
    }
    }
    
    
    func EditAction(cell: AddressesCell) {
    if let Index = TableView.indexPath(for: cell) {
    let AddAddress = AddAddressVC()
    AddAddress.isValidNumber = true
    AddAddress.IndexEdit = Index
    AddAddress.AddressesController = self
    AddAddress.Dismiss.TextDismiss = "Edit Address".localizable
    AddAddress.AddressesDetails = AddressesData[Index.row]
    AddAddress.SaveAddressButton.setTitle("Save Edit".localizable, for: .normal)
    Present(ViewController: self, ToViewController: AddAddress)
    }
    }
    
    var AddressId : String?
    var SelectIndexTrash = IndexPath()
    func TrashAction(cell: AddressesCell) {
    if let Index = TableView.indexPath(for: cell) {
    SelectIndexTrash = Index
    AddressId = AddressesData[Index.row].id
    ShowMessageAlert("warning", "Warning".localizable, "Are You Sure You Want to Delete this Addresses".localizable, false, self.ActionDelete, "Delete".localizable)
    }
    }
    
    @objc func ActionDelete() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//        
//    let api = "\(url + DeleteAddresses)"
//    guard let uid = getUserObject().Uid else{return}
//    guard let AddressId = AddressId else{return}
//
//    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                     "Platform": "I",
//                                     "uid": uid,
//                                     "addressId": AddressId]
    ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ViewDots.endRefreshing() {}
            self.TableView.beginUpdates()
            self.AddressesData.remove(at: self.SelectIndexTrash.item)
            self.TableView.deleteRows(at: [self.SelectIndexTrash], with: .right)
            self.TableView.endUpdates()
            
            self.SetUpNoContent()
        }
        
        
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    if error != "" {
//    self.ViewDots.endRefreshing() {ShowMessageAlert("warning", "Error".localizable, error, false, self.ActionDelete)}
//    }else{
//    self.ViewDots.endRefreshing() {}
//    }
//    }
    }
    
    
    func SetMyAddresses() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    guard let uid = getUserObject().Uid else{
//    SetUpLogInFirst()
//    return
//    }
//    let lang = "lang".localizable
//    let api = "\(url + GetAddresses)"
//        
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                    "Platform": "I",
//                                    "lang": lang,
//                                    "uid": uid]
//             
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
            ["id" : "","Name" : "My house 1","phone" : "01204474410","streetName" : "street Name","buildingNumber" : "building Number","floorNumber" : "floor Number","landmark" : "landmark"
                             ,"IsDefault" : true
                             ,"lat" : "Test lat"
                             ,"lon" : "Test lon"],
        
            ["id" : "","Name" : "My house 2","phone" : "01204474410","streetName" : "street Name","buildingNumber" : "building Number","floorNumber" : "floor Number","landmark" : "landmark"
                             ,"IsDefault" : false
                             ,"lat" : "Test lat"
                             ,"lon" : "Test lon"],
        
            ["id" : "","Name" : "My house 3","phone" : "01204474410","streetName" : "street Name","buildingNumber" : "building Number","floorNumber" : "floor Number","landmark" : "landmark"
                             ,"IsDefault" : false
                             ,"lat" : "Test lat"
                             ,"lon" : "Test lon"],
        
            ["id" : "","Name" : "My house 4","phone" : "01204474410","streetName" : "street Name","buildingNumber" : "building Number","floorNumber" : "floor Number","landmark" : "landmark"
                             ,"IsDefault" : false
                             ,"lat" : "Test lat"
                             ,"lon" : "Test lon"],
        
            ["id" : "","Name" : "My house 5","phone" : "01204474410","streetName" : "street Name","buildingNumber" : "building Number","floorNumber" : "floor Number","landmark" : "landmark"
                             ,"IsDefault" : false
                             ,"lat" : "Test lat"
                             ,"lon" : "Test lon"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            for item in data {
                self.AddressesData.append(Addresses(dictionary: item))
                if self.AddressesData.count == data.count {
                    self.TableView.SetAnimations()
                }
            }
            
            self.TableView.isHidden = false
            self.ViewNoData.isHidden = true
            self.ViewDots.endRefreshing(){}
            self.FooterView.isHidden = false
            self.SetUpNoContent()
        }
//    } Err: { error in
//    self.TableView.isHidden = true
//    self.FooterView.isHidden = true
//    self.SetUpIsError(error,true) {self.SetMyAddresses()}
//    }
    }
        
    func SetUpNoContent() {
    if AddressesData.count == 0 {
    ViewNoData.isHidden = false
    ViewNoData.TextRefresh = "Add new address".localizable
    ViewNoData.MessageTitle = "No Content".localizable
    ViewNoData.MessageDetails = "You haven’t added any places yet, add new places now".localizable
    FooterView.isHidden = true
    ViewNoData.RefreshButton.addTarget(self, action: #selector(ActionAddNew), for: .touchUpInside)
    }
    }
    
    func SetUpLogInFirst() {
    ViewNoData.isHidden = false
    ViewNoData.TextRefresh = "Go LogIn".localizable
    ViewNoData.MessageTitle = "Log In First".localizable
    ViewNoData.MessageDetails = "You are not logged in yet, please login first in order to continue".localizable
    FooterView.isHidden = true
    ViewNoData.RefreshButton.addTarget(self, action: #selector(LogInFirst), for: .touchUpInside)
    }
    
    @objc func LogInFirst() {
    Present(ViewController: self, ToViewController: SignInController())
    }
}
