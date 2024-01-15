//
//  ItemCategories.swift
//  Volt (iOS)
//
//  Created by Emojiios on 04/01/2022.
//

import UIKit

class ItemCategories: ViewController {

    var CategoryId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetUp()
    }
    
    func SetUp() {

    view.addSubview(Dismiss)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
                            
    /// Set UP Top Stack
    view.addSubview(CollectionCategories)
    CollectionCategories.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(10)).isActive = true
    CollectionCategories.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-10)).isActive = true
        
    CategoriesTopAnchor = CollectionCategories.topAnchor.constraint(equalTo: Dismiss.bottomAnchor,constant: 0)
    CategoriesTopAnchor?.isActive = true
        
    CategoriesShow = CollectionCategories.heightAnchor.constraint(equalToConstant: ControlWidth(40))
    CategoriesShow?.isActive = true
        
    CategoriesHidden = CollectionCategories.heightAnchor.constraint(equalToConstant: 0)
    CategoriesHidden?.isActive = true
        
    view.addSubview(StackBackground)
    StackBackground.addSubview(StackFilterSort)
    StackBackground.topAnchor.constraint(equalTo: CollectionCategories.bottomAnchor,constant: ControlX(17)).isActive = true
    StackBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    StackBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    StackBackgroundHidden = StackBackground.heightAnchor.constraint(equalToConstant: ControlWidth(46))
    StackBackgroundHidden?.isActive = true
        
    StackBackgroundShow = StackBackground.heightAnchor.constraint(equalToConstant: 0)
    StackBackgroundShow?.isActive = true
    
    StackFilterSort.topAnchor.constraint(equalTo: StackBackground.topAnchor ,constant: ControlY(8)).isActive = true
    StackFilterSort.bottomAnchor.constraint(equalTo: StackBackground.bottomAnchor ,constant: ControlY(-8)).isActive = true
    StackFilterSort.leadingAnchor.constraint(equalTo: StackBackground.leadingAnchor,constant: ControlX(10)).isActive = true
    StackFilterSort.trailingAnchor.constraint(equalTo: StackBackground.trailingAnchor,constant: ControlX(-10)).isActive = true
        
    /// Set UP Collection Item
    view.addSubview(CollectionItem)
    CollectionItem.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    CollectionItem.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    CollectionItem.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    CollectionItem.topAnchor.constraint(equalTo: StackBackground.bottomAnchor,constant: ControlX(5)).isActive = true

    let refreshView = KRPullLoadView()
    refreshView.delegate = self
    CollectionItem.addPullLoadableView(refreshView, type: .refresh)
    let loadMoreView = KRPullLoadView()
    loadMoreView.delegate = self
    CollectionItem.addPullLoadableView(loadMoreView, type: .loadMore)
                
    updatePresentationStyle()
    }
    
    var StackBackgroundShow:NSLayoutConstraint?
    var StackBackgroundHidden:NSLayoutConstraint?
    lazy var StackBackground:UIView = {
        let View = UIView()
        View.isHidden = true
        View.backgroundColor = #colorLiteral(red: 0.9217862087, green: 0.9217862087, blue: 0.9217862087, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    var CategoriesTopAnchor:NSLayoutConstraint?
    var CategoriesShow:NSLayoutConstraint?
    var CategoriesHidden:NSLayoutConstraint?
    /// Set UP Collection Categories
    var CategoriesID = "Categories"
    var SelectedIndexPath: IndexPath?
    lazy var CollectionCategories: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(ItemCategoriesCell.self, forCellWithReuseIdentifier: CategoriesID)
        return vc
    }()
    
    /// Set UP View Sort And Filter
    lazy var StackFilterSort : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ButtonFilter,ButtonSort,UIView(),SegmentedCategories])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.clipsToBounds = false
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    lazy var ButtonFilter : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setTitle("Filter".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.textAlignment = .center
        Button.setImage(UIImage(named: "Filter"), for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size:  ControlWidth(18))
        Button.addTarget(self, action: #selector(ActionFilter), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionFilter() {
    let FilterResults = FilterResultsVC()
    FilterResults.Items = self
    FilterResults.CategoryId = CategoryId
    Present(ViewController: self, ToViewController: FilterResults)
    }
    
    lazy var ButtonSort : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setTitle("Sort".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.titleLabel?.textAlignment = .center
        Button.setImage(UIImage(named: "Sort"), for: .normal)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size:  ControlWidth(18))
        Button.addTarget(self, action: #selector(ActionSort), for: .touchUpInside)
        return Button
    }()
    
    
    let PopUp = PopUpDownView()
    @objc func ActionSort() {
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(220)
    PopUp.radius = 25

    PopUp.View.addSubview(TableViewSort)
    PopUp.View.addSubview(PopUpTopView)

    PopUpTopView.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlX(10)).isActive = true
    PopUpTopView.centerXAnchor.constraint(equalTo: PopUp.View.centerXAnchor).isActive = true
    PopUpTopView.widthAnchor.constraint(equalToConstant: ControlWidth(150)).isActive = true
    PopUpTopView.heightAnchor.constraint(equalToConstant: ControlWidth(5)).isActive = true

    TableViewSort.topAnchor.constraint(equalTo: PopUp.View.topAnchor,constant: ControlX(20)).isActive = true
    TableViewSort.leadingAnchor.constraint(equalTo: PopUp.View.leadingAnchor).isActive = true
    TableViewSort.trailingAnchor.constraint(equalTo: PopUp.View.trailingAnchor).isActive = true
    TableViewSort.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
    present(PopUp, animated: true)
    }


    lazy var PopUpTopView : UIView = {
        let View = UIView()
        View.layer.cornerRadius = ControlWidth(2)
        View.backgroundColor = UIColor(red: 99 / 255.0, green: 87 / 255.0, blue: 82 / 255.0, alpha: 1.0)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    var Sort = Int()
    private let SortID = "Sort"
    var indexSelectSort = IndexPath()
    let SortData = ["Popularity".localizable,"High to Low Price".localizable,"Low to High Price".localizable,"Top Rating".localizable]
    lazy var TableViewSort : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.rowHeight = ControlWidth(45)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = UIEdgeInsets(top: 0, left: ControlX(20), bottom: 0, right: ControlX(20))
        tv.register(SortCell.self, forCellReuseIdentifier: SortID)
        return tv
    }()
    
    
    /// Set UP Categories Item
    var ItemID = "Item"
    lazy var CollectionItem: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.contentInset = .zero
        vc.isHidden = true
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(ItemCell.self, forCellWithReuseIdentifier: ItemID)
        return vc
    }()
    
    /// Get Category Items
    var SkipItems = 0
    var ItemsMore = false
    var ItemsData : Items?
    var VendorId = Int()
    var BrandId = Int()
    var Animations = true
    var AllItem = [CategoryItems]()
    var SubCategories = [CategoriesSub]()
    func SetCategoryItems(Parameters:[String:Any] = [String:Any]() , removeAll:Bool = false ,ShowDots:Bool = true ,CategoriesShow:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    guard let Id = CategoryId else{return}
//    let uid = getUserObject().Uid ?? ""
//            
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let api = "\(url + GetItems)"
//        
//    var parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                    "Platform": "I",
//                                    "lang": lang,
//                                    "uid": uid,
//                                    "deviceID": udid,
//                                    "keyWord": "",
//                                    "keyWordId": GUID,
//                                    "categoryId": Id,
//                                    "priceFrom": 0,
//                                    "priceTo": 0,
//                                    "vendorId": VendorId,
//                                    "colorId": [],
//                                    "rating": [],
//                                    "sizeId": [],
//                                    "sort": Sort,
//                                    "brandId": [BrandId],
//                                    "take": 15,
//                                    "skip": SkipItems]
//             
//    if !Parameters.isEmpty {
//    parameters = Parameters
//    }
//        
    ItemsMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
    
        let data = [
            "SubCategories": [
            ["id" : "","title" : "Nokia","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "SAMSUNG","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "OPPO","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "Xiaomi","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "Blackview","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "IKU","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "realme","icon" : "","image" : "","hasSub" : false]],
            
            "Items":[
                
            ["itemId" : "","title" : "Nokia g21","image" : "https://images.ctfassets.net/wcfotm6rrl7u/63gT9Q5JTAI4ZElnjghIPD/b6bcca127ec861c957fec9685b05b06c/nokia-G21-nordic_blue-front-back-int.png?h=1000&fm=png&fl=png8","price" : "3.800","oldPrice" : "4.200","rating" : "4.3","discount" : "android smartphone, dual sim, 4gb ram, 128gb memory, 6.5hd+ screen, 5050mah battery, android 12 ready, face unlock, finger print sensor - dusk","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Samsung Galaxy A24","image" : "https://m.media-amazon.com/images/I/711AEdtkdiL._AC_UF894,1000_QL80_.jpg","price" : "3.800","oldPrice" : "4.200","rating" : "3.3","discount" : "Samsung Galaxy A24 4G Android Smartphone, Dual SIM, 6GB RAM, 128GB Storage, Black","isFavourite" : false,"categoryId" : ""],
                          
            ["itemId" : "","title" : "OPPO Reno 8T","image" : "https://m.media-amazon.com/images/I/51v8RUCiy6L._AC_UF894,1000_QL80_.jpg","price" : "6.800","oldPrice" : "7.200","rating" : "4.3","discount" : "OPPO Reno 8T Dual SIM 6.43 inches Smartphone 256GB 8GB RAM | 5000mAh Long Lasting Battery |Fingerprint and Face Recognition | 4G Android Phone Midnight Black, Bluetooth, Wi-Fi, USB","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Xiaomi Redmi 10","image" : "https://img.mobgsm.com/pictures/xiaomi/xiaomi-redmi-10-5g-02.webp","price" : "3.800","oldPrice" : "4.200","rating" : "3.6","discount" : "Xiaomi Redmi 10 (2022) Smartphone, 4GB RAM, 64GB ROM - Carbon Grey","isFavourite" : false,"categoryId" : ""],
                          
            ["itemId" : "","title" : "HUAWEI nova Y90","image" : "https://mobizil.com/wp-content/uploads/2022/10/Huawei-Nova-Y90.jpg","price" : "3.800","oldPrice" : "4.200","rating" : "4.3","discount" : "HUAWEI nova Y90 Smart Phone, 6.7 Edgeless FullView Display,40W Fast Charging, 5000 mAh Large Battery, 50 MP AI Triple Camera, 8GB + 128GB Storage, EMUI 12 Mobile Phone, LTE, Midnight Black","isFavourite" : false,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Xiaomi POCO C40","image" : "https://api.mobilaty.com/storage/uploads/poco-c40-y-1669205365.jpg","price" : "4.800","oldPrice" : "5.200","rating" : "4.3","discount" : "Xiaomi POCO C40 6.71 Inch HD+ Dot Drop Display Dual SIM Power Black 3GB RAM 32GB 4G LTE","isFavourite" : false,"categoryId" : ""],
                          
            ["itemId" : "","title" : "OPPO A17K","image" : "https://egymobilat.com/public/uploads/all/ex49DEKOcOlnAESuDWXRBeXb4VyVRZrmWYAGSJaz.webp","price" : "3.800","oldPrice" : "4.00","rating" : "2.8","discount" : "OPPO A17K Dual SIM Smartphone, 64GB, 3GB RAM - Navy Blue","isFavourite" : false,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Samsung Galaxy A54","image" : "https://madastore.ps/storage/media/KFPOWGNWzthhuiCTKaczw0NnJwGNfties699VbDf.jpg","price" : "3.800","oldPrice" : "4.200","rating" : "3.8","discount" : "Samsung Galaxy A54 - Dual SIM Mobile Phone Android, 8GB RAM, 256GB, 5G, Awesome Lime - 1 year Warranty","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Nokia c1","image" : "https://mobaili.com/image/cache/catalog/2019/e-1000x1000.jpg","price" : "1.800","oldPrice" : "2.100","rating" : "2.3","discount" : "Nokia c1 2nd edition android smartphone, 1gb ram, 16 gb memory, 5.45 hd+, blue","isFavourite" : false,"categoryId" : ""]]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ItemsData = Items(dictionary: data)
            
            if CategoriesShow {
                let ItemsData = Items(dictionary: data)
                self.SubCategories.removeAll()
                self.CollectionCategories.reloadData()
                for item in ItemsData.Sub {
                    self.SubCategories.append(item)
                    self.CollectionCategories.reloadData()
                }
                self.CategoriesIsShow(ShowCategories: ItemsData.Sub.count == 0 ? false:true)
            }
            
            if removeAll {
                self.CollectionItem.RemoveAnimations {
                    self.AllItem.removeAll()
                    self.Animations = true
                    self.AddData()
                }
            }else{
                self.AddData()
            }
            
            if self.AllItem.count == 0 {
                self.SetUpIsError("",true) {self.RefreshItems()}
            }else {
                self.ViewNoData.isHidden = true
                self.ViewDots.endRefreshing(){}
                self.CollectionItem.isHidden = false
                self.StackBackground.isHidden = false
            }
        }
        
        
//    } ArrayOfDictionary: { _ in
//    }Err: { error in
//    self.CategoriesIsShow(ShowCategories: false)
//    self.CollectionItem.isHidden = true
//    self.StackBackground.isHidden = true
//    self.SetUpIsError(error,true) {self.RefreshItems()}
//    }
    }
    
    func AddData() {
    if let Items = self.ItemsData?.Items {
    for Item in Items {
    self.AllItem.append(Item)
    self.SkipItems += 1
    self.ItemsMore = false
    self.Animations == true ? self.CollectionItem.SetAnimations() {self.Animations = false} : self.CollectionItem.reloadData()
    }
    }
    }
    
    @objc func RefreshItems() {
    SkipItems = 0
    SetCategoryItems(removeAll: true, ShowDots: true, CategoriesShow: true)
    }
    
    /// Get other Items ( Wishlist , Recently Viewed )
    enum OtherItems {
        case Wishlist,RecentlyViewed,none
    }
    
    func GetOtherItems(Other:OtherItems = .none,removeAll:Bool = false,ShowDots:Bool = true) {
//    let Api = Other == .Wishlist ? GetWishList : GetRecentlyViewed
//        
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let uid = getUserObject().Uid ?? ""
//            
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let api = "\(url + Api)"
//            
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "Platform": "I",
//                                   "uid":uid,
//                                   "deviceID": udid,
//                                   "lang": lang,
//                                   "take": 5,
//                                   "skip": SkipItems]
        
    ItemsMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in

        let data = [
            "SubCategories": [
            ["id" : "","title" : "Nokia","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "SAMSUNG","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "OPPO","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "Xiaomi","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "Blackview","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "IKU","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "realme","icon" : "","image" : "","hasSub" : false],
            ["id" : "","title" : "ipone","icon" : "","image" : "","hasSub" : false]

            ],
            
            "Items":[
                
            ["itemId" : "","title" : "Nokia g21","image" : "https://images.ctfassets.net/wcfotm6rrl7u/63gT9Q5JTAI4ZElnjghIPD/b6bcca127ec861c957fec9685b05b06c/nokia-G21-nordic_blue-front-back-int.png?h=1000&fm=png&fl=png8","price" : "3.800","oldPrice" : "4.200","rating" : "4.3","discount" : "android smartphone, dual sim, 4gb ram, 128gb memory, 6.5hd+ screen, 5050mah battery, android 12 ready, face unlock, finger print sensor - dusk","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Samsung Galaxy A24","image" : "https://m.media-amazon.com/images/I/711AEdtkdiL._AC_UF894,1000_QL80_.jpg","price" : "3.800","oldPrice" : "4.200","rating" : "3.3","discount" : "Samsung Galaxy A24 4G Android Smartphone, Dual SIM, 6GB RAM, 128GB Storage, Black","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "OPPO Reno 8T","image" : "https://m.media-amazon.com/images/I/51v8RUCiy6L._AC_UF894,1000_QL80_.jpg","price" : "6.800","oldPrice" : "7.200","rating" : "4.3","discount" : "OPPO Reno 8T Dual SIM 6.43 inches Smartphone 256GB 8GB RAM | 5000mAh Long Lasting Battery |Fingerprint and Face Recognition | 4G Android Phone Midnight Black, Bluetooth, Wi-Fi, USB","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Xiaomi Redmi 10","image" : "https://img.mobgsm.com/pictures/xiaomi/xiaomi-redmi-10-5g-02.webp","price" : "3.800","oldPrice" : "4.200","rating" : "3.6","discount" : "Xiaomi Redmi 10 (2022) Smartphone, 4GB RAM, 64GB ROM - Carbon Grey","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "HUAWEI nova Y90","image" : "https://mobizil.com/wp-content/uploads/2022/10/Huawei-Nova-Y90.jpg","price" : "3.800","oldPrice" : "4.200","rating" : "4.3","discount" : "HUAWEI nova Y90 Smart Phone, 6.7 Edgeless FullView Display,40W Fast Charging, 5000 mAh Large Battery, 50 MP AI Triple Camera, 8GB + 128GB Storage, EMUI 12 Mobile Phone, LTE, Midnight Black","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Xiaomi POCO C40","image" : "https://api.mobilaty.com/storage/uploads/poco-c40-y-1669205365.jpg","price" : "4.800","oldPrice" : "5.200","rating" : "4.3","discount" : "Xiaomi POCO C40 6.71 Inch HD+ Dot Drop Display Dual SIM Power Black 3GB RAM 32GB 4G LTE","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "OPPO A17K","image" : "https://egymobilat.com/public/uploads/all/ex49DEKOcOlnAESuDWXRBeXb4VyVRZrmWYAGSJaz.webp","price" : "3.800","oldPrice" : "4.00","rating" : "2.8","discount" : "OPPO A17K Dual SIM Smartphone, 64GB, 3GB RAM - Navy Blue","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Samsung Galaxy A54","image" : "https://madastore.ps/storage/media/KFPOWGNWzthhuiCTKaczw0NnJwGNfties699VbDf.jpg","price" : "3.800","oldPrice" : "4.200","rating" : "3.8","discount" : "Samsung Galaxy A54 - Dual SIM Mobile Phone Android, 8GB RAM, 256GB, 5G, Awesome Lime - 1 year Warranty","isFavourite" : true,"categoryId" : ""],
                          
            ["itemId" : "","title" : "Nokia c1","image" : "https://mobaili.com/image/cache/catalog/2019/e-1000x1000.jpg","price" : "1.800","oldPrice" : "2.100","rating" : "2.3","discount" : "Nokia c1 2nd edition android smartphone, 1gb ram, 16 gb memory, 5.45 hd+, blue","isFavourite" : true,"categoryId" : ""]]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.ItemsData = Items(dictionary: data)
            self.CategoriesIsShow(ShowCategories: false, ShowTopStack: false)
            
            if removeAll {
                self.CollectionItem.RemoveAnimations {
                    self.AllItem.removeAll()
                    self.Animations = true
                    self.AddData()
                }
            }else{
                self.AddData()
            }
            
            if self.AllItem.count == 0 {
                self.SetUpIsError("",true) {self.RefreshOtherItem()}
            }else {
                self.ViewNoData.isHidden = true
                self.ViewDots.endRefreshing(){}
                self.CollectionItem.isHidden = false
            }
        }
        
//    } ArrayOfDictionary: { _ in
//    }Err: { error in
//    self.CollectionItem.isHidden = true
//    self.SetUpIsError(error,true) {self.RefreshOtherItem()}
//    }
    }
    
    @objc func RefreshOtherItem() {
    SkipItems = 0
    GetOtherItems(removeAll: true, ShowDots: true)
    }
    
    private var selectedStyle: PresentationStyle = .defaultGrid {
        didSet { updatePresentationStyle() }
    }
    private var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] = {
        let result: [PresentationStyle: CollectionViewSelectableItemDelegate] = [
            .table: TabledContentCollectionViewDelegate(),
            .defaultGrid: DefaultGriddedContentCollectionViewDelegate(),
        ]
        result.values.forEach {
        $0.didSelectItem = { _ in}
        }
        return result
    }()

    private func updatePresentationStyle() {
        CollectionItem.delegate = styleDelegates[selectedStyle]
        CollectionItem.performBatchUpdates({
            CollectionItem.reloadData()
        }, completion: nil)
    }
    
    let SegmentedCategories : UISegmentedControl = {
        let segmentItems = ["1", "2"]
        let sc = UISegmentedControl(items: segmentItems)
        sc.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
        sc.selectedSegmentTintColor = .white
        } else {
        sc.layer.borderWidth = 2
        sc.layer.borderColor = #colorLiteral(red: 0.8998273955, green: 0.8998273955, blue: 0.8998273955, alpha: 1)
        sc.layer.cornerRadius = 5
        }

        sc.tintColor = .white
        sc.backgroundColor = #colorLiteral(red: 0.8998273955, green: 0.8998273955, blue: 0.8998273955, alpha: 1)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        sc.setImage(UIImage(named: "Layout1")?.withInset(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)), forSegmentAt: 0)
        sc.setImage(UIImage(named: "Layout2")?.withInset(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)), forSegmentAt: 1)
        sc.addTarget(ItemCategories.self, action: #selector(SegmentedChange), for: .valueChanged)
        return sc
    }()    
        
    @objc func SegmentedChange() {
    changeContentLayout()
    }
    
    @objc private func changeContentLayout() {
        CollectionItem.reloadData()
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: selectedStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        selectedStyle = allCases[nextIndex]
        CollectionItem.reloadData()
    }
    

    func CategoriesIsShow(ShowCategories:Bool,ShowTopStack:Bool = true) {
    DispatchQueue.main.async {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.6, options: []) {
    self.CategoriesShow?.isActive = ShowCategories
    self.CategoriesHidden?.isActive = !ShowCategories
    self.CollectionCategories.isHidden = !ShowCategories
    self.CategoriesTopAnchor?.constant = ShowCategories == true ? ControlX(20):0.0
        
    self.StackBackgroundShow?.isActive = !ShowTopStack
    self.StackBackgroundHidden?.isActive = ShowCategories
    self.view.layoutIfNeeded()
    }
    }
    }
}

