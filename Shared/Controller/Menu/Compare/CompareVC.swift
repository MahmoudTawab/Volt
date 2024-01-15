//
//  CompareVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 13/03/2022.
//

import UIKit
import SDWebImage

class CompareVC: CollapsibleCollection {
    
    var ProductDetails : ProductDetailsVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetCompareItems()
    }
    
    fileprivate func SetUp() {
    view.addSubview(Dismiss)
    SetUpDismiss(text: "Compare".localizable)
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(38))
        
    view.addSubview(ContentView)
    ContentView.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlX(5) , width: view.frame.width , height: view.frame.height - ControlHeight(80))

    ContentView.addSubview(CompareItemsLabel)
    CompareItemsLabel.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlX(30), height: ControlWidth(80))
    
    ContentView.addSubview(MenuTapCollection)
    MenuTapCollection.translatesAutoresizingMaskIntoConstraints = false
    MenuTapCollection.topAnchor.constraint(equalTo: CompareItemsLabel.bottomAnchor).isActive = true
    MenuTapCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    MenuTapCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    MenuTapHeight = MenuTapCollection.heightAnchor.constraint(equalToConstant: 0)
    MenuTapHeight?.isActive = true
        
    self.delegate = self
    CollectionCollapsible.dataSource = self
    CollectionCollapsible.delegate = self
    ContentView.addSubview(CollectionCollapsible)
    CollectionCollapsible.translatesAutoresizingMaskIntoConstraints = false
    CollectionCollapsible.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    CollectionCollapsible.topAnchor.constraint(equalTo: MenuTapCollection.bottomAnchor,constant: ControlY(5)).isActive = true
    CollectionCollapsible.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    CollectionCollapsible.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
    CollectionCollapsible.contentInset = UIEdgeInsets(top: ControlWidth(190), left: 0, bottom: 0, right: 0)
    CollectionCollapsible.addSubview(StackImage)
    StackImage.topAnchor.constraint(equalTo: CollectionCollapsible.topAnchor,constant: ControlWidth(-180)).isActive = true
    StackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    StackImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    StackImage.heightAnchor.constraint(equalToConstant: ControlWidth(180)).isActive = true
    }
    
    lazy var ContentView:UIView = {
        let View = UIView()
        View.isHidden = true
        View.backgroundColor = .clear
        return View
    }()
    
    lazy var CompareItemsLabel : UILabel = {
        let Label = UILabel()
        return Label
    }()

    var ItemsCompare:CompareItems?
    func SetCompareItems() {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let lang = "lang".localizable
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let api = "\(url + GetCompareItems)"
//    
//    let parameters:[String:Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
//                                    "Platform": "I",
//                                    "deviceID": udid,
//                                    "lang": lang,
//                                    "firstItemId": defaults.string(forKey: "FirstItemId") ?? GUID,
//                                    "secondItemId": defaults.string(forKey: "SecondItemId") ?? GUID]
       
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let  data =  [
         "firstItemId" : "1",
         "firstItemTitle" : "iphone 13",
         "firstItemImage" : "https://mobizil.com/wp-content/uploads/2021/09/IPhone-13.jpg",
         "secondItemId" : "2",
         "secondItemTitle" : "Xiaomi Redmi 10",
         "secondItemImage" : "https://mob4g.com/wp-content/uploads/2021/09/Xiaomi-Redmi-10-Prime.webp",
        
         "ComparisonCategories" : [
            
        [
        "title": "Chipset" , "ComparisonFields" : [["title" : "Chipset","firstItemValue" : "Apple A15 Bionic (5 nm)","secondItemValue" : "MediaTek Helio G88","isRating" : false,"isDifferent" : true]]
        ],
        
        [
        "title": "GPU" , "ComparisonFields" : [["title" : "GPU","firstItemValue" : "GPU (5-core graphics)","secondItemValue" : "Mali-G52 MC2","isRating" : false,"isDifferent" : true]]
        ],
        
        [
        "title": "Inferared" , "ComparisonFields" : [["title" : "Inferared","firstItemValue" : "No","secondItemValue" : "No","isRating" : false,"isDifferent" : false]]
        ],
        
        [
        "title": "USB" , "ComparisonFields" : [["title" : "USB","firstItemValue" : "Lightning","secondItemValue" : "USB Type C","isRating" : false,"isDifferent" : true]]
        ],
        
        [
        "title": "Operating System" , "ComparisonFields" : [["title" : "Operating System","firstItemValue" : "IOS","secondItemValue" : "Android","isRating" : false,"isDifferent" : true]]
        ],
        
        [
        "title": "Wi Fi" , "ComparisonFields" : [["title" : "Wi Fi","firstItemValue" : "Yes","secondItemValue" : "Yes","isRating" : false,"isDifferent" : false]]
        ],
        
        [
        "title": "Bluetooth" , "ComparisonFields" : [["title" : "Bluetooth","firstItemValue" : "5" , "secondItemValue" : "5.1","isRating" : false,"isDifferent" : true]]
        ],
        
        [
        "title": "Dimensions" , "ComparisonFields" : [["title" : "Dimensions","firstItemValue" : "160.8 x 78.1 x 7.7 mm","secondItemValue" : "162 x 75.5 x 8.9 mm","isRating" : false,"isDifferent" : true]]
        ],
        
        [
        "title": "Display Details" , "ComparisonFields" : [["title" : "Display Details","firstItemValue" : "Super Retina XDR OLED, 6.7 inches, 1284 x 2778","secondItemValue" : "Resolution: 1080 x 2400 pixels, 20:9 ratio","isRating" : false,"isDifferent" : true]]
        ]
        
        ,
        
        
        [
        "title": "Network" , "ComparisonFields" : [["title" : "Network","firstItemValue" : "3G, 4G, 5G","secondItemValue" : "3G, 4G","isRating" : false,"isDifferent" : true]]
        ],
        
        
        [
        "title": "Brand" , "ComparisonFields" : [["title" : "Brand","firstItemValue" : "Apple","secondItemValue" : "Xiaomi","isRating" : false,"isDifferent" : true]]
        ],
        
        
        [
        "title": "Sensors" , "ComparisonFields" : [["title" : "Sensors","firstItemValue" : "Face ID, accelerometer, gyro","secondItemValue" : "accelerometer, proximity, compass","isRating" : false,"isDifferent" : true]]
        ]
            
        ]
        ] as [String : Any]
        
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
    self.ItemsCompare = CompareItems(dictionary: data)
    self.NoItemCompare()
    }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.ContentView.isHidden = true
