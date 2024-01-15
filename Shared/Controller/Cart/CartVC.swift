//
//  CartVC.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 29/12/2021.
//

import UIKit
import SDWebImage

class CartVC: ViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CartDelegate, CartFooterDelegate {
                 

    static let PostProductDetails = NSNotification.Name(rawValue: "ProductDetails")
    override func viewDidLoad() {
        super.viewDidLoad()

    view.backgroundColor = .white
        
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Cart".localizable, ShowSearch: true, ShowShopping: true)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
    view.addSubview(CollectionCart)
    CollectionCart.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))
        
//    GetCartItems()
        
        GetCartItemsONLine()
    }
    
    
    let CartId = "CartId"
    let FooterId = "FooterId"
    lazy var CollectionCart: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(20)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true
        vc.register(CartCell.self, forCellWithReuseIdentifier: CartId)
        vc.register(CartFooter.self, forCellWithReuseIdentifier: FooterId)
        vc.contentInset = UIEdgeInsets(top: ControlX(10), left: 0, bottom: ControlX(10), right: 0)
        return vc
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
        return ItemsCart.Items.count
        }else{
        return 1
        }
    }
    
    var currentPrice: Double = 0
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartId, for: indexPath) as! CartCell
        let Items = ItemsCart.Items[indexPath.row]
            
        cell.ImageItem.sd_setImage(with: URL(string: Items.image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        cell.Title.text = Items.title ?? ""
        cell.CategoryName.text = Items.categoryName ?? ""
            
        let price = "lang".localizable == "en" ? Items.price : Items.price?.NumAR()
        cell.Price.text = "\(price ?? "") \("EGP".localizable)"
        cell.ColorView.backgroundColor = Items.Color?.hexStringToUIColor()
            
        let Size = "lang".localizable == "en" ? Items.SizeTitle:Items.SizeTitle?.NumAR()
        cell.SizeView.setTitle(Size ?? "", for: .normal)
            
        cell.AddToCartView.value = Double(Items.ItemCount ?? 1)
        let limit = Items.limit?.toDouble() ?? 0 != 0 ? Items.limit?.toDouble() ?? 0 : 10
        cell.AddToCartView.maximumValue = limit
            
        cell.AddToCartView.alpha = Items.outOfStock ?? false ? 0:1
        cell.LabelOutOfStock.alpha = Items.outOfStock ?? false ? 1:0
        cell.Title.alpha = Items.outOfStock ?? false ? 0.5:1
        cell.CategoryName.alpha = Items.outOfStock ?? false ? 0.5:1
        cell.Price.alpha = Items.outOfStock ?? false ? 0.5:1
        cell.ColorView.alpha = Items.outOfStock ?? false ? 0.5:1
        cell.SizeView.alpha = Items.outOfStock ?? false ? 0.5:1
        cell.ImageItem.alpha = Items.outOfStock ?? false ? 0.5:1
        cell.ImageItem.alpha = Items.outOfStock ?? false ? 0.5:1
   
        cell.HeartAnimate(isFavourite:Items.isFav ?? false)
        cell.Delegate = self
        return cell
        }else{
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterId, for: indexPath) as! CartFooter
        let Items = "lang".localizable == "en" ? "\(ItemsCart.Items.count)":"\(ItemsCart.Items.count)".NumAR()
            
        let Total = "lang".localizable == "en" ? "\(currentPrice)":"\(currentPrice)".NumAR()
        cell.ProceedToItems.setTitle("\("Proceed to buy".localizable) \(Items) \("items".localizable)", for: .normal)
        cell.SubtotalLabel.text = "\("Subtotal".localizable) \(Total) \("EGP".localizable)"
        cell.Delegate = self
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
    return CGSize(width: collectionView.frame.width - ControlX(20), height: ControlWidth(190))
    }else{
    return CGSize(width: collectionView.frame.width, height: ControlWidth(140))
    }
    }
    
    func ActionProceed() {
//    if getUserObject().Uid == nil {
//    ShowMessageAlert("warning", "Log In First".localizable, "You are not logged in yet, please login first in order to continue".localizable, false, self.GoToLogIn, "Go LogIn".localizable)
//    }else{
    let Checkout = CheckoutVC()
    Checkout.ItemsCart = ItemsCart
    Present(ViewController: self, ToViewController: Checkout)
//    }
    }
    
    func SelectHeart(_ Cell: CartCell) {
    if let index = CollectionCart.indexPath(for: Cell) {
    let UrlAddOrRemove = ItemsCart.Items[index.item].isFav == false ? AddItemFavourite : RemoveItemFavourite
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + UrlAddOrRemove)"

    guard let uid = getUserObject().Uid else{return}
    guard let ItemId = ItemsCart.Items[index.item].itemId else{return}
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
                    
    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "itemId": ItemId]
                 
    Cell.heart.isUserInteractionEnabled = false
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ItemsCart.Items[index.item].isFav = !(self.ItemsCart.Items[index.item].isFav ?? false)
        
    if getUserObject().Uid == nil {
    AddCart(Items:self.ItemsCart.Items[index.item],Style:.UpDate)
    }
    
    Cell.heart.isUserInteractionEnabled = true
    self.CollectionCart.reloadItems(at: [index])
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    Cell.heart.isUserInteractionEnabled = true
    if error != "" {ShowMessageAlert("warning","Error".localizable, error, true){}}
    }
    }
    }
    
    func GoToLogIn() {
    Present(ViewController: self, ToViewController: SignInController())
    }
    
    func AddValueToCart(_ Cell: CartCell) {
    if Cell.AddToCartView.value == 0 {
    RemoveFromCart(Cell)
    }else if Cell.AddToCartView.value >= 1 {
    SaveToCart(Cell,Style: .UpDate)
    }
    }
    
    func removeToCart(_ Cell: CartCell) {
    ShowMessageAlert("warning", "Warning Remove Cart".localizable, "Are You Sure You Want to Delete this Item From Cart".localizable, false, {self.RemoveFromCart(Cell)}, "Delete".localizable)
    }
    
    func RemoveFromCart(_ Cell: CartCell) {
    Cell.AddToCartView.value = 0
    if getUserObject().Uid == nil {
    SaveToCart(Cell,Style: .Remove)
    }else{
    TimerUpdateONLine(Cell, time: 0)
    }
    }
    
    func SaveToCart(_ Cell: CartCell ,Style:CartStyle) {
    if let index = self.CollectionCart.indexPath(for: Cell) {
    let Item = self.ItemsCart.Items[index.item]
        
    if getUserObject().Uid == nil {
    let Count = Int(Cell.AddToCartView.value)
            AddCart(Items: CartItems(itemId: Item.itemId, title: Item.title,
            image: Item.image, price: Item.price,outOfStock: Item.outOfStock,
            limit: Item.limit, isFav: Item.isFav,categoryId: Item.categoryId ,
            categoryName: Item.categoryId, ColorId: Item.ColorId,ColorTitle: Item.ColorTitle,
            Color: Item.Color, SizeId: Item.SizeId, SizeTitle: Item.SizeTitle, ItemCount: Count) ,Style:Style)
        
    SetCartCount()
    NotificationCenter.default.post(name: CartVC.PostProductDetails, object: nil)
    }else{
    TimerUpdateONLine(Cell, time: 2)
    }
        
    if Int(Cell.AddToCartView.value) == 0 {
    ItemsCart.Items.remove(at: index.item)
    CollectionCart.deleteItems(at: [index])
    CollectionCart.reloadSections(IndexSet(integer: 0))
    if ItemsCart.Items.count == 0 {
    NoCartProducts()
    }
    }
        
    Item.ItemCount = Int(Cell.AddToCartView.value)
    GetTotal()
    CollectionCart.reloadSections(IndexSet(integer: 1))
    }
    }

    func GetCartItems() {
        if getUserObject().Uid == nil {
        GetCartItemsOffLine()
        }else{
        GetCartItemsONLine()
        }
    }
    
    var ItemsCart = CartGet(dictionary: [String : Any]())
    func GetCartItemsOffLine() {
    if let ItemsArray = defaults.array(forKey: "ItemsCart") as? [[String:Any]] {
    ItemsArray.forEach { Array in
    ViewNoData.isHidden = true
    CollectionCart.isHidden = false
    ItemsCart.Items.append(CartItems(OffLine: Array))
    GetTotal()
    if ItemsArray.count == self.ItemsCart.Items.count {
    self.CollectionCart.SetAnimations()
    }
    }
    }
    NoCartProducts()
    }
    
    func GetTotal() {
    currentPrice = 0
    for Items in ItemsCart.Items {
    if let price = Items.price?.toDouble() , let Count = Items.ItemCount {
    currentPrice += price * Double(Count)
    }
    }
    }
    
    var CartAccount : Account?
    func GetCartItemsONLine() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//        