// SetUP Collection View
extension ItemCategories : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , ItemCategoriesDelegate ,ItemCellDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case CollectionCategories:
        return SubCategories.count
            
        case CollectionItem:
        return AllItem.count
        
        default:
        return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
        
    case CollectionCategories:
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesID, for: indexPath) as! ItemCategoriesCell
    cell.Delegate = self
    cell.clipsToBounds = true
    cell.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
    cell.layer.borderWidth = ControlWidth(1)
    cell.layer.cornerRadius = cell.frame.height / 2
    cell.Label.text = SubCategories[indexPath.row].title ?? ""
    cell.backgroundColor = SelectedIndexPath == indexPath ? #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) : .clear
    return cell
        
    case CollectionItem:
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemID, for: indexPath) as! ItemCell
    let Item = AllItem[indexPath.item]
        

    cell.ImageItemWidthAnchor1?.isActive = selectedStyle == .defaultGrid ? true : false
    cell.ImageItemWidthAnchor2?.isActive = selectedStyle == .table ? true : false
        
    cell.ImageItemHeightAnchor1?.isActive = selectedStyle == .defaultGrid ? true : false
    cell.ImageItemHeightAnchor2?.isActive = selectedStyle == .table ? true : false
        
    cell.LabelTopAnchor1?.isActive = selectedStyle == .defaultGrid ? true : false
    cell.LabelTopAnchor2?.isActive = selectedStyle == .table ? true : false
        
    cell.LabelleadingAnchor1?.isActive = selectedStyle == .defaultGrid ? true : false
    cell.LabelleadingAnchor2?.isActive = selectedStyle == .table ? true : false
        
    cell.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
    cell.layer.shadowOffset = CGSize(width: 2, height: 1)
    cell.layer.shadowOpacity = 0.6
    cell.layer.shadowRadius = 6
    cell.backgroundColor = .white
    
    cell.Delegate = self
    cell.update(icon: Item.image, Rating: Item.rating, Details: Item.title, PriceAfter: Item.price, PriceBefore: Item.oldPrice, Favourite: Item.isFavourite, discount: Item.discount?.toInt())
    cell.PriceBeforeLabel.MutableStrikethrough(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)))
    return cell
            
    default:
    return UICollectionViewCell()
    }
    }
    
    // Action Collection ItemCategoriesCell
    func ActionCategories(_ cell: ItemCategoriesCell) {
    if let index = CollectionCategories.indexPath(for: cell) {
    if SubCategories[index.item].hasSub ?? false {
    let CategoriesInstance = ItemCategoriesInstanceVC()
    CategoriesInstance.CategoryInstanceId = SubCategories[index.item].id
    CategoriesInstance.SetUpDismiss(text: self.SubCategories[index.item].title ?? "back".localizable)
    Present(ViewController: self, ToViewController: CategoriesInstance)
    }else{
    CategoryId = SubCategories[index.item].id
    SkipItems = 0
    SetCategoryItems(removeAll: true, ShowDots: true,CategoriesShow: false)
    SelectedIndexPath = index
    CollectionCategories.reloadData()
    }
    }
    }
    
    // Action Collection ItemCell
    func ActionBackground(_ Cell: ItemCell) {
    guard let index = CollectionItem.indexPath(for: Cell) else { return }
    guard let itemId = AllItem[index.item].itemId else { return }
    let ProductDetails = ProductDetailsVC()
    ProductDetails.GetProduct(ProductId: itemId)
    Present(ViewController: self, ToViewController: ProductDetails)
    }
    
    func ActionHeart(_ Cell: ItemCell) {
    if let index = CollectionItem.indexPath(for: Cell) {
    let UrlAddOrRemove = AllItem[index.item].isFavourite == false ? AddItemFavourite : RemoveItemFavourite
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
    let api = "\(url + UrlAddOrRemove)"

    guard let uid = getUserObject().Uid else{return}
    guard let ItemId = AllItem[index.item].itemId else{return}
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            
    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "itemId": ItemId]
                    
    Cell.heart.isUserInteractionEnabled = false
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    if self.Dismiss.TextDismiss == "Wishlist".localizable {
    self.AllItem.remove(at: index.item)
    self.CollectionItem.deleteItems(at: [index])
    self.CollectionItem.reloadData()
    Cell.heart.isUserInteractionEnabled = true
    }else{
    self.AllItem[index.item].isFavourite = !(self.AllItem[index.item].isFavourite ?? false)
    self.CollectionItem.reloadItems(at: [index])
    Cell.heart.isUserInteractionEnabled = true
    }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case CollectionCategories:
        let nw = SubCategories[indexPath.row].title ?? ""
        let estimatedFrame = nw.textSizeWithFont(UIFont.systemFont(ofSize: ControlWidth(16)))
        return CGSize(width: estimatedFrame.width + ControlWidth(40), height: collectionView.frame.height)
            
        default:
        return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    cell.alpha = 0
    UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
    cell.alpha = 1
    }, completion: nil)
    }
    
}