//    self.SetUpIsError(error,true) {self.SetCompareItems()}
//    }
    }
    
    func SetCompareItemsData() {
    let attributedString = NSMutableAttributedString(string: "\(ItemsCompare?.firstItemTitle ?? "")", attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    ])

    if ItemsCompare?.firstItemTitle != "" && ItemsCompare?.secondItemTitle != "" {
    attributedString.append(NSAttributedString(string: " VS ", attributes: [
    .font: UIFont(name: "Muli-SemiBold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
    .foregroundColor: #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
    ]))
    }
        
    attributedString.append(NSAttributedString(string: "\(ItemsCompare?.secondItemTitle ?? "")", attributes: [
    .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    ]))
        
    CompareItemsLabel.numberOfLines = 0
    CompareItemsLabel.attributedText = attributedString
    CompareItemsLabel.backgroundColor = .clear
        
    FirstImage.LabelProduct.text = ItemsCompare?.firstItemTitle ?? ""
    FirstImage.StackAdd.isHidden = ItemsCompare?.firstItemTitle == "" ? false : true
    FirstImage.IconRemove.isHidden = ItemsCompare?.firstItemTitle != "" ? false : true
    FirstImage.ImageProduct.sd_setImage(with: URL(string: ItemsCompare?.firstItemImage ?? ""))
       
    SecondImage.LabelProduct.text = ItemsCompare?.secondItemTitle ?? ""
    SecondImage.StackAdd.isHidden = ItemsCompare?.secondItemTitle == "" ? false : true
    SecondImage.IconRemove.isHidden = ItemsCompare?.secondItemTitle != "" ? false : true
    SecondImage.ImageProduct.sd_setImage(with: URL(string: ItemsCompare?.secondItemImage ?? ""))
    }
    
    
    // setUp Top view image
    lazy var StackImage : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FirstImage,SecondImage])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var FirstImage : TopViewImage = {
        let View = TopViewImage()
        View.IconRemove.addTarget(self, action: #selector(FirstImageRemove), for: .touchUpInside)
        View.AddImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddFirstProduct)))
        return View
    }()
    
    @objc func FirstImageRemove() {
    ShowMessageAlert("warning", "Warning Remove Compare".localizable, "Are You Sure You Want to Delete this Item From Compare".localizable, false, self.RemoveFirst, "Delete".localizable)
    }
    
    func RemoveFirst() {
    defaults.removeObject(forKey: "FirstItemId")
    defaults.removeObject(forKey: "FirstSubCategory")
    ProductDetails?.SetCompare()
    SetCompareItems()
    }
    
    @objc func AddFirstProduct() {
        let Item = ItemCategories()
        Item.CategoryId = defaults.string(forKey: "SecondSubCategory")
        Item.SetCategoryItems(removeAll: true)
        Item.SetUpDismiss(text: "back".localizable)
        Present(ViewController: self, ToViewController: Item)
    }

    lazy var SecondImage : TopViewImage = {
        let View = TopViewImage()
        View.IconRemove.addTarget(self, action: #selector(SecondImageRemove), for: .touchUpInside)
        View.AddImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddSecondProduct)))
        return View
    }()
    
    @objc func SecondImageRemove() {
    ShowMessageAlert("warning", "Warning Remove Compare".localizable, "Are You Sure You Want to Delete this Item From Compare".localizable, false, self.RemoveSecond, "Delete".localizable)
    }
    
    func RemoveSecond() {
    defaults.removeObject(forKey: "SecondItemId")
    defaults.removeObject(forKey: "SecondSubCategory")
    ProductDetails?.SetCompare()
    SetCompareItems()
    }

    @objc func AddSecondProduct() {
    let Item = ItemCategories()
    Item.CategoryId = defaults.string(forKey: "FirstSubCategory")
    Item.SetUpDismiss(text: "back".localizable)
    Item.SetCategoryItems(removeAll: true)
    Present(ViewController: self, ToViewController: Item)
    }
    
    var MenuID = "Menu"
    var selectedIndex = 0
    var indicatorView = UIView()
    let indicatorHeight:CGFloat = ControlWidth(4)
    var MenuTitles = ["Full Comparison".localizable,"Differences".localizable]
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    lazy var MenuTapCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(MenuTapCell.self, forCellWithReuseIdentifier: MenuID)
        return vc
    }()
    
    func SetupSwipe() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
            leftSwipe.direction = .left
            self.view.addGestureRecognizer(leftSwipe)
            
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
            rightSwipe.direction = .right
            self.view.addGestureRecognizer(rightSwipe)
        
        indicatorView.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        indicatorView.layer.cornerRadius = ControlWidth(2)
        indicatorView.frame = CGRect(x: MenuTapCollection.bounds.minX, y: MenuTapCollection.bounds.maxY - indicatorHeight, width: MenuTapCollection.bounds.width / CGFloat( MenuTitles.count), height: indicatorHeight)
        
        MenuTapCollection.addSubview(indicatorView)
        MenuTapCollection.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
    }

    @objc func swipeAction(_ sender:UISwipeGestureRecognizer) {
     if sender.direction == .left {
         if selectedIndex < MenuTitles.count - 1 {
             selectedIndex += 1
         }
     }else{
         if selectedIndex > 0 {
             selectedIndex -= 1
         }
     }
        
     MenuTapCollection.reloadData()
     CollectionCollapsible.reloadData()
     selectedIndexPath = IndexPath(item: selectedIndex, section: 0)
     MenuTapCollection.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredVertically)
     refreshContent()
     }
     
     func refreshContent() {
     let desiredx = MenuTapCollection.bounds.width / CGFloat(MenuTitles.count) * CGFloat(selectedIndex)
     UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.55, options: []) {
     self.indicatorView.frame = CGRect(x: desiredx , y: self.MenuTapCollection.bounds.maxY - self.indicatorHeight, width: self.MenuTapCollection.bounds.width / CGFloat( self.MenuTitles.count), height: self.indicatorHeight)
     }
     }
    
    var MenuTapHeight:NSLayoutConstraint?
    func NoItemCompare() {
        ViewDots.endRefreshing{}
        if ItemsCompare?.firstItemId == "" && ItemsCompare?.secondItemId == "" {
        ContentView.isHidden = true
        ViewNoData.isHidden = false
        ViewNoData.RefreshButton.isHidden = true
        ViewNoData.ImageIcon = "Compare"
        ViewNoData.MessageTitle = "No Products Found".localizable
        ViewNoData.MessageDetails = "You haven’t added any products to your compare list, shop now and add".localizable
        }else{
        ViewNoData.isHidden = true
        ContentView.isHidden = false
        SetCompareItemsData()
        CollectionCollapsible.SetAnimations()
        }
        if ItemsCompare?.firstItemId != "" && ItemsCompare?.secondItemId != "" {
        MenuTapHeight?.constant = ControlWidth(50)
        view.layoutIfNeeded()
        SetupSwipe()
        }else{
        MenuTapHeight?.constant = 0
        view.layoutIfNeeded()
        }
    }
}

