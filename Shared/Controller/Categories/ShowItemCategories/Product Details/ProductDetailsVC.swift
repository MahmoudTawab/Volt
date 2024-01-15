//
//  ProductDetailsVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 14/02/2022.
//

import UIKit
import AVKit
import SDWebImage
import AVFoundation

class ProductDetailsVC: ViewController {

    var ProductId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        view.backgroundColor = .white
    }
    
     func SetUp() {
        view.addSubview(Dismiss)
        SetUpDismiss(text: "Product Details".localizable)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
            
        view.addSubview(ButtonCompare)
        ButtonCompare.frame = CGRect(x: view.frame.maxX - ControlX(70), y: view.frame.maxY - ControlX(70) , width: ControlWidth(54), height: ControlWidth(54))
        
        view.addSubview(tableView)
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlX(15)).isActive = true
        tableView.tableHeaderView = ViewScroll
        
        ViewScroll.addSubview(StackView)
        StackView.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: ControlWidth(230)).isActive = true
        StackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        StackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackView.topAnchor.constraint(equalTo: ViewScroll.topAnchor, constant: ControlX(20)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: ViewScroll.bottomAnchor , constant: ControlX(-20)).isActive = true

        ViewScroll.addSubview(heart)
        heart.topAnchor.constraint(equalTo: StackView.arrangedSubviews[2].topAnchor).isActive = true
        heart.trailingAnchor.constraint(equalTo: StackView.arrangedSubviews[2].trailingAnchor).isActive = true
        heart.widthAnchor.constraint(equalToConstant: ControlWidth(36)).isActive = true
        heart.heightAnchor.constraint(equalToConstant: ControlWidth(36)).isActive = true
        
        tableView.tableFooterView = FooterView
        FooterView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: ControlWidth(320))
        FooterView.addSubview(StackSimilarProducts)
        StackSimilarProducts.leadingAnchor.constraint(equalTo: FooterView.leadingAnchor,constant: ControlX(15)).isActive = true
        StackSimilarProducts.trailingAnchor.constraint(equalTo: FooterView.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackSimilarProducts.topAnchor.constraint(equalTo: FooterView.topAnchor, constant: ControlX(10)).isActive = true
        StackSimilarProducts.bottomAnchor.constraint(equalTo: FooterView.bottomAnchor , constant: ControlX(-10)).isActive = true
    }
    
    
    let TapId = "TapId"
    var Enum:EnumDetails = .Description
    let DescriptionId = "DescriptionId"
    let SpecificationsId = "SpecificationsId"

    var DataInstallments = [InstallmentsData]()
    let InstallmentsId = "InstallmentsCellId"
    
    var RatingCount = Int()
    let OverallRatingId = "OverallRatingId"
    let ReviewsRatingId = "ReviewsRatingId"
    let ReviewsViewAllId = "ReviewsViewAllId"
    let ReviewsCommentId = "ReviewsCommentId"
    let ButtonRatingTitle = ["5","4","3","2","1"]
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(TapMenuCell.self, forCellReuseIdentifier: TapId)
        tv.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionId)
        tv.register(SpecificationsCell.self, forCellReuseIdentifier: SpecificationsId)
        tv.register(InstallmentsCell.self, forCellReuseIdentifier: InstallmentsId)
        
        tv.register(OverallRating.self, forCellReuseIdentifier: OverallRatingId)
        tv.register(ReviewsViewAll.self, forCellReuseIdentifier: ReviewsViewAllId)
        tv.register(ReviewsRatingCell.self, forCellReuseIdentifier: ReviewsRatingId)
        tv.register(ReviewsCommentCell.self, forCellReuseIdentifier: ReviewsCommentId)
        return tv
    }()

    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.isScrollEnabled = false
        return Scroll
    }()
    
    lazy var StackView : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TitleLabel,BrandAndRating,ProductDetailsImage,pageControl,PriceAndVendor,LabelOldPrice,LabelDetails,LabelSKU,ColorStack,SizeStack,CompareAndCart,Tablelist])
    Stack.axis = .vertical
    Stack.spacing = ControlWidth(15)
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()


    func SetData() {
    guard let Data = Details else { return }

    TitleLabel.text = Data.title
    SetBrand(Data.brands?.title ?? "unknown".localizable)
    SetViewRating(Data.Rate)
    HeartAnimate(Data.isFavourite ?? false)

    pageControl.numberOfPages = Data.Images.count
    ProductDetailsImage.reloadData()

    LabelPrice.text = "\("EGP".localizable) \("lang".localizable == "en" ? Data.price ?? "":Data.price?.NumAR() ?? "")"
    SetVendor(Data.Vendor?.name ?? "unknown".localizable ,Data.Vendor?.show ?? false)
    SetOldPrice(oldPrice: Data.oldPrice ?? "", discount: Data.discount ?? "")
    SetSKU(Data.SKU ?? "")
    LabelDetails.text = Data.details

    if Data.outOfStock == false {
    if let Limit = Data.limit?.toDouble() ,let Stock = Data.stock?.toDouble() {
    let limit = Limit != 0 ? Limit : Stock
    AddToCartView.maximumValue = limit
    }
    }

    if let IndexColor = Data.Colors.firstIndex(where: {$0.id == Data.selectedColorId}) {
    ColorSelect = IndexPath(item: IndexColor, section: 0)
    self.ProductDetailsColor.reloadData()
    }

    if let IndexColor = Data.Sizes.firstIndex(where: {$0.id == Data.selectedSizeId}) {
    SizeSelect = IndexPath(item: IndexColor, section: 0)
    self.ProductDetailsSize.reloadData()
    }

    let Warranty = "lang".localizable == "en" ? Data.Warranty ?? "": Data.Warranty?.NumAR() ?? ""
    listTitle[0] = "\(Warranty)  \("years Warranty".localizable)"
    Tablelist.reloadData()

    SetDataInstallments(price: Data.price ?? "undefined".localizable)
    CollectionSimilarProducts.reloadData()
    SetCompare()
    Reload()
    }
    
    func SetDataInstallments(price:String) {
    DataInstallments.append(InstallmentsData(Duration: "12 Months".localizable, Installment: (price.toInt() ?? 0) / 12))
    DataInstallments.append(InstallmentsData(Duration: "24 Months".localizable, Installment: (price.toInt() ?? 0) / 24))
    DataInstallments.append(InstallmentsData(Duration: "36 Months".localizable, Installment: (price.toInt() ?? 0) / 36))
    DataInstallments.append(InstallmentsData(Duration: "48 Months".localizable, Installment: (price.toInt() ?? 0) / 48))
    }

    @objc func ReloadCart() {
    if let details = Details {IfInCart(details: details)}
    }

    func IfInCart(details:ItemDetails) {
    if getUserObject().Uid != nil {
    getCartObject()?.Items.forEach { Item in
    if Item.itemId == details.itemId {
    if let ItemCount = Item.ItemCount {
    AddToCartButton.alpha = ItemCount != 0 ? 0 : 1
    AddToCartView.alpha = ItemCount != 0 ? 1 : 0
    AddToCartView.value = ItemCount != 0 ? Double(ItemCount):0
    }
    }else{
    AddToCartButton.alpha = 1
    AddToCartView.alpha = 0
    }
    }
    }else{
    if let ItemsArray = defaults.array(forKey: "ItemsCart") as? [[String:Any]] {
    if ItemsArray.count == 0 {
    AddToCartButton.alpha = 1
    AddToCartView.alpha = 0
    }else{
    ItemsArray.forEach { Item in
    if Item.contains(where: {$0.value as? String == details.itemId}) {
    let ItemCount = Item["ItemCount"] as? Int
    AddToCartButton.alpha = ItemCount != 0 ? 0 : 1
    AddToCartView.alpha = ItemCount != 0 ? 1 : 0
    AddToCartView.value = ItemCount != 0 ? Double(ItemCount ?? 0):0
    }else{
    AddToCartButton.alpha = 1
    AddToCartView.alpha = 0
    }
    }
    }
    }
    }
    }

    var IndexSelectColor : IndexPath?
    var IndexSelectSize : IndexPath?
    func SelectColor(_ indexPath:IndexPath) {
    IndexSelectColor = indexPath
    if self.Details?.Colors[ColorSelect.item].id != self.Details?.Colors[indexPath.item].id {
    if let Item = self.Details ,let ColorsId = Item.Colors[indexPath.item].id, let SizesId = Item.Sizes[SizeSelect.item].id {
    self.SizeOrColorChang(isColorSelected: true, colorId: ColorsId, sizeId: SizesId)
    }
    }
    }

    func SelectSize(_ indexPath:IndexPath) {
    IndexSelectSize = indexPath
    if self.Details?.Sizes[SizeSelect.item].id != self.Details?.Sizes[indexPath.item].id {
    if let Item = self.Details ,let ColorsId = Item.Colors[ColorSelect.item].id, let SizesId = Item.Sizes[indexPath.item].id {
    self.SizeOrColorChang(isColorSelected: false, colorId: ColorsId, sizeId: SizesId)
    }
    }
    }

    var ChangDetails : ItemDetails?
    func SizeOrColorChang(isColorSelected:Bool,colorId:String,sizeId:String) {
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
    let api = "\(url + ChangeSizeOrColor)"

    let uid = getUserObject().Uid ?? ""
    let lang = "lang".localizable
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    guard let productId = Details?.productId else{return}

    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "lang": lang,
                                    "isColorSelected": isColorSelected,
                                    "colorId": colorId,
                                    "sizeId": sizeId,
                                    "productId": productId]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.ChangDetails = ItemDetails(dictionary: data)

    guard let Chang = self.ChangDetails else { return }
    guard let details = self.Details else { return }
    Chang.Description = details.Description
    Chang.SimilarItems = details.SimilarItems
    Chang.Specifications = details.Specifications
    Chang.brands = details.brands
    self.Details = Chang
    DispatchQueue.main.async {self.SetData()}
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }

    var Details : ItemDetails?
    func GetProduct(ProductId:String = GUID,isBarcode:Bool = false ,barcode:String = "") {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let uid = getUserObject().Uid ?? ""
//
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let api = "\(url + GetItemDetails)"
//
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "Platform": "I",
//                                   "lang": lang,
//                                   "uid": uid,
//                                   "deviceID": udid,
//                                   "isBarcode": isBarcode,
//                                   "barcode": barcode,
//                                   "itemId": ProductId]

    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["itemId" : "","price" : "40.000","oldPrice" : "36.000"
                            ,"discount" : "10%"
                            ,"isFavourite" : true
                            ,"SKU" : "iPhone"
                            ,"selectedColorId" : "1"
                            ,"selectedSizeId" : "1"
                            ,"cartCount" : "1"
                            ,"Warranty" : "12 Month"
                            ,"showStock" : false
                            ,"stock" : ""
                            ,"limit" : ""
                            ,"title" : "iPhone"
                            ,"details" : "iPhone 14 128GB Midnight 5G With FaceTime - International Version"
                            ,"productId" : ""
                            ,"categoryId" : ""
                            ,"categoryName" : "Mobile"
                            ,"subCategoryID" : "",

                    "brands": ["id":"","title":"iPhone"],
                    "vendor" : ["id" : "","name" : "Apple","show" : true],
                    "rate" : ["rating" : "3.5","oneStarsCount" : "10","twoStarsCount" : "20","threeStarsCount" : "15","fourStarsCount" : "12","fiveStarsCount" : "30"],
                    
                    "Description" : [["id" : "","title" : "iPhone 14","path" : "https://www.orange.lu/media/cache/catalog/product/a/p/700x700/apple_iphone_14_noir_dos.png","https" : "","mediaType": "I","details" : "The iPhone 14 display has rounded corners that follow a beautiful curved design, and these corners are within a standard rectangle. When measured as a standard rectangular shape, the screen is 6.06 inches diagonally "],
                                     
                            ["id" : "","title" : "iPhone 14","path" : "https://www.technogoyani.com/wp-content/uploads/2022/09/iPhone-14-5G-1024x538.webp","https" : "","mediaType": "I","details" : "The iPhone 14 display has rounded corners that follow a beautiful curved design, and these corners are within a standard rectangle. When measured as a standard rectangular shape, the screen is 6.06 inches diagonally "]],
                    
                    "Specifications" : [["feature":"Capacity","description":"256GB"],
                                        ["feature":"Size and Weight","description":"6.07 ounces (172 grams)"],
                                        ["feature":"Chip","description":"A15 Bionic chip"],
                                        ["feature":"Camera","description":"12MP Main: 26 mm"],
                                        ["feature":"Video Recording","description":"4K video recording"],
                                        ["feature":"Operating System","description":"iOS 17"]],
                    
                    "images" : [["id" : "","path" : "https://player.vimeo.com/external/494391483.sd.mp4?s=61426ecb752974cc8269703ccc599015b78ef79a&profile_id=165&oauth2_token_id=57447761","mediaType" : "V"],
                                ["id" : "1","path" : "https://cdn.shopify.com/s/files/1/0689/5888/0040/t/57/assets/iphone_14_midnight_pdp_image_position-1b_ar_1690821261_823x.jpg?v=1688733735","mediaType" : "I"],
                                ["id" : "","path" : "https://www.proshop.no/Images/915x900/3104593_9dd241e23b8d.png","mediaType" : "I"],
                                ["id" : "","path" : "https://d23hwmpje67tm.cloudfront.net/225786-medium_default/apple-iphone-13-128gb.jpg","mediaType" : "I"]],
                    
                    "colors" : [["id" : "1","title" : "","color" : "#17202A","isAvailable" : true],
                                ["id" : "","title" : "","color" : "#C0392B","isAvailable" : false],
                                ["id" : "","title" : "","color" : "#99A3A4","isAvailable" : false],
                                ["id" : "","title" : "","color" : "#82E0AA","isAvailable" : false],
                                ["id" : "","title" : "","color" : "#F7DC6F","isAvailable" : false]],
                    
                    "sizes" : [["id" : "1","title" : "256 G","isAvailable" : true],
                                ["id" : "","title" : "128 G","isAvailable" : false],
                                ["id" : "","title" : "64 G","isAvailable" : false],
                                ["id" : "","title" : "521 G","isAvailable" : false]],
                    
                    "Reviews" : [["id" : "","Review" : "The phone is great. Battery life, speed, camera and all very good","userName" : "Mahmoud","rat" : "3.5","date" : "2024-01-01T10:00:00"],
                                
                        ["id" : "","Review" : "I bought the iPhone 14 as a gift for my moms birthday as she needed an upgrade badly and she really loves the new phone as she is currently using it for her work and she is much more productive now. I highly recommend this phone for anybody who needs a new upgrade and has the money to spend on this phone.","userName" : "Someone","rat" : "3.5","date" : "2024-01-03T10:00:00"],
                                
                        ["id" : "","Review" : "Camera UI (5/5): One thing I really liked is the Photographic Styles (basically tunes the colors) when taking photos. There are a few preset filters like Standard, Rich Contrast, Vibrant, Warm, and Cool. You can tune one them and make it your default setting.","userName" : "Mohammad M.","rat" : "3.5","date" : "2024-01-10T10:00:00"],
                                
                        ["id" : "","Review" : "Main Camera 5/5: It takes quite good shots, whether it is in a well lit environment or a dark room. Videos are also great with it. One thing iPhones are good at is zooming smoothly while taking videos. I can't take a video without zooming at least once during the video, it is that mesmerizing. ","userName" : "Maureen Kimaru","rat" : "4.5","date" : "2024-01-09T10:00:00"] ,
                                
                        ["id" : "","Review" : "Selfie Camera (3/5): When I first bought the phone, I struggled at least a week with it. Then it got fixed with the most recent update. The focus point seemed to be fixed at far objects, so your face would always be out of focus. After the fix, I still find that it over sharpens my facial features and skin marks to the point that it shows stuff that do not seem to be there (at least when I look in the mirror).","userName" : "Tawab","rat" : "2.5","date" : "2024-01-04T10:00:00"],
                                
                        ["id" : "","Review" : "Ultra Wide Camera (0/5): Photos with this camera is underwhelming and extremely horrible. The noise is just horrible with this one, everything looks grainy. I put it next to a Samsung A31 and took a picture in the same exact conditions, and the A31 was leagues ahead!!! You can get to the nearest store, grab an iPhone14 and another Samsung/Oppo/OnePlus phone, even the budget ones, and take the same exact picture from the same angle, and compare them, and I am sure you will spot a huge difference.","userName" : "Hosny","rat" : "4.2","date" : "2024-01-12T10:00:00"]],
                    
                    "SimilarItems" : [
                        ["itemId" : "","title" : "camra ","image" : "https://i.pinimg.com/236x/83/7c/28/837c281e69b735d1ec0b6495dc0da027.jpg","price" : "2.000","oldPrice" : "","rating" : "4.6","discount" : "","isFavourite" : true,"categoryId" : ""],

                     ["itemId" : "","title" : "laptop ","image" : "https://media.wired.com/photos/64daad6b4a854832b16fd3bc/master/pass/How-to-Choose-a-Laptop-August-2023-Gear.jpg","price" : "10.000","oldPrice" : "10.500","rating" : "4.2","discount" : "5","isFavourite" : false,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "desktop ","image" : "https://images-eu.ssl-images-amazon.com/images/I/711Oh7-BzdL._AC_UL600_SR600,600_.jpg","price" : "20.000","oldPrice" : "21.000","rating" : "4.4","discount" : "5" ,"isFavourite"  : true,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "camra ","image" : "https://i.pinimg.com/236x/83/7c/28/837c281e69b735d1ec0b6495dc0da027.jpg","price" : "5.000","oldPrice" : "5.500","rating" : "3.6","discount" : "10","isFavourite" : true,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "camra ","image" : "https://www.ephotozine.com/articles/ephotozine-s-best-camera-of-the-year-awards-2014-26697/images/highres-nikon-d3300-dslr-white-bg_1418659524.jpg","price" : "20.000","oldPrice" : "","rating" : "3.4","discount" : "","isFavourite" : false,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "Iphone 14","image" : "https://m.media-amazon.com/images/I/61cwywLZR-L._AC_UF1000,1000_QL80_.jpg","price" : "36.000","oldPrice" : "30.000","rating" : "2.8","discount" : "20" ,"isFavourite" : true,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "Mobile Vivo","image" : "https://5.imimg.com/data5/SELLER/Default/2023/3/296178269/PQ/YW/MM/186724856/vivo-mobile-phone-500x500.jpg","price" : "11.000","oldPrice" : "10.100","rating" : "5.0","discount" : "10","isFavourite" : false,"categoryId" : ""],

                     ["itemId" : "","title" : "Mobile  Redmi","image" : "https://i.gadgets360cdn.com/products/large/redmi-note-12-5g-pro-plus-db-gadgets360-800x600-1673019783.jpg","price" : "12.000","oldPrice" : "15.000","rating" : "3.6","discount" : "15","isFavourite" : true,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "power Bank","image" : "https://5.imimg.com/data5/GW/UA/SG/SELLER-14201254/1000mah-power-bank-500x500.jpg","price" : "2.000","oldPrice" : "","rating" : "4.6","discount" : "","isFavourite" : false,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "power Bank ","image" : "https://images.philips.com/is/image/PhilipsConsumer/DLP8718PC_00-IMS-en_EG?$jpglarge$&wid=1250","price" : "4.000","oldPrice" : "4.400","rating" : "2.6","discount" : "10","isFavourite" : true,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "TV LG ","image" : "https://t4.ftcdn.net/jpg/05/02/26/29/360_F_502262924_FStXklnWAu66ZxI2CJOkQ9teE8Vv4hrF.jpg","price" : "35.000","oldPrice" : "32.500","rating" : "1.6","discount" : "8","isFavourite" : true,"categoryId" : ""],
                    
                     ["itemId" : "","title" : "TV  JAC","image" : "https://www.reliancedigital.in/medias/Mi-4A-Horizon-Edition-Television-492166368-i-3-1200Wx1200H?context=bWFzdGVyfGltYWdlc3wxMzY3MzV8aW1hZ2UvanBlZ3xpbWFnZXMvaDk5L2gzNy85NzkwODc0MTg5ODU0LmpwZ3w4NTA2ZDUwYTJmOGI0MTJlYzMyMjRmYWEwOTg4N2QwODg4YWUzZWM2NzBlMDM4MTExNGExOTIzMzE2ZTYxZWE4","price" : "32.000","oldPrice" : "28.000","rating" : "4.8","discount" : "14","isFavourite" : false,"categoryId" : ""]
                     ]
                    
        ] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.Details = ItemDetails(dictionary: data)
            DispatchQueue.main.async {self.SetData()}
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.tableView.tableHeaderView?.isHidden = true
//    self.tableView.tableFooterView?.isHidden = true
//    self.ButtonCompare.isHidden = true
//    self.tableView.isHidden = true
//    self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    self.SetUpIsError(error,true) {self.GetProduct()}
//    }
    }

    @objc func Reload() {
    DispatchQueue.main.async {
    UIView.animate(withDuration: 0.3) {
    self.ViewScroll.updateContentViewSize(0)
    if let layout = self.ProductDetailsImage.collectionViewLayout as? MMBannerLayout {
    layout.setCurrentIndex(0)
    layout.autoPlayStatus = .play(duration: 4.0)
    }
    self.ViewScroll.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.ViewScroll.contentSize.height)
    self.tableView.reloadData()
    self.tableView.layoutIfNeeded()
    }
        
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
    self.tableView.tableHeaderView?.isHidden = false
    self.tableView.tableFooterView?.isHidden = false
    self.ButtonCompare.isHidden = false
    self.tableView.isHidden = false
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing(){}
    }
    }
    }

    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        return Label
    }()

    lazy var BrandLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SelectBrand)))
        return Label
    }()

    @objc func SelectBrand() {
    if let details = Details , let id = details.brands?.id , let category = Details?.categoryId {
    let Items = ItemCategories()
    Items.CategoryId = category
    Items.BrandId = id.toInt() ?? 0
    Items.SetUpDismiss(text: Details?.categoryName ?? "Categories".localizable)
    Items.SetCategoryItems(removeAll: true, ShowDots: true, CategoriesShow: true)
    Present(ViewController: self, ToViewController: Items)
    }
    }

    func SetBrand(_ Brand:String) {
     let attributedString = NSMutableAttributedString(string: "Brand".localizable, attributes: [
    .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    ])

    attributedString.append(NSAttributedString(string: Brand, attributes: [
    .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    ]))
    BrandLabel.attributedText = attributedString
    }

    lazy var ViewRating : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.updateOnTouch = false
        view.settings.textFont = UIFont(name: "Muli", size: ControlWidth(11.5)) ?? UIFont.systemFont(ofSize: ControlWidth(11.5))
        return view
    }()

    func SetViewRating(_ rating:ItemRate?) {
    guard let Rate = rating else { return }
    ViewRating.rating = Rate.rating?.toDouble() ?? 1
    let one = Rate.oneStarsCount?.toInt() ?? 0
    let two = Rate.twoStarsCount?.toInt() ?? 0
    let three = Rate.threeStarsCount?.toInt() ?? 0
    let four = Rate.fourStarsCount?.toInt() ?? 0
    let five = Rate.fiveStarsCount?.toInt() ?? 0
    ViewRating.text = "lang".localizable == "en" ? String(one + two + three + four + five):String(one + two + three + four + five).NumAR()
    }

    lazy var BrandAndRating : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [BrandLabel,ViewRating])
    Stack.axis = .horizontal
    Stack.spacing = ControlWidth(25)
    Stack.distribution = .equalSpacing
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    return Stack
    }()

    //  SetUp Product Details Image
    var DetailsImageID = "DetailsImage"
    var player:AVPlayer?
    var playerLayer:AVPlayerLayer?
    lazy var ProductDetailsImage: UICollectionView = {
        let vc = UICollectionView(frame: .zero, collectionViewLayout: MMBannerLayout())
        vc.backgroundColor = UIColor.clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(DetailsImageCell.self, forCellWithReuseIdentifier: DetailsImageID)
        return vc
    }()

    lazy var heart : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heart")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.tintColor = UIColor(red: 215/255, green: 177/255, blue: 157/255, alpha: 1)
        image.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        image.layer.shadowOpacity = 0.6
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 6
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeartSelect)))
        return image
    }()

    @objc func HeartSelect() {
    if getUserObject().Uid  != nil {
    SelectHeart()
    }else{
    ShowMessageAlert("warning", "Log In First".localizable, "You are not logged in yet, please login first in order to continue".localizable, false, self.GoToLogIn, "Go LogIn".localizable)
    }
    }

    @objc func SelectHeart() {
    guard let details = Details else { return }
    let UrlAddOrRemove = details.isFavourite == false ? AddItemFavourite : RemoveItemFavourite
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + UrlAddOrRemove)"

    guard let uid = getUserObject().Uid else{return}
    guard let ItemId = details.itemId else{return}
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "itemId": ItemId]

    heart.isUserInteractionEnabled = false
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    details.isFavourite = !(details.isFavourite ?? false)
    self.heart.isUserInteractionEnabled = true
    } DictionaryData: { _ in
    } ArrayOfDictionary: { data in
    } Err: { error in
    self.heart.isUserInteractionEnabled = true
    if error != "" {ShowMessageAlert("warning","Error".localizable, error, true){}}
    }
    }

    var HeartSelected = false
    func HeartAnimate(_ isFavourite:Bool) {
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.image = isFavourite == true ?
    UIImage(named: "heartSelected")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)) :
    UIImage(named: "heart")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    self.heart.transform = self.heart.transform.scaledBy(x: 0.8, y: 0.8)
    }, completion: { _ in
    UIView.animate(withDuration: 0.3, animations: {
    self.heart.transform = .identity
    })
    })
    }

    lazy var pageControl : CHIPageControlChimayo = {
        let pc = CHIPageControlChimayo(frame: CGRect(x: 0, y:0, width: 100, height: 10))
        pc.tintColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        pc.backgroundColor = .white
        pc.radius = ControlWidth(5)
        pc.padding = ControlWidth(10)
        pc.transform = CGAffineTransform(scaleX: ControlWidth(1), y: ControlWidth(1))
        return pc
    }()


    lazy var LabelPrice : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
        Label.backgroundColor = .clear
        return Label
    }()


    lazy var VendorLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SelectVendor)))
        return Label
    }()

    @objc func SelectVendor() {
    if let details = Details , let id = details.Vendor?.id?.toInt() , let category = Details?.categoryId  {
    let Items = ItemCategories()
    Items.VendorId = id
    Items.CategoryId = category
    Items.SetUpDismiss(text: Details?.categoryName ?? "Categories".localizable)
    Items.SetCategoryItems(removeAll: true, ShowDots: true, CategoriesShow: true)
    Present(ViewController: self, ToViewController: Items)
    }
    }

    func SetVendor(_ Vendor:String,_ Show:Bool) {
    if Show {
    let attributedString = NSMutableAttributedString(string: "Vendor".localizable, attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    ])

    attributedString.append(NSAttributedString(string: Vendor, attributes: [
    .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.06842547655, green: 0.1572898328, blue: 0.537772119, alpha: 1)
    ]))
    VendorLabel.attributedText = attributedString
    }
    }


    lazy var PriceAndVendor : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LabelPrice,VendorLabel])
    Stack.axis = .horizontal
    Stack.spacing = ControlWidth(25)
    Stack.distribution = .equalSpacing
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    return Stack
    }()

    lazy var LabelOldPrice : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.text = ""
        return Label
    }()

    func SetOldPrice(oldPrice:String ,discount:String) {
    if discount != "" {
    LabelOldPrice.isHidden = false

    let OldPrice = "lang".localizable == "en" ? oldPrice:oldPrice.NumAR()
    let attributedString = NSMutableAttributedString(string: "\(OldPrice)", attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
    .strikethroughStyle: 1 ,
    .backgroundColor: UIColor.clear
    ])

    attributedString.append(NSAttributedString(string: "  ", attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .backgroundColor: UIColor.clear
    ]))

    let Discount = "lang".localizable == "en" ? "\(discount)% OFF":"٪\(discount) خصم".NumAR()
    attributedString.append(NSAttributedString(string: "\(Discount)", attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
    .backgroundColor: #colorLiteral(red: 0.6901710629, green: 0.8333616257, blue: 1, alpha: 1)
    ]))
    LabelOldPrice.attributedText = attributedString
    }else{
    LabelOldPrice.isHidden = true
    }
    }

    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.font = UIFont(name: "Muli" ,size: ControlWidth(14))
        Label.backgroundColor = .clear
        Label.isHidden = Details?.details == "" ? true :false
        return Label
    }()


    lazy var LabelSKU : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        return Label
    }()

    func SetSKU(_ SKU:String) {
    if SKU != "" {
    LabelSKU.isHidden = false
    let attributedString = NSMutableAttributedString(string: "SKU".localizable, attributes: [
    .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    ])

    attributedString.append(NSAttributedString(string: SKU, attributes: [
    .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    ]))
    LabelSKU.attributedText = attributedString
    }else{
    LabelSKU.isHidden = true
    }
    }

    //  SetUp Product Details Color
    lazy var ColorLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Color".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        return Label
    }()

    var ColorID = "Color"
    var ColorSelect = IndexPath()
    lazy var ProductDetailsColor: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = UIColor.clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
        vc.widthAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
        vc.register(DetailsColorCell.self, forCellWithReuseIdentifier: ColorID)
        return vc
    }()

    lazy var ColorStack: UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [ColorLabel,ProductDetailsColor])
    Stack.axis = .horizontal
    Stack.distribution = .fillProportionally
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    return Stack
    }()

    //  SetUp Product Details Size
    lazy var SizeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Size".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        return Label
    }()

    var SizeID = "Size"
    var SizeSelect = IndexPath()
    lazy var ProductDetailsSize: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = UIColor.clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
        vc.widthAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
        vc.register(DetailsSizeCell.self, forCellWithReuseIdentifier: SizeID)
        return vc
    }()

    lazy var SizeStack: UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [SizeLabel,ProductDetailsSize])
    Stack.axis = .horizontal
    Stack.distribution = .fillProportionally
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    return Stack
    }()


    lazy var ViewCart:UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true

        View.addSubview(AddToCartButton)
        AddToCartButton.topAnchor.constraint(equalTo: View.topAnchor).isActive = true
        AddToCartButton.bottomAnchor.constraint(equalTo: View.bottomAnchor).isActive = true
        AddToCartButton.leadingAnchor.constraint(equalTo: View.leadingAnchor).isActive = true
        AddToCartButton.trailingAnchor.constraint(equalTo: View.trailingAnchor).isActive = true

        View.addSubview(AddToCartView)
        AddToCartView.topAnchor.constraint(equalTo: View.topAnchor).isActive = true
        AddToCartView.bottomAnchor.constraint(equalTo: View.bottomAnchor).isActive = true
        AddToCartView.leadingAnchor.constraint(equalTo: View.leadingAnchor).isActive = true
        AddToCartView.trailingAnchor.constraint(equalTo: View.trailingAnchor).isActive = true

        return View
    }()

    lazy var AddToCartButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.alpha = 1
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.tintColor = UIColor.black
        Button.layer.cornerRadius = ControlWidth(19)
        Button.setTitle("Add to Cart".localizable, for: .normal)
        Button.setImage(UIImage(named: "AddCart"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(12))
        Button.addTarget(self, action: #selector(AddToCart), for: .touchUpInside)
        Button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        return Button
    }()

    @objc func AddToCart() {
    if let details = Details {
    if details.outOfStock ?? true {
    ShowMessageAlert("timer", "Tell Me".localizable, "out of stock".localizable, false, self.OutOfStockNotify, "Tell Me".localizable)
    }else{
    UIView.animate(withDuration: 0.4) {
    self.AddToCartButton.alpha = 0
    self.AddToCartView.alpha = 1
    self.AddToCartView.value = 1
    self.SaveToCart(Style: .Add)
    }
    }
    }
    }

    func OutOfStockNotify() {
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + NotifyOutOfStock)"

    guard let ItemId = Details?.itemId else{return}
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "deviceID": udid,
                                    "itemId": ItemId]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    self.ViewDots.endRefreshing("SuccessNotify".localizable, .success) {}
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }

    func SaveToCart(Style:CartStyle) {
    if getUserObject().Uid == nil {
    if let Item = self.Details {
    let Count = Int(AddToCartView.value)
    let Colors = Item.Colors[ColorSelect.item]
    let Sizes = Item.Sizes[SizeSelect.item]

    AddCart(Items: CartItems(itemId: Item.itemId, title: Item.title,
            image: Item.image, price: Item.price,outOfStock: Item.outOfStock,
            limit: Item.limit, isFav: Item.isFavourite,categoryId: Item.categoryId ,
            categoryName: Item.categoryName, ColorId: Colors.id,ColorTitle: Colors.title,
            Color: Colors.color, SizeId: Sizes.id, SizeTitle: Sizes.title, ItemCount: Count) ,Style:Style)

    self.SetCartCount()
    }
    }else{
    TimerUpdateONLine(time: 2)
    }
    }

    var timer:Timer?
    var value:Double?
    func TimerUpdateONLine(time:TimeInterval) {
    if AddToCartButton.alpha == 0 {
    timer?.invalidate()
    value = AddToCartView.value
    timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(UpdateCartONLine), userInfo: nil, repeats: false)
    }
    }

    var CartAccount : Account?
    @objc func UpdateCartONLine() {
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + UpdateCartItem)"

    guard let Id = getCartObject()?.id else{return}
    guard let uid = getUserObject().Uid else{return}
    guard let value = value else{return}
    let lang = "lang".localizable
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    guard let itemId = Details?.itemId else{return}

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
    UpDateCartObject(Data: self.CartAccount?.Cart)
    self.SetCartCount()
    self.ReloadCart()

    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }

    lazy var AddToCartView:GMStepper = {
        let View = GMStepper()
        View.alpha = 0
        View.borderWidth = 0
        View.labelTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.buttonsTextColor = .white
        View.buttonsBackgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        View.labelBackgroundColor = .white
        View.limitHitAnimationColor = .red
        View.label.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        View.label.layer.borderWidth = ControlWidth(2)
        View.label.layer.cornerRadius = ControlWidth(8)
        View.leftButton.layer.cornerRadius = ControlWidth(8)
        View.rightButton.layer.cornerRadius = ControlWidth(8)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.labelFont = UIFont(name: "Muli" ,size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14))
        View.addTarget(self, action: #selector(AddValueToCart), for: .valueChanged)
        return View
    }()


    @objc func AddValueToCart() {
    if AddToCartView.value == 0 {
    SaveToCart(Style: .Remove)
    UIView.animate(withDuration: 0.4) {
    self.AddToCartButton.alpha = 1
    self.AddToCartView.alpha = 0
    }

    }else if self.AddToCartView.value > 1 {
    SaveToCart(Style: .UpDate)
    }
    }

    lazy var AddToCompare : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .white
        Button.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.tintColor = UIColor.black
        Button.layer.borderWidth = ControlWidth(2)
        Button.layer.cornerRadius = ControlWidth(19)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(12))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
        Button.addTarget(self, action: #selector(ActionCompare), for: .touchUpInside)
        Button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionCompare() {
    if let details = Details {

    if defaults.string(forKey: "FirstItemId") != Details?.itemId && defaults.string(forKey: "SecondItemId") != Details?.itemId
         && defaults.string(forKey: "FirstItemId") != nil && defaults.string(forKey: "SecondItemId") != nil {
    ShowMessageAlert("warning", "Error".localizable, "No more than two items can be added to the comparison page".localizable, false, self.ActionGoCompare, "Go Compare".localizable)
    }else{

    if defaults.string(forKey: "FirstItemId") == details.itemId {
    defaults.removeObject(forKey: "FirstItemId")
    defaults.removeObject(forKey: "FirstSubCategory")
    SetCompare()
    }else if defaults.string(forKey: "SecondItemId") == details.itemId {
    defaults.removeObject(forKey: "SecondItemId")
    defaults.removeObject(forKey: "SecondSubCategory")
    SetCompare()
    }else{
    if defaults.string(forKey: "FirstItemId") == nil {
    defaults.set(details.itemId, forKey: "FirstItemId")
    defaults.set(details.subCategoryID, forKey: "FirstSubCategory")
    SetCompare()
    }else{
    if defaults.string(forKey: "FirstSubCategory") == Details?.subCategoryID {
    defaults.set(details.itemId, forKey: "SecondItemId")
    defaults.set(details.subCategoryID, forKey: "SecondSubCategory")
    SetCompare()
    }else{
    ShowMessageAlert("warning", "Error".localizable, "You cannot compare two different items".localizable, false, self.ActionGoCompare, "Go Compare".localizable)
    }
    }
    }
    }
    }
    }

    lazy var ButtonCompare : UIButton = {
        let Button = UIButton(type: .system)
        Button.isHidden = true
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(ActionGoCompare), for: .touchUpInside)
        return Button
    }()


    @objc func ActionGoCompare() {
    let Compare = CompareVC()
    Compare.ProductDetails = self
    Present(ViewController: self, ToViewController: Compare)
    }

    func SetCompare() {
        if defaults.string(forKey: "FirstItemId") != nil && defaults.string(forKey: "SecondItemId") == nil ||
        defaults.string(forKey: "FirstItemId") == nil && defaults.string(forKey: "SecondItemId") != nil {
        ButtonCompare.isHidden = false
        ButtonCompare.setBackgroundImage(UIImage(named: "Group 25890"), for: .normal)
        ButtonCompare.transform = ButtonCompare.transform.scaledBy(x: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.62, delay: 0, usingSpringWithDamping: 0.62, initialSpringVelocity: 0.7, options: []) {
        self.ButtonCompare.transform = .identity
        }
        }else if defaults.string(forKey: "FirstItemId") != nil && defaults.string(forKey: "SecondItemId") != nil {
        ButtonCompare.isHidden = false
        ButtonCompare.setBackgroundImage(UIImage(named: "Group 25898"), for: .normal)
        ButtonCompare.transform = ButtonCompare.transform.scaledBy(x: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.62, delay: 0, usingSpringWithDamping: 0.62, initialSpringVelocity: 0.7, options: []) {
        self.ButtonCompare.transform = .identity
        }
        }else{
        ButtonCompare.isHidden = true
        }

        if defaults.string(forKey: "FirstItemId") == Details?.itemId || defaults.string(forKey: "SecondItemId") == Details?.itemId {
        AddToCompare.setTitle("Remove Item".localizable, for: .normal)
        AddToCompare.setImage(UIImage(named: "Group 25276"), for: .normal)
        }else{
        AddToCompare.setTitle("Add to Compare".localizable, for: .normal)
        AddToCompare.setImage(UIImage(named: "Menu7"), for: .normal)
        }
    }

    lazy var CompareAndCart: UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [ViewCart,AddToCompare])
    Stack.axis = .horizontal
    Stack.spacing = ControlWidth(30)
    Stack.distribution = .fillEqually
    Stack.alignment = .center
    Stack.backgroundColor = .clear
    return Stack
    }()

    // Price Details list
    var listId = "list"
    var listTitle = ["","Fast Delivery & Free Return".localizable,"Secure Payments & Pay on Delivery".localizable]
    var listImage = [UIImage(named: "Warranty"),UIImage(named: "Delivery"),UIImage(named: "Payments")]
    lazy var Tablelist : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        tv.backgroundColor = .white
        tv.rowHeight = ControlWidth(44)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: listId)
        tv.contentInset = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        tv.heightAnchor.constraint(equalToConstant: ControlWidth(130)).isActive = true
        return tv
    }()

    /// Set Up FooterView
    lazy var FooterView:UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        return View
    }()
    
    /// Set Up Similar Products
    lazy var StackSimilarProducts : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LabelSimilarProducts,CollectionSimilarProducts])
    Stack.axis = .vertical
    Stack.spacing = ControlWidth(10)
    Stack.distribution = .equalSpacing
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()


    lazy var LabelSimilarProducts : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Similar Products".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Label
    }()

    var SimilarProductsID = "SimilarProducts"
    lazy var CollectionSimilarProducts: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = ControlWidth(1)
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(ItemCell.self, forCellWithReuseIdentifier: SimilarProductsID)
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(240)).isActive = true
        return vc
    }()

}



