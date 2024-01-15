//
//  OffersVC.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 29/12/2021.
//

import UIKit

class OffersVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    view.backgroundColor = .white
    SetUpTableView()
    }
    
    @objc func SetUpTableView() {

        view.addSubview(SearchBar)
        SearchBar.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
             
        view.addSubview(CollectionOffers)
        CollectionOffers.frame = CGRect(x: ControlX(10), y: SearchBar.frame.maxY + ControlY(15), width: view.frame.width - ControlX(20), height: view.frame.height - ControlHeight(150))
        
        SetMainOffers(removeAll: true)
    }

   var OffersID = "Offers"
   lazy var CollectionOffers: CollectionAnimations = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       layout.minimumLineSpacing = ControlWidth(10)
       let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
       vc.dataSource = self
       vc.delegate = self
       
       let refreshView = KRPullLoadView()
       refreshView.delegate = self
       vc.addPullLoadableView(refreshView, type: .refresh)
       let loadMoreView = KRPullLoadView()
       loadMoreView.delegate = self
       vc.addPullLoadableView(loadMoreView, type: .loadMore)
       
       vc.indicatorStyle = .white
       vc.backgroundColor = .white
       vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
       vc.register(CollectionOffersCell.self, forCellWithReuseIdentifier: OffersID)
       return vc
   }()

        
    var skip = 0
    var Animations = true
    var fetchingMore = false
    var MainOffersData = [MainOffers]()
    func SetMainOffers(removeAll:Bool = false, ShowDots:Bool = true) {
        
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let api = "\(url + GetOffers)"
//    
//    let lang = "lang".localizable
//    let parameters:[String:Any] = ["appId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "platform": "I",
//                                   "lang": lang,
//                                   "take": 5,
//                                   "skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
            
            ["type" : "","offer" : [["id" : "","title" : "Test Offer 1","image" : "https://img.freepik.com/free-vector/realistic-horizontal-sale-banner-template-with-photo_23-2149017940.jpg?size=626&ext=jpg&ga=GA1.1.2116175301.1701129600&semt=ais","type" : "","itemId" : "","categoryId" : "","url" : ""],
                                    
               ["id" : "","title" : "Test Offer 2","image" : "https://blog.spottabl.com/wp-content/uploads/2021/08/Offer-Shopping_-strategies-to-get-candidates-through-the-door-Sharath-Updated-1.png","type" : "","itemId" : "","categoryId" : "","url" : ""]]],
                    
                ["type" : "","offer" : [["id" : "","title" : "Test Offer 2","image" : "https://blog.spottabl.com/wp-content/uploads/2021/08/Offer-Shopping_-strategies-to-get-candidates-through-the-door-Sharath-Updated-1.png","type" : "","itemId" : "","categoryId" : "","url" : ""],
                                        
                   ["id" : "","title" : "Test Offer 3","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuRiGkC6t4zb7iWKlgBdbk5fTu1ci_aByD9W74wkFwZbfqPhP9JtBIjv8HDM__-QS-auU&usqp=CAU","type" : "","itemId" : "","categoryId" : "","url" : ""]]],
            
            ["type" : "","offer" : [["id" : "","title" : "Test Offer 2","image" : "https://assets.mspimages.in/gear/wp-content/uploads/2021/09/Panasonic-Grand-Delights.jpeg","type" : "","itemId" : "","categoryId" : "","url" : ""],
                                    
               ["id" : "","title" : "Test Offer 3","image" : "https://images.hindustantimes.com/tech/img/2020/10/05/960x540/Panasonic_1601897522032_1601897549198.jpg","type" : "","itemId" : "","categoryId" : "","url" : ""]]],
            
            ["type" : "","offer" : [["id" : "","title" : "Test Offer 2","image" : "https://www.shoppirate.in/blog/wp-content/uploads/2015/10/Amazon-diwali-sale.jpg","type" : "","itemId" : "","categoryId" : "","url" : ""],
                                    
               ["id" : "","title" : "Test Offer 3","image" : "https://www.kindpng.com/picc/m/61-613849_diwali-offer-home-appliances-png-download-diwali-offers.png","type" : "","itemId" : "","categoryId" : "","url" : ""]]],
            
            ["type" : "","offer" : [["id" : "","title" : "Test Offer 2","image" : "https://www.dealsshutter.com/blog/wp-content/uploads/2020/10/diwali-offers-on-electronics.png","type" : "","itemId" : "","categoryId" : "","url" : ""],
                                    
               ["id" : "","title" : "Test Offer 3","image" : "https://www.bajajmall.in/content/dam/emistoremarketplace/index/10-10-22/himalay/slider/clearance_Sale_Slider_1st_Mob_B2B_Generic.jpg","type" : "","itemId" : "","categoryId" : "","url" : ""]]]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if removeAll {
                
                self.CollectionOffers.RemoveAnimations {
                    self.MainOffersData.removeAll()
                    self.Animations = true
                    self.AddData(dictionary:data)
                }
            }else{
                self.AddData(dictionary:data)
            }
            
            self.ViewNoData.isHidden = true
            self.ViewDots.endRefreshing(){}
            self.CollectionOffers.isHidden = false
            
        }
//    } Err: { error in
//    self.CollectionOffers.isHidden = true
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
    }
    
    
    func AddData(dictionary:[[String:Any]]) {
    for item in dictionary {
    self.MainOffersData.append(MainOffers(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.CollectionOffers.SetAnimations() {self.Animations = false} : self.CollectionOffers.reloadData()
    }
    }
    
    
    @objc func refresh() {
    skip = 0
    SetMainOffers(removeAll: true)
    }
}


extension OffersVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return MainOffersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainOffersData[section].OfferType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersID, for: indexPath) as! CollectionOffersCell
                
    let OffersSection = MainOffersData[indexPath.section]
    if let Image = OffersSection.OfferType[indexPath.item].image {
    cell.Image.sd_setImage(with: URL(string: Image), placeholderImage: UIImage(named: "Group 26056"))
    }
                
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return MainOffersData[indexPath.section].type == "Single" ?
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3.8):
        CGSize(width: collectionView.frame.width  / 2.06, height: collectionView.frame.height  / 3.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        } else {
            return UIEdgeInsets(top: 10.0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let OffersSection = MainOffersData[indexPath.section].OfferType[indexPath.item]
            if OffersSection.itemId != "" {
            if let itemId = OffersSection.itemId {
            let ProductDetails = ProductDetailsVC()
            ProductDetails.GetProduct(ProductId: itemId)
            Present(ViewController: self, ToViewController: ProductDetails)
            }
            }
        
            if OffersSection.categoryId != "" {
            if let CategoryId = OffersSection.categoryId {
            let Categories = ItemCategories()
            Categories.CategoryId = CategoryId
            Categories.SetUpDismiss(text: "Offers")
            Categories.SetCategoryItems(removeAll: true)
            Present(ViewController: self, ToViewController: Categories)
            }
            }
        
            if OffersSection.url != "" {
            if let url = OffersSection.url {
            if let whatsappURL = URL(string: url) {
            if UIApplication.shared.canOpenURL(whatsappURL) {
            if #available(iOS 10.0, *) {
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            }else {
            UIApplication.shared.openURL(whatsappURL)
            }
            }
            }
            }
            }
    }

}

extension OffersVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.SetMainOffers(removeAll: false, ShowDots: false)
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
        self.refresh()
        }
        }
        return
        }
}