// MARK: - Section Header Delegate
extension CompareVC: CategoriesHeaderDelegate {
    func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        self.CollectionCollapsible.reloadSections(IndexSet(sectionsNeedReload))
        
        let lastItem = self.CollectionCollapsible.numberOfItems(inSection: section) - 1
        guard lastItem >= 0 else { return }
        let lastItemIndexPath = IndexPath(item: lastItem, section: section)
                
        self.CollectionCollapsible.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}


extension CompareVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,CollapsibleCollectionSectionDelegate {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return collectionView == MenuTapCollection ? 1 : ItemsCompare?.Categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == MenuTapCollection {
    return MenuTitles.count
    }else{
    return isSectionCollapsed(section) ? 0 : ItemsCompare?.Categories[section].Fields.count ?? 0
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == MenuTapCollection {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuID, for: indexPath) as! MenuTapCell
        cell.MenuLabel.text = MenuTitles[indexPath.item]
        cell.MenuLabel.textColor = selectedIndex == indexPath.item ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.MenuLabel.font = selectedIndex == indexPath.item ? UIFont(name: "Muli-SemiBold", size: ControlWidth(17)) : UIFont(name: "Muli-Bold", size: ControlWidth(16))
        return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellCompare, for: indexPath) as! CompareCollectionCell

