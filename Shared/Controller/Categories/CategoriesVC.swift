//
//  CategoriesVC.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 29/12/2021.
//

import UIKit
import SDWebImage
import FirebaseAuth

class CategoriesVC: CollapsibleCollection ,CollapsibleCollectionSectionDelegate ,CategoriesCellDelegate, UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    SetUpTableView()
    }
    
    @objc func SetUpTableView() {
        
        CollectionCollapsible.dataSource = self
        CollectionCollapsible.delegate = self
        self.delegate = self
        
        view.addSubview(SearchBar)
        SearchBar.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
                
        view.addSubview(CollectionCollapsible)
        CollectionCollapsible.frame = CGRect(x: 0, y: SearchBar.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(150))
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        CollectionCollapsible.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        CollectionCollapsible.addPullLoadableView(loadMoreView, type: .loadMore)
        SetMainCategories(removeAll: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return CategoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return isSectionCollapsed(section) ? 0 : 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellCategories, for: indexPath) as! CategoriesCell
        cell.Delegate = self
        cell.CategoriesData = CategoriesData[indexPath.section]
        cell.backgroundColor = .white
        return cell
    }
    
    func ActionViewAll(_ Cell: CategoriesCell) {
    if let index = CollectionCollapsible.indexPath(for: Cell) {
    let Item = ItemCategories()
    Item.CategoryId = CategoriesData[index.section].id
    Item.SetCategoryItems(removeAll: true)
    Item.SetUpDismiss(text: CategoriesData[index.section].title ?? "")
    Present(ViewController: self, ToViewController: Item)
    }
    }
    
    func ActionCollection(_ Cell: CategoriesCell ,_ IndexSelect:IndexPath) {
    if let index = CollectionCollapsible.indexPath(for: Cell) {
    let Categories = CategoriesData[index.section].SubCategories
    let Item = ItemCategories()
    Item.CategoryId = Categories[IndexSelect.item].id
    Item.SetCategoryItems(removeAll: true)
    Item.SetUpDismiss(text: Categories[IndexSelect.item].title ?? "")
    Present(ViewController: self, ToViewController: Item)
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ViewHeader", for: indexPath) as! CategoriesHeader
    header.ImageView.isHidden = false
    header.BackgroundView.backgroundColor = .white
    header.toggleButton.image = UIImage(named: "Path")
    header.titleLabel.text = CategoriesData[indexPath.section].title
    header.ImageView.sd_setImage(with: URL(string: CategoriesData[indexPath.section].icon ?? ""))
    header.setCollapsed(isSectionCollapsed(indexPath.section))
    header.section = indexPath.section
    header.delegate = self
        
    if Animations {
    let animations = [AnimationType.vector((CGVector(dx: 0, dy: ControlX(80)))),AnimationType.from(direction: .top, offset: ControlX(100))]
    CollectionCollapsible.performBatchUpdates({
    UIView.animate(views: [header],
    animations: animations,duration: 0.5, options: [.curveEaseInOut],completion: {
    self.Animations = false
    })
    }, completion: nil)
    }
    return header
    }

        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width - ControlX(20), height: ControlWidth(60))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = CategoriesData[indexPath.section].SubCategories.count == 0 ? ControlWidth(70):ControlWidth(260)
    return CGSize(width: collectionView.frame.width - ControlX(20), height: height)
    }

    func shouldCollapseByDefault(_ collectionView: UICollectionView) -> Bool {
    return true
    }
    
    func shouldCollapseOthers(_ collectionView: UICollectionView) -> Bool {
    return false
    }
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    var CategoriesData = [Categories]()
    func SetMainCategories(removeAll:Bool = false, ShowDots:Bool = true) {

//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//        
//    let api = "\(url + GetCategories)"
//    
//    let lang = "lang".localizable
//    let parameters:[String:Any] = ["appId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                   "platform": "I",
//                                   "lang": lang,
//                                   "take": 15,
//                                   "skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
  
        let data = [
            ["id" : "","title" : "laptop","icon" : "https://www.freeiconspng.com/thumbs/laptop-icon/laptop-icon-29.png","image" : "","hasSub" : true,
             "SubCategories":[
                ["id" : "","title" : "laptop","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt0F0YaRMS3NnXJOq48Rvjs_pt5QvFV-4NwDvBLwMCkY-sJ2UXI0o4u_ibxlvDZ-vUm4g&usqp=CAU","hasSub" : true],
                ["id" : "","title" : "laptop","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToxL4Bwu2PUmbEC7xPusuyx7VW36aAoH_XpEVkss09dWneuWNiTZlyiNC2r0HJ1QNh6x4&usqp=CAU","hasSub" : false],
                ["id" : "","title" : "laptop","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk3FGOP4cQJYJ1N4kZ1tu-wwiymEzg_MXRzmUp6mANI0NVbmt5tm0DxXeKRvTroIe_dFk&usqp=CAU","hasSub" : true],
                ["id" : "","title" : "laptop","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5RNRNtukmEOootsL3c7GQo5FukaxUQ_HBtOUJ8J7WA-S8ya2B-rlVgwcAeu8EF4_B_OA&usqp=CAU","hasSub" : true]]
            ],
                        
            ["id" : "","title" : "Mobile","icon" : "https://cdn-icons-png.flaticon.com/512/5521/5521112.png","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSz4RJXwhGzGZIW2SghwFHrsr39KDkvb2V9lgtJEawmi2b7Rt7JuPkr4Hc-VR1DpCxYBc&usqp=CAU","hasSub" : true,
             "SubCategories":[
            ["id" : "","title" : "Mobile","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRER4neaeH4o-wfm2arUPXQjWIXpdnroYo9NrB4BJi1GmT91J30-GjXy6Cc-fti0MZuER8&usqp=CAU","hasSub" : true],
            ["id" : "","title" : "Mobile","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeGLXbkfO1zOV8imzq-32xsou6hFx1sV2hNixyYLYqAQsh9tccdjvL-eBSGZ7jJyx5F3s&usqp=CAU","hasSub" : true],
            ["id" : "","title" : "Mobile","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwp1k7CAkOM69WgM3V0v7X634sseLDkyAvcOCtg91bykdiuciCsRQDp3aMK4sW4yVmy1Q&usqp=CAU","hasSub" : true],
            ["id" : "","title" : "Mobile","icon" : "","image" : "https://waltonbd.com/image/catalog/home-page/half-block/nexg-n6-block.jpg","hasSub" : true]
            
            ]],
                        
            ["id" : "","title" : "desktop","icon" : "https://cdn-icons-png.flaticon.com/512/2933/2933190.png","image" : "","hasSub" : true,
             "SubCategories":[
             ["id" : "","title" : "desktop","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnygxXQOHDFwCMYqJs8a6PnifFfxyXBV78OK83RL2ykkfH2HFR3ZMrku_76IruyT0zOpI&usqp=CAU","hasSub" : true],
             
             ["id" : "","title" : "desktop","icon" : "","image" : "https://5.imimg.com/data5/SELLER/Default/2020/9/TO/NG/BR/45291089/hp-desktop-computer-500x500.jpg","hasSub" : true],
             
             ["id" : "","title" : "desktop","icon" : "","image" : "https://5.imimg.com/data5/SK/OO/BC/ANDROID-52047383/images-jpeg-500x500.jpeg","hasSub" : true],
             
             ["id" : "","title" : "desktop","icon" : "","image" : "https://5.imimg.com/data5/SELLER/Default/2022/12/FN/ZL/OJ/3866941/desktop-computer.jpg","hasSub" : true],
             ]],
                        
                                     
            ["id" : "","title" : "camera","icon" : "https://cdn-icons-png.flaticon.com/256/685/685655.png","image" : "","hasSub" : true,"SubCategories":[
            
            ["id" : "","title" : "camera","icon" : "","image" : "https://www.pricepoint.co.ke/wp-content/uploads/2022/05/Canon-EOS-R6-400x400.png","hasSub" : true],
            
            ["id" : "","title" : "camera","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrphR7XOkFJ6SSNCBqcIVIYqqc8zzVMp4VYgnyswkgH2gbQM7MXO1k8qOp6cIoOAuwKbA&usqp=CAU","hasSub" : true],
            
            ["id" : "","title" : "camera","icon" : "","image" : "https://revimg03.kakaku.k-img.com/images/smartphone/icv/review_651567_l.jpg","hasSub" : true],
            
            ["id" : "","title" : "camera","icon" : "","image" : "https://store.canon.jp/img/goods/L/5137C008.jpg","hasSub" : true]
            ]]
         ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if removeAll {
                self.CollectionCollapsible.RemoveAnimations {
                    self.CategoriesData.removeAll()
                    self.Animations = true
                    self.AddData(dictionary:data)
                }
            }else{
                self.AddData(dictionary:data)
            }
            
            self.ViewNoData.isHidden = true
            self.ViewDots.endRefreshing(){}
            self.CollectionCollapsible.isHidden = false
            
        }
//    }Err: { error in
//    self.CollectionCollapsible.isHidden = true
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
    }
    
    func AddData(dictionary:[[String:Any]]) {
    for item in dictionary {
    self.CategoriesData.append(Categories(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.CollectionCollapsible.reloadData()
    }
    }
    
    @objc func refresh() {
    skip = 0
    SetMainCategories(removeAll: true)
    }
    
}


// MARK: - Section Header Delegate
extension CategoriesVC: CategoriesHeaderDelegate {
    func toggleSection(_ section: Int) {
        if CategoriesData[section].hasSub ?? false {
        let sectionsNeedReload = getSectionsNeedReload(section)
        self.CollectionCollapsible.reloadSections(IndexSet(sectionsNeedReload))
        
        let lastItem = self.CollectionCollapsible.numberOfItems(inSection: section) - 1
        guard lastItem >= 0 else { return }
        let lastItemIndexPath = IndexPath(item: lastItem, section: section)
        
//        if let cell = self.CollectionCollapsible.cellForItem(at: lastItemIndexPath) as? CategoriesCell {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//        cell.CollectionCell.reloadData()
//        }
//        }
        
        self.CollectionCollapsible.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
        }else{
        let Item = ItemCategories()
        Item.CategoryId = CategoriesData[section].id
        Item.SetCategoryItems(removeAll: true)
        Item.SetUpDismiss(text: CategoriesData[section].title ?? "")
        Present(ViewController: self, ToViewController: Item)
        }
    }
}


extension CategoriesVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {

        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.SetMainCategories(removeAll: false, ShowDots: false)
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
