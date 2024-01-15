//
//  HomeVC.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 29/12/2021.
//

import UIKit
import SDWebImage
import FirebaseAuth

class HomeVC: ViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetUp()
    }
    
    static let SlidePlay = NSNotification.Name(rawValue: "SlidePlay")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: HomeVC.SlidePlay, object: nil)
    }
    
    static let SlideStop = NSNotification.Name(rawValue: "SlideStop")
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: HomeVC.SlideStop, object: nil)
    }
        
    func SetUp() {
    view.addSubview(SearchBar)
    SearchBar.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
            
    view.addSubview(CollectionView)
    CollectionView.frame = CGRect(x: 0, y: SearchBar.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(150))
    SetMainScreen()
    }
    
    let ItemsId = "ItemsId"
    let SliderId = "SliderId"
    let OffersId = "OffersId"
    let CategoriesId = "CategoriesId"
    lazy var CollectionView: CollectionAnimations = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        vc.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        vc.addPullLoadableView(loadMoreView, type: .loadMore)
        
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(SliderCell.self, forCellWithReuseIdentifier: SliderId)
        vc.register(OffersHomeCell.self, forCellWithReuseIdentifier: OffersId)
        vc.register(ItemsHomeCell.self, forCellWithReuseIdentifier: ItemsId)
        vc.register(CategoriesHomeCell.self, forCellWithReuseIdentifier: CategoriesId)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return vc
    }()


    var skip = 0
    var Animations = true
    var fetchingMore = false
    var MainScreenData = [MainScreen]()
    func SetMainScreen(removeAll:Bool = false, ShowDots:Bool = true) {
        
    fetchingMore = true
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//        
//    let api = "\(url + GetMainScreen)"
//    
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let uid = Auth.auth().currentUser?.uid ?? ""
//            
//    let parameters:[String:Any] = ["appId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "platform": "I",
//                                   "lang": lang,
//                                   "uid" : uid,
//                                   "deviceID": udid,
//                                   "take": 5,
//                                   "skip": skip]

    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data =
            [
                
        ["componentName" : "SlideShow",
                             
              "title" : " Test Title",
                             
              "Slider" : [
                ["Id" : 1,"image" : "https://images.vexels.com/content/197753/preview/online-store-sale-slider-template-a3cc06.png","mediaType" : "I","type" : 1,"url" : "","itemId" : "","CategoryID" : ""],
                         
                    ["Id" : 1,"image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfrbqGrqn0RK9hu5XUeg0CBTg2TIu_wUrbIK1MvSSJ2d2rbc64BNx-1cf1UE6lE-IaGmw&usqp=CAU","mediaType" : "I","type" : 1,"url" : "","itemId" : "","CategoryID" : ""],
                        
                    ["Id" : 1,"image" : "https://previews.123rf.com/images/kaisorn/kaisorn1703/kaisorn170300156/74354120-spring-sale-poster-template-with-colorful-flower-background-can-be-use-voucher-wallpaper-flyers.jpg","mediaType" : "I","type" : 1,"url" : "","itemId" : "","CategoryID" : ""],
                        
                    ["Id" : 1,"image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUh6CiwZQklwO8UtTq9mW98wlJqyuooEChFWjNOSKAtCSq8Y1SKNusJzS8smUmLO2R6xw&usqp=CAU","mediaType" : "I","type" : 1,"url" : "","itemId" : "","CategoryID" : ""],
                         
                    ["Id" : 1,"image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwvTcY01MkGK5_7XDMIhNMPNl_w8feT2yeRvr34hCW96he71yS8-obFk7c_pvqjCYHlX4&usqp=CAU","mediaType" : "I","type" : 1,"url" : "","itemId" : "","CategoryID" : ""],
              ]
        ] ,
            
             
             ["componentName" : "PopularCategories",
                              
               "title" : "Categories",
                              
              "PopularCategories" : [
                 ["id" : "","title" : "laptop","icon" : "https://www.freeiconspng.com/thumbs/laptop-icon/laptop-icon-29.png","image" : "","hasSub" : true],                             
                 ["id" : "","title" : "desktop","icon" : "https://cdn-icons-png.flaticon.com/512/2933/2933190.png","image" : "","hasSub" : true],
                 
                 ["id" : "","title" : "Mobile","icon" : "https://cdn-icons-png.flaticon.com/512/5521/5521112.png","image" : "","hasSub" : true],
                                          
                 ["id" : "","title" : "camera","icon" : "https://cdn-icons-png.flaticon.com/256/685/685655.png","image" : "","hasSub" : true]
              ]
            ]
             
             ,
             
             ["componentName" : "Offers",
                              
               "title" : "Offers",
                 
              "Offers" : [
                
                 ["type" : "","offer" : [["id" : "","title" : "Test Offer 1","image" : "https://img.freepik.com/free-vector/realistic-horizontal-sale-banner-template-with-photo_23-2149017940.jpg?size=626&ext=jpg&ga=GA1.1.2116175301.1701129600&semt=ais","type" : "","itemId" : "","categoryId" : "","url" : ""],
                                         
                    ["id" : "","title" : "Test Offer 2","image" : "https://blog.spottabl.com/wp-content/uploads/2021/08/Offer-Shopping_-strategies-to-get-candidates-through-the-door-Sharath-Updated-1.png","type" : "","itemId" : "","categoryId" : "","url" : ""]
                                        ]],
                         
                     ["type" : "","offer" : [["id" : "","title" : "Test Offer 2","image" : "https://blog.spottabl.com/wp-content/uploads/2021/08/Offer-Shopping_-strategies-to-get-candidates-through-the-door-Sharath-Updated-1.png","type" : "","itemId" : "","categoryId" : "","url" : ""],
                                             
                        ["id" : "","title" : "Test Offer 3","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuRiGkC6t4zb7iWKlgBdbk5fTu1ci_aByD9W74wkFwZbfqPhP9JtBIjv8HDM__-QS-auU&usqp=CAU","type" : "","itemId" : "","categoryId" : "","url" : ""]]
                         
             ]
             ]
              ]
             ,
             
             ["componentName" : "items",
                              
               "title" : "items",
                 
              "items" : [
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

            ]
            ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            
            if removeAll {
                self.CollectionView.RemoveAnimations {
                    self.MainScreenData.removeAll()
                    self.Animations = true
                    self.AddData(data:data)
                }
            }else{
                self.AddData(data:data)
            }
            
            self.CollectionView.isHidden = false
            self.ViewNoData.isHidden = true
            self.ViewDots.endRefreshing(){}
            
        }
//    } Err: { error in
//    self.CollectionView.isHidden = true
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
    }
    
    func AddData(data:[[String:Any]]) {
    for item in data {
    self.MainScreenData.append(MainScreen(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.CollectionView.SetAnimations() {self.Animations = false} : self.CollectionView.reloadData()
    }
    }
    
    func refresh() {
    self.skip = 0
    self.SetMainScreen(removeAll: true)
    }
    
//    var HowItWorksHeight : NSLayoutConstraint?
//    lazy var HowItWorksView : ViewHowItWorks = {
//        let View = ViewHowItWorks()
//        View.clipsToBounds = true
//        View.backgroundColor = .clear
//        View.translatesAutoresizingMaskIntoConstraints = false
//        View.Dismiss.addTarget(self, action: #selector(DismissHowItWorks), for: .touchUpInside)
//        return View
//    }()
//
//    @objc func DismissHowItWorks() {
//    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: []) {
//    self.HowItWorksHeight?.constant = 0
//    self.StackCategoriesY?.constant = 0
//    self.ViewScroll.updateContentViewSize(ControlWidth(50))
//    self.view.layoutIfNeeded()
//    }
//    }
    
}

extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return MainScreenData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let Data = MainScreenData[indexPath.row]
    switch Data.componentName {
    case "SlideShow":
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderId, for: indexPath) as! SliderCell
    cell.backgroundColor = .white
    cell.Home = self
    cell.Slider = Data.Slider
    cell.pageControl.numberOfPages = Data.Slider.count
    return cell
    case "PopularCategories":
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesId, for: indexPath) as! CategoriesHomeCell
    cell.backgroundColor = .white
    cell.Home = self
    cell.Categories = Data.Categories
    cell.LabelCategories.text = Data.title
    return cell
    case "Offers":
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersId, for: indexPath) as! OffersHomeCell
    cell.Home = self
    cell.Offers = Data.Offers
    cell.backgroundColor = .white
    return cell
    case "items":
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsId, for: indexPath) as! ItemsHomeCell
    cell.Home = self
    cell.Items = Data.items
    cell.backgroundColor = .white
    cell.LabelItems.text = Data.title
    return cell
    default:
    return UICollectionViewCell()
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Data = MainScreenData[indexPath.row]
        switch Data.componentName {
        case "SlideShow":
        return CGSize(width: collectionView.frame.width, height: ControlWidth(220))
            
        case "PopularCategories":
        return CGSize(width: collectionView.frame.width, height: ControlWidth(110))
            
        case "Offers":
        return CGSize(width: collectionView.frame.width, height: Data.Offers.count == 2 ? ControlWidth(300): ControlWidth(150))
            
        case "items":
        return CGSize(width: collectionView.frame.width, height: ControlWidth(300))
            
        default:
        return .zero
        }
    }
}


extension HomeVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {

        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
        completionHandler()
        self.SetMainScreen(removeAll: false, ShowDots: false)
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
        completionHandler()
        self.refresh()
        }
        }
        return
        }
}