// SetUP Collection View
extension ItemCategories : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortID, for: indexPath) as! SortCell
        cell.selectionStyle = .none
        cell.tintColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        cell.Label.text = SortData[indexPath.row]
        cell.backgroundColor = indexSelectSort == indexPath ? #colorLiteral(red: 0.9423349211, green: 0.9423349211, blue: 0.9423349211, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.Label.textColor = indexSelectSort == indexPath ? #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.accessoryType = indexSelectSort == indexPath ? .checkmark : .none
        cell.LabelleadingAnchor?.isActive = indexSelectSort == indexPath ? false : true
        cell.LabelleadingAnchorSelect?.isActive = indexSelectSort == indexPath ? true : false
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    indexSelectSort = indexPath
    tableView.reloadData()
    Sort = indexPath.item + 1
    RefreshItems()
    PopUp.DismissAction()
    }
    
}

extension ItemCategories: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {

        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
            
        switch self.Dismiss.TextDismiss {
        case "Wishlist".localizable , "Recently Viewed".localizable:
        self.GetOtherItems(ShowDots: false)
        default:
        self.SetCategoryItems(removeAll: false, ShowDots: false, CategoriesShow: false)
        }

        }
        default: break
        }
        return
        }

        switch state {
        case .none:
        pullLoadView.messageLabel.text = ""
        case .pulling(_, _):
        pullLoadView.messageLabel.text = "Pull more".localizable
        case let .loading(completionHandler):
            
        pullLoadView.messageLabel.text = "Updating".localizable
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        switch self.Dismiss.TextDismiss {
        case "Wishlist".localizable , "Recently Viewed".localizable:
        self.RefreshOtherItem()
        default:
        self.RefreshItems()
        }
        }
            
        }
        return
        }
}


class ItemCategoriesInstanceVC: ItemCategories {
    
    var CategoryInstanceId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryId = CategoryInstanceId
        SetCategoryItems()
    }
    
}