//    let api = "\(url + GetCartDetails)"
//
//    guard let uid = getUserObject().Uid else{return}
//    guard let Id = getCartObject()?.id else{return}
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//                        
//    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                    "Platform": "I",
//                                    "uid": uid,
//                                    "deviceID": udid,
//                                    "lang": lang,
//                                    "cartId": Id]

    ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["cart" : ["id" : "1","SubtotalPrice" : "45.000","ShippingPrice" : "50.000","totalPrice" : "50.000"
                    ,"Items" :
                    [
                        ["itemId" : "1","title" : "Camra","image" : "https://i.pinimg.com/236x/83/7c/28/837c281e69b735d1ec0b6495dc0da027.jpg","price" : "5.000","oldPrice" : "5.500","outOfStock" : false
                        ,"limit" : "3","rating" : "4.3","isFavourite" : true,"categoryId" : "","categoryName" : "camra"
                        ,"ItemCount" : 1 , "color" : [ "id" : "1","title" : "blue","color" : "#17202A"],
                         "size" : ["id" : "1","title" : "64 Px"]],
                        
                        ["itemId" : "1","title" : "laptop","image" : "https://media.wired.com/photos/64daad6b4a854832b16fd3bc/master/pass/How-to-Choose-a-Laptop-August-2023-Gear.jpg","price" : "25.000","oldPrice" : "26.500","outOfStock" : true
                        ,"limit" : "2","rating" : "3.3","isFavourite" : false,"categoryId" : "","categoryName" : "laptop"
                        ,"ItemCount" : 1, "color" : [ "id" : "1","title" : "red","color" : "#C0392B"],
                         "size" : ["id" : "1","title" : "13-in"]],
                        
                        ["itemId" : "1","title" : "desktop","image" : "https://images-eu.ssl-images-amazon.com/images/I/711Oh7-BzdL._AC_UL600_SR600,600_.jpg","price" : "15.000","oldPrice" : "17.500","outOfStock" : false
                        ,"limit" : "3","rating" : "4.3","isFavourite" : true,"categoryId" : "","categoryName" : "desktop"
                        ,"ItemCount" : 1, "color" : [ "id" : "1","title" : "black","color" : "#0d0d0d"],
                         "size" : ["id" : "1","title" : "19-in"]]
                    ]
        
        ]] as [String : Any]
          

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.CartAccount = Account(dictionary: data)
            self.ItemsCart = getCartObject() ?? CartGet(dictionary: [String : Any]())
            self.GetTotal()

            self.ViewNoData.isHidden = true
            self.CollectionCart.isHidden = false
            self.CollectionCart.SetAnimations()
            self.ViewDots.endRefreshing(){}
            self.NoCartProducts()
        }
        

        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.CollectionCart.isHidden = true