        let section = ItemsCompare?.Categories[indexPath.section].Fields
        cell.TitleLabel.text = section?[indexPath.item].title ?? ""
        cell.backgroundColor = indexPath.item % 2 == 0 ? .white : #colorLiteral(red: 0.9558447003, green: 0.9558447003, blue: 0.9558447003, alpha: 1)
        
        if selectedIndex == 1 {
        cell.FirstValue.textColor = section?[indexPath.item].isDifferent == true ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 0.7535924309, green: 0.7535924309, blue: 0.7535924309, alpha: 1)
        cell.SecondValue.textColor = section?[indexPath.item].isDifferent == true ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 0.7535924309, green: 0.7535924309, blue: 0.7535924309, alpha: 1)
        }else{
        cell.FirstValue.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.SecondValue.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }

        if section?[indexPath.item].isRating ?? false {
        cell.StackRating.isHidden = false
        cell.StackLabel.isHidden = true
        cell.FirstRating.rating = section?[indexPath.item].firstItemValue?.toDouble() ?? 1.0
        cell.SecondRating.rating = section?[indexPath.item].secondItemValue?.toDouble() ?? 1.0
        cell.FirstRating.isHidden = section?[indexPath.item].firstItemValue == "" ? true : false
        cell.SecondRating.isHidden = section?[indexPath.item].secondItemValue == "" ? true : false
        }else{
        cell.StackRating.isHidden = true
        cell.StackLabel.isHidden = false
        cell.FirstValue.text = section?[indexPath.item].firstItemValue ?? ""
        cell.SecondValue.text = section?[indexPath.item].secondItemValue ?? ""
        }
        return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if collectionView == CollectionCollapsible {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ViewHeader", for: indexPath) as! CategoriesHeader
    header.ImageView.isHidden = true
    header.BackgroundView.backgroundColor = #colorLiteral(red: 0.9116356969, green: 0.9114078879, blue: 0.9287173748, alpha: 1)
    header.toggleButton.image = UIImage(named: "minimize")
    header.titleLabel.font = UIFont(name: "Muli-Bold", size: ControlWidth(15))
    header.titleLabel.text = ItemsCompare?.Categories[indexPath.section].title
    header.section = indexPath.section
    header.delegate = self
    return header
    }else{
    return UICollectionReusableView()
    }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return collectionView == CollectionCollapsible ? CGSize(width: collectionView.frame.width, height: ControlWidth(50)):.zero
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == MenuTapCollection {
    return CGSize(width: collectionView.frame.width / CGFloat(MenuTitles.count), height: collectionView.bounds.height)
    }else{
    let firstItem = ItemsCompare?.Categories[indexPath.section].Fields[indexPath.item].firstItemValue ?? ""
    let secondItem = ItemsCompare?.Categories[indexPath.section].Fields[indexPath.item].secondItemValue ?? ""
    let Item = firstItem.count > secondItem.count ? firstItem : secondItem

    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    let size = CGSize(width: 250, height: 1500)

    let estimatedFrame = NSString(string: Item).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: ControlWidth(15))], context: nil)
    return CGSize(width: collectionView.frame.width - ControlX(20), height: estimatedFrame.height + ControlWidth(60))
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == MenuTapCollection {
        selectedIndex = indexPath.item
        MenuTapCollection.reloadData()
        CollectionCollapsible.reloadData()
        refreshContent()
        }
    }
    
    func shouldCollapseByDefault(_ collectionView: UICollectionView) -> Bool {
    return false
    }
    
    func shouldCollapseOthers(_ collectionView: UICollectionView) -> Bool {
    return false
    }
}

