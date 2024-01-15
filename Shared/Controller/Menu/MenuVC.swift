//
//  MenuVC.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 29/12/2021.
//

import UIKit
import FirebaseAuth

class MenuVC: ViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
        
    let MenuId = "Menu"
    var MenuImage = ["Menu1","Menu2","Menu3","Menu4","Menu5","Menu6","Menu7","Menu8","Menu9","Menu10","About","Menu11","Menu12"]
    var MenuArray = ["","My Orders".localizable,"Installments Settings".localizable,"Addresses".localizable,"Wallet".localizable,"Wishlist".localizable,"Compare".localizable,"Returns".localizable,"Recently Viewed".localizable,"Help".localizable,"AboutUs".localizable,"Contact Us".localizable,"Settings".localizable]
    

    override func viewDidLoad() {
    super.viewDidLoad()
    SetUpCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MenuCollection.SetAnimations()
    }

    fileprivate func SetUpCollectionView() {
    view.backgroundColor = .white
      
    view.addSubview(LabelMenu)
    LabelMenu.frame = CGRect(x: ControlX(20), y: ControlY(30) , width: view.frame.width - ControlWidth(40), height: ControlHeight(30))
        
    view.addSubview(MenuCollection)
    MenuCollection.frame = CGRect(x: 0, y: LabelMenu.frame.maxY + ControlY(10) , width: view.frame.width, height: view.frame.height - ControlHeight(130))
        
    self.IfLogin()
    }
    
    lazy var LabelMenu : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.text = "Menu".localizable
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(20))
        return Label
    }()
    
    lazy var MenuCollection: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        vc.register(MenuCell.self, forCellWithReuseIdentifier: MenuId)
        return vc
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuId, for: indexPath) as! MenuCell

    cell.MenuLabel.text = MenuArray[indexPath.row]
    cell.ImageView.image = UIImage(named: MenuImage[indexPath.row])
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: ControlWidth(60))
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
    if let Cell = MenuCollection.cellForItem(at: indexPath) as? MenuCell {
    let Controller = Cell.MenuLabel.text == "Sign In".localizable ? SignInController() : ProfileVC()
    Present(ViewController: self, ToViewController: Controller)
    }
    case 1:
        print("1")
    case 2:
        print("2")
    case 3:
    let Addresses = AddressesVC()
    Addresses.SetUpFooterView(FromCheckout:false)
    Present(ViewController: self, ToViewController: Addresses)
    case 4:
    Present(ViewController: self, ToViewController: WalletVC())
    case 5:
//    if getUserObject().Uid  != nil {
    let Item = ItemCategories()
    Item.GetOtherItems(Other: .Wishlist)
    Item.SetUpDismiss(text: "Wishlist".localizable)
    Present(ViewController: self, ToViewController: Item)
//    }else{
//    ShowMessageAlert("warning", "Log In First".localizable, "You are not logged in yet, please login first in order to continue".localizable, false, self.GoToLogIn, "Go LogIn".localizable)
//    }
    case 6:
    Present(ViewController: self, ToViewController: CompareVC())
    case 7:
        print("7")
    case 8:
    let Item = ItemCategories()
    Item.GetOtherItems(Other: .RecentlyViewed)
    Item.SetUpDismiss(text: "Recently Viewed".localizable)
    Present(ViewController: self, ToViewController: Item)
    case 9:
    Present(ViewController: self, ToViewController: HelpVC())
    case 10:
    Present(ViewController: self, ToViewController: AboutVC())
    case 11:
    Present(ViewController: self, ToViewController: ContactUsVC())
    case 12:
    Present(ViewController: self, ToViewController: SettingsVC())
    case 13:
    ShowMessageAlert("warning", "Logout".localizable, "Are You Sure You Want to log out of your account".localizable, false, self.ActionLogout , "Logout".localizable)
    default: break}
    }
    
    @objc func GoToLogIn() {
    Present(ViewController: self, ToViewController: SignInController())
    }
    
    
    @objc func ActionLogout() {
        self.ViewDots.beginRefreshing()
        do {
        try Auth.auth().signOut()
            
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
        if key != "API" && key != "Url" && key != "WhatsApp" && key != "fireToken"  {
        defaults.removeObject(forKey: key)
        }
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.ViewDots.endRefreshing() {
        FirstController(LaunchScreen())
        self.IfLogin()
        }
        }
    
        }catch let signOutErr {
        self.ViewDots.endRefreshing(signOutErr.localizedDescription, .error) {}
        }
    }

    func IfLogin() {
        if getUserObject().SqlId != nil {
        MenuArray[0] = "Profile".localizable
        MenuImage.append("Menu13")
        MenuArray.append("Log out".localizable)
        MenuCollection.reloadData()
        }else{
        MenuArray[0] = "Sign In".localizable
        MenuImage.removeAll(where: {$0 == "Menu13"})
        MenuArray.removeAll(where: {$0 == "Log out".localizable})
        MenuCollection.reloadData()
        }
    }
}
