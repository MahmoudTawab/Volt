//
//  CheckoutVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 21/03/2022.
//

import UIKit
import SDWebImage

class CheckoutVC: ViewController ,UITableViewDelegate , UITableViewDataSource , CheckoutVoucherDelegate, CheckoutAddressDelegate {
        
    var ItemsCart = CartGet(dictionary: [String : Any]())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(Dismiss)
        SetUpDismiss(text: "Checkout", ShowSearch: true, ShowShopping: true)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))

        view.addSubview(TableView)
        TableView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
        
        TableView.tableFooterView = FooterView
        FooterView.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: ControlWidth(90))
        
        FooterView.addSubview(ConfirmOrderButton)
        ConfirmOrderButton.frame = CGRect(x: ControlX(15), y: ControlX(20), width: view.frame.width - ControlX(30), height: ControlWidth(50))
        
        SetAddressDetails()
    }
    

    let AddressId = "AddressId"
    let PaymentId = "PaymentId"
    let ShipmentId = "ShipmentId"
    let VoucherId = "VoucherId"
    let PriceId = "PriceId"
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.register(CheckoutAddress.self, forCellReuseIdentifier: AddressId)
        tv.register(CheckoutPayment.self, forCellReuseIdentifier: PaymentId)
        tv.register(CheckoutShipment.self, forCellReuseIdentifier: ShipmentId)
        tv.register(CheckoutVoucher.self, forCellReuseIdentifier: VoucherId)
        tv.register(CheckoutPrice.self, forCellReuseIdentifier: PriceId)
        return tv
    }()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
        return 1
        case 1:
        return 1
        case 2:
        return ItemsCart.Items.count
        case 3:
        return 1
        case 4:
        return 3
        default:
        return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressId, for: indexPath) as! CheckoutAddress
        cell.selectionStyle = .none
        if AddressesData != nil {
        cell.Selection.isHidden = false
        cell.AddNewButton.isHidden = true
        cell.LabelNoAddress.isHidden = true

        cell.LabelName.text = AddressesData?.Name
        cell.LabelDetails.text = AddressesData?.landmark
        cell.LabelPhone.text = AddressesData?.phone
        }else{
        cell.Delegate = self
        cell.Selection.isHidden = true
        cell.AddNewButton.isHidden = false
        cell.LabelNoAddress.isHidden = false
        }
        return cell
        case 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentId, for: indexPath) as! CheckoutPayment
        cell.selectionStyle = .none
        return cell
        case 2:
        let cell = tableView.dequeueReusableCell(withIdentifier: ShipmentId, for: indexPath) as! CheckoutShipment
        cell.selectionStyle = .none
        let Items = ItemsCart.Items[indexPath.row]
        cell.LabelName.text = Items.title
        cell.LabelPrice.text = "EGP \(Items.price ?? "")"
        cell.LabelDetails.text = Items.categoryName
        cell.ImageItem.sd_setImage(with: URL(string: Items.image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
        case 3:
        let cell = tableView.dequeueReusableCell(withIdentifier: VoucherId, for: indexPath) as! CheckoutVoucher
        cell.selectionStyle = .none
        cell.Delegate = self
        return cell
        case 4:
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceId, for: indexPath) as! CheckoutPrice
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
        cell.FirstValue.text = "Subtotal"
        cell.SecondValue.text = "EGP \(ItemsCart.SubtotalPrice ?? "")"
        cell.ViewLine.isHidden = true
        case 1:
        cell.FirstValue.text = "Shipping"
        cell.SecondValue.text = "EGP \(ItemsCart.ShippingPrice ?? "")"
        cell.ViewLine.isHidden = true
        case 2:
        cell.FirstValue.text = "Total"
        cell.SecondValue.text = "EGP \(ItemsCart.totalPrice ?? "")"
        cell.ViewLine.isHidden = false
        default:
        break
        }
        return cell
        default:
        return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
        return ControlWidth(150)
            
        case 1:
        return ControlWidth(70)
            
        case 2:
        return ControlWidth(150)
            
        case 3:
        return ControlWidth(70)
            
        case 4:
        return ControlWidth(50)
        default:
        return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0,1,2,3:
        return ControlWidth(40)
        default:
        return ControlWidth(20)
        }
    }
    
    var SectionName = ["Address Details","Payment Method","Shipment Details","Voucher",""]
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = SectionName[section]
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(16))
        Label.translatesAutoresizingMaskIntoConstraints = false
        
        let Button = UIButton()
        Button.tag = section
        Button.backgroundColor = .clear
        if section == SectionName.count - 1 || section == SectionName.count - 2 {
        Button.isHidden = true
        }else{
        Button.isHidden = false
        }
        
        Button.setBackgroundImage(UIImage(named: "EditAddresses")?.withInset(UIEdgeInsets(top: 0.6, left: 0.6, bottom: 0.6, right: 0.6)), for: .normal)
        Button.addTarget(self, action: #selector(ActionEdit(_:)), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(Label)
        Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlX(10)).isActive = true
        Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlWidth(-40)).isActive = true
        
        view.addSubview(Button)
        Button.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlX(14)).isActive = true
        Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(26)).isActive = true
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(26)).isActive = true
        
        return view
    }
    
    @objc func ActionEdit(_ button:UIButton) {
    switch button.tag {
    case 0:
    let Addresses = AddressesVC()
    Addresses.Checkout = self
    Addresses.SetUpFooterView(FromCheckout:true)
    Present(ViewController: self, ToViewController: Addresses)
    case 1:
    print(button.tag)
    case 2:
    self.navigationController?.popViewController(animated: true)
    default:
    break
    }
    }
    
    
    func ApplyAction(cell: CheckoutVoucher) {
        
    }
    
    func AddNewAddress() {
    let AddAddress = AddAddressVC()
    AddAddress.Checkout = self
    Present(ViewController: self, ToViewController: AddAddress)
    }
    
    /// Set Up FooterView
    lazy var FooterView:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()
    
    lazy var ConfirmOrderButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Confirm Order", for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.addTarget(self, action: #selector(ActionConfirmOrder), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        return Button
    }()
    
    @objc func ActionConfirmOrder() {
    if AddressesData == nil {
    ShowMessageAlert("warning", "Error".localizable, "You don’t have any added address yet".localizable, false, self.AddNewAddress, "New Address".localizable)
    }
    }
    
    var AddressesData : Addresses?
    func SetAddressDetails() {
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + GetDefaultAddressDetails)"

    guard let uid = getUserObject().Uid else{return}
    let lang = "lang".localizable
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
                        
    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "lang": lang]
    ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.AddressesData = Addresses(dictionary: data)
    self.TableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    self.ViewDots.endRefreshing(){}
    } ArrayOfDictionary: { _ in
    } Err: { _ in
    self.ViewDots.endRefreshing(){}
    }
    }
    

}