//    self.SetUpIsError(error,true) {self.GetCartItemsONLine()}
//    }
    }
    
    
    var timer:Timer?
    var value:Double?
    var IndexSelect : IndexPath?
    func TimerUpdateONLine(_ Cell: CartCell,time:TimeInterval) {
    if let index = self.CollectionCart.indexPath(for: Cell) {
    timer?.invalidate()
    IndexSelect = index
    value = Cell.AddToCartView.value
    timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(UpdateCartONLine), userInfo: nil, repeats: false)
    }
    }
    
    @objc func UpdateCartONLine() {
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + UpdateCartItem)"

    guard let Id = getCartObject()?.id else{return}
    guard let uid = getUserObject().Uid else{return}
    guard let value = value else{return}
    let lang = "lang".localizable
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    guard let Index = IndexSelect?.item else{return}
    guard let itemId = ItemsCart.Items[Index].itemId else{return}
                            
    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "lang": lang,
                                    "itemId": itemId,
                                    "cartId": Id,
                                    "itemCount": value]
        
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.CartAccount = Account(dictionary: data)
    self.ItemsCart = getCartObject() ?? CartGet(dictionary: [String : Any]())

    self.ViewNoData.isHidden = true
    self.CollectionCart.isHidden = false
    self.CollectionCart.reloadData()
    self.ViewDots.endRefreshing(){}
    self.SetCartCount()
    self.GetTotal()
    self.NoCartProducts()
    NotificationCenter.default.post(name: CartVC.PostProductDetails, object: nil)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
    func NoCartProducts()  {
        if self.ItemsCart.Items.count == 0 {
        ViewDots.endRefreshing(){}
        CollectionCart.isHidden = true
        ViewNoData.isHidden = false
        ViewNoData.ImageIcon = "Compare"
        ViewNoData.RefreshButton.isHidden = true
        ViewNoData.MessageTitle = "No Products Found".localizable
        ViewNoData.MessageDetails = "You haven’t added any products to your Cart list, shop now and add".localizable
        }
    }

}
