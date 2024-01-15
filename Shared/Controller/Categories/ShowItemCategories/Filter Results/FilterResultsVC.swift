//
//  FilterResultsVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 19/02/2022.
//

import UIKit

class FilterResultsVC: ViewController, UITableViewDelegate, UITableViewDataSource ,CategoriesAndBrandDelegate ,FilterPriceDelegate ,FilterRateCellDelegate ,FilterColorCellDelegate ,FilterSizeCellDelegate {
            
    var CategoryId:String?
    let Rate = [5,4,3,2,1]
    let HeaderFilter = ["Sub Categories".localizable,"brand".localizable,"Price".localizable,"Rate".localizable,"Color".localizable,"Size".localizable]
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUp()
        FilterGet(parameters: Parameters())
    }
    
    fileprivate func SetUp() {

    view.addSubview(Dismiss)
    SetUpDismiss(text: "Filter Results".localizable, ShowSearch: true, ShowShopping: true)
    Dismiss.translatesAutoresizingMaskIntoConstraints = false
    Dismiss.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlY(40)).isActive = true
    Dismiss.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlWidth(-100)).isActive = true
    Dismiss.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(10)).isActive = true
    Dismiss.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
        
    view.addSubview(ResetButton)
    ResetButton.translatesAutoresizingMaskIntoConstraints = false
    ResetButton.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlY(40)).isActive = true
    ResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-10)).isActive = true
    ResetButton.heightAnchor.constraint(equalToConstant: ControlWidth(38)).isActive = true
    ResetButton.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        
    view.addSubview(TableView)
    TableView.frame = CGRect(x: 0, y: ControlY(95), width: view.frame.width , height: view.frame.height - ControlHeight(70))
        
    TableView.tableFooterView = FooterView
    FooterView.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: ControlWidth(90))
        
    FooterView.addSubview(ApplyFiltersButton)
    ApplyFiltersButton.frame = CGRect(x: ControlX(15), y: ControlX(20), width: view.frame.width - ControlX(30), height: ControlWidth(50))
    }
    
    lazy var ResetButton : UIButton = {
        let Button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Reset".localizable, attributes: [
            .font: UIFont(name: "Muli-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.06842547655, green: 0.1572898328, blue: 0.537772119, alpha: 1) ,
            .underlineStyle: NSUnderlineStyle.single.rawValue ,
            .backgroundColor: UIColor.white
        ])

        Button.contentHorizontalAlignment = .center
        Button.contentVerticalAlignment = .center
        Button.setAttributedTitle(attributedString, for: .normal)
        Button.addTarget(self, action: #selector(ActionReset), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionReset() {
        MaxValue = 0
        MinValue = 0
        RateData.removeAll()
        SizeData.removeAll()
        ColorData.removeAll()
        BrandsData.removeAll()
        CategoriesSelect = nil
        FilterGet(parameters: Parameters())
    }

    let Brand = "Brand"
    let Categories = "Categories"
    let FilterRate = "FilterRate"
    let FilterPrice = "FilterPrice"
    let FilterSize = "FilterSize"
    let FilterColor = "FilterColor"
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.register(CategoriesAndBrandCell.self, forCellReuseIdentifier: Categories)
        tv.register(CategoriesAndBrandCell.self, forCellReuseIdentifier: Brand)
        tv.register(FilterPriceCell.self, forCellReuseIdentifier: FilterPrice)
        tv.register(FilterRateCell.self, forCellReuseIdentifier: FilterRate)
        tv.register(FilterColorCell.self, forCellReuseIdentifier: FilterColor)
        tv.register(FilterSizeCell.self, forCellReuseIdentifier: FilterSize)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HeaderFilter.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
        return CategoriesOpen ? DataFilter?.SubCategories.count ?? 0 : 0
        case 1:
        return BrandOpen ? DataFilter?.Brand.count ?? 0 : 0
        case 2:
        return 1
        case 3:
        return Rate.count
        case 4:
        return 1
        case 5:
        return 1
        default:
        return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: Categories, for: indexPath) as! CategoriesAndBrandCell
        if let SubCategories = DataFilter?.SubCategories[indexPath.row].title {
        cell.CheckboxButton.Select(IsSelect: CategoriesSelect == indexPath ? true : false,text: SubCategories)
        cell.Delegate = self
        }
        return cell
            
        case 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: Brand, for: indexPath) as! CategoriesAndBrandCell
        if let title = DataFilter?.Brand[indexPath.row].title , let Id = DataFilter?.Brand[indexPath.row].id {
        cell.CheckboxButton.Select(IsSelect: BrandsData.contains(where: {$0 == Id}) ? true:false ,text: title)
        cell.Delegate = self
        }
        return cell
            
        case 2:
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterPrice, for: indexPath) as! FilterPriceCell
        if let DataFilter = DataFilter {
        cell.SliderPrice.minValue = CGFloat(DataFilter.minPrice?.toDouble() ?? 0.0)
        cell.SliderPrice.maxValue = CGFloat(DataFilter.maxPrice?.toDouble() ?? 0.0)
        cell.SliderPrice.selectedMinValue = CGFloat(DataFilter.minPrice?.toDouble() ?? 0.0)
        cell.SliderPrice.selectedMaxValue = CGFloat(DataFilter.maxPrice?.toDouble() ?? 0.0)
        
        cell.MinPrice.text = "lang".localizable == "en" ? DataFilter.minPrice:DataFilter.minPrice?.NumAR()
        cell.MaxPrice.text = "lang".localizable == "en" ? DataFilter.maxPrice:DataFilter.maxPrice?.NumAR()
        cell.Delegate = self
        }
        return cell
            
        case 3:
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterRate, for: indexPath) as! FilterRateCell
        cell.ViewRating.rating = Double(Rate[indexPath.row])
        cell.ViewRating.text = "lang".localizable == "en" ? "\(Rate[indexPath.row])":"\(Rate[indexPath.row])".NumAR()
        cell.CheckboxButton.Select(IsSelect: RateData.contains(where: {$0 == Rate[indexPath.row]}) ? true:false ,text: "")
        cell.Delegate = self
    
        return cell
            
        case 4:
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterColor, for: indexPath) as! FilterColorCell
        if let DataFilter = DataFilter?.Colors {
        cell.Colors = DataFilter
        cell.Delegate = self
        cell.CollectionColor.reloadData()
        }

        return cell
        case 5:
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterSize, for: indexPath) as! FilterSizeCell
        if let DataFilter = DataFilter?.Sizes {
        cell.Sizes = DataFilter
        cell.Delegate = self
        cell.CollectionSize.reloadData()
        }

        return cell
        default:
        return UITableViewCell()
        }
    }

    var BrandsData = [String]()
    var CategoriesSelect : IndexPath?
    func CategoriesAndBrandAction(_ Cell: CategoriesAndBrandCell) {
    if let Index = TableView.indexPath(for: Cell) {
        if Index.section == 0 {
        if CategoriesSelect == Index {
        CategoriesSelect = CategoriesSelect == nil ? Index : nil
        }else{
        CategoriesSelect = Index
        }
        TableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        FilterGet(parameters: Parameters())
        }else{
        if let Id = DataFilter?.Brand[Index.row].id {
        if BrandsData.contains(Id) {
        if let index = BrandsData.firstIndex(of: Id) {
        BrandsData.remove(at: index)
        TableView.reloadRows(at: [Index], with: .automatic)
        FilterGet(parameters: Parameters())
        }
        }else{
        BrandsData.append(Id)
        TableView.reloadRows(at: [Index], with: .automatic)
        FilterGet(parameters: Parameters())
        }
        }
        }
    }
    }
    
    var MinValue = Int()
    var MaxValue = Int()
    func SliderAction(minValue: Int, maxValue:Int) {
    MinValue = minValue
    MaxValue = maxValue
    FilterGet(parameters: Parameters())
    }

    var RateData = [Int]()
    func RateAction(_ Cell: FilterRateCell) {
    if let Index = TableView.indexPath(for: Cell) {
        
    if RateData.contains(Rate[Index.row]) {
    if let index = RateData.firstIndex(of: Rate[Index.row]) {
    RateData.remove(at: index)
    TableView.reloadRows(at: [Index], with: .automatic)
    FilterGet(parameters: Parameters())
    }
    }else{
    RateData.append(Rate[Index.row])
    TableView.reloadRows(at: [Index], with: .automatic)
    FilterGet(parameters: Parameters())
    }
    }
    }
    
    var ColorData = [String]()
    func ColorAction(_ indexPath: [IndexPath]) {
    if indexPath.count != 0 {
    ColorData.removeAll()
    indexPath.forEach { Index in
    if let Id = DataFilter?.Colors[Index.row].id {
    ColorData.append(Id)
    if ColorData.count == indexPath.count {
    FilterGet(parameters: Parameters())
    }
    }
    }
    }else{
    FilterGet(parameters: Parameters())
    }
    }
    
    var SizeData = [String]()
    func SizeAction(_ indexPath: [IndexPath]) {
    if indexPath.count != 0 {
    SizeData.removeAll()
    indexPath.forEach { Index in
    if let Id = DataFilter?.Sizes[Index.row].id {
    SizeData.append(Id)
    if SizeData.count == indexPath.count {
    FilterGet(parameters: Parameters())
    }
    }
    }
    }else{
    FilterGet(parameters: Parameters())
    }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .white
        
    let Label = UIButton()
    Label.tag = section
    Label.backgroundColor = .clear
    Label.contentHorizontalAlignment = "lang".localizable == "en" ? .left:.right
    Label.setTitle(HeaderFilter[section], for: .normal)
    Label.titleLabel?.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(16))
    Label.translatesAutoresizingMaskIntoConstraints = false
    Label.addTarget(self, action: #selector(ActionHeader(_:)), for: .touchUpInside)
    Label.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        
    let Button = UIButton()
    Button.tag = section
    Button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    Button.backgroundColor = .clear
    switch section {
    case 0:
    Button.isHidden = false
    Button.transform = CategoriesOpen == true ? .identity:CGAffineTransform(rotationAngle: "lang".localizable == "en" ? -.pi / 2:.pi / 2)
    case 1:
    Button.isHidden = false
    Button.transform = BrandOpen == true ? .identity:CGAffineTransform(rotationAngle: "lang".localizable == "en" ? -.pi / 2:.pi / 2)
    default:
    Button.isHidden = true
    }
    
    Button.setBackgroundImage(UIImage(named: "Path")?.withInset(UIEdgeInsets(top: 0.6, left: 0.6, bottom: 0.6, right: 0.6)), for: .normal)
    Button.addTarget(self, action: #selector(ActionHeader(_:)), for: .touchUpInside)
    Button.translatesAutoresizingMaskIntoConstraints = false
        
    view.addSubview(Label)
    Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(20)).isActive = true
    Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    Label.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlX(10)).isActive = true
    Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlWidth(-40)).isActive = true
        
    view.addSubview(Button)
    Button.topAnchor.constraint(equalTo: view.topAnchor, constant: ControlX(14)).isActive = true
    Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
    Button.widthAnchor.constraint(equalToConstant: ControlWidth(22)).isActive = true
    Button.heightAnchor.constraint(equalToConstant: ControlWidth(18)).isActive = true
    
    return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
        return DataFilter?.SubCategories.count == 0 ?  0 : ControlWidth(40)
        }else{
        return ControlWidth(40)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0,1:
    return ControlWidth(50)
    case 2:
    return ControlWidth(130)
    case 3:
    return ControlWidth(50)
    case 4,5:
    return ControlWidth(60)
    default:
    return 0
    }
    }
    
    var CategoriesOpen = true
    var BrandOpen = true
    @objc func ActionHeader(_ button:UIButton) {
    switch button.tag {
    case 0:
    CategoriesOpen = !CategoriesOpen
    TableView.reloadSections(IndexSet(integer: button.tag), with: .automatic)
    case 1:
    BrandOpen = !BrandOpen
    TableView.reloadSections(IndexSet(integer: button.tag), with: .automatic)
    default:
    break
    }
    }
    
    /// Set Up FooterView
    lazy var FooterView:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        return View
    }()
    
    lazy var ApplyFiltersButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitleColor(.black, for: .normal)
        Button.setTitle("Apply Filters".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionApplyFilters), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(16))
        return Button
    }()
    
    var Items : ItemCategories?
    @objc func ActionApplyFilters() {
    Items?.SetCategoryItems(Parameters: Parameters(), removeAll: true, ShowDots: true, CategoriesShow: true)
    self.navigationController?.popViewController(animated: true)
    }
    
    var DataFilter : Filter?
    func FilterGet(parameters:[String:Any]) {
//    guard let url = defaults.string(forKey: "API") else{return}
//    let token = defaults.string(forKey: "JWT") ?? ""
//
//    let api = "\(url + GetFilter)"
                    
    ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        

        
        let data = ["minPrice" : "1000","maxPrice" : "10000","itemCount" : "2",
                    "SubCategories" : [
                        ["id" : "","title" : "Mobile","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRER4neaeH4o-wfm2arUPXQjWIXpdnroYo9NrB4BJi1GmT91J30-GjXy6Cc-fti0MZuER8&usqp=CAU","hasSub" : true],
                        ["id" : "","title" : "Smart phones","icon" : "","image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeGLXbkfO1zOV8imzq-32xsou6hFx1sV2hNixyYLYqAQsh9tccdjvL-eBSGZ7jJyx5F3s&usqp=CAU","hasSub" : true]
                        
                        ]
                    ,"Brand" : [["id" : "","title" : "Nokia"],
                                ["id" : "","title" : "SAMSUNG"],
                                ["id" : "","title" : "OPPO"],
                                ["id" : "","title" : "Xiaomi"],
                                ["id" : "","title" : "realme"],
                                ["id" : "","title" : "IKU"],
                                ["id" : "","title" : "ipone"]]
                    
                    
                    ,"Color" : [["id" : "","title" : "","color" : "#17202A","isAvailable" : true],
                                 ["id" : "","title" : "","color" : "#C0392B","isAvailable" : false],
                                 ["id" : "","title" : "","color" : "#99A3A4","isAvailable" : false],
                                 ["id" : "","title" : "","color" : "#82E0AA","isAvailable" : false],
                                 ["id" : "","title" : "","color" : "#F7DC6F","isAvailable" : false]]
                    
                    ,"Size" : [["id" : "","title" : "256 G","isAvailable" : true],
                                ["id" : "","title" : "128 G","isAvailable" : false],
                                ["id" : "","title" : "64 G","isAvailable" : false],
                                ["id" : "","title" : "521 G","isAvailable" : false]]] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.DataFilter = Filter(dictionary: data)
            self.TableView.SetAnimations()
            self.ViewDots.endRefreshing(){}
            self.TableView.isHidden = false
            self.ViewNoData.isHidden = true
            self.SetApplyFiltersButton(Products: self.DataFilter?.itemCount ?? "")
        }

        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.TableView.isHidden = true
//    self.SetUpIsError(error,true) {self.FilterGet(parameters: parameters)}
//    }
    }
    
    
    func SetApplyFiltersButton(Products:String) {
    let attributedString = NSMutableAttributedString(string: "Apply Filters".localizable, attributes: [
    .font: UIFont(name: "Muli-SemiBold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    ])

    let Product = "lang".localizable == "en" ? Products:Products.NumAR()
    attributedString.append(NSAttributedString(string: " (\(Product) \("Products".localizable))", attributes: [
    .font: UIFont(name: "Muli", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
    .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    ]))
        
    ApplyFiltersButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func Parameters() -> [String:Any] {
    var categoryId = String()
    if let Categories = CategoriesSelect {
    categoryId = DataFilter?.SubCategories[Categories.row].id ?? ""
    }else {
    categoryId = CategoryId ?? GUID
    }
    
    let lang = "lang".localizable
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                  "platform": "I",
                                  "lang": lang,
                                  "deviceID": udid,
                                  "keyWord": "",
                                  "keyWordId": GUID,
                                  "categoryId": categoryId,
                                  "priceFrom": MinValue,
                                  "priceTo": MaxValue,
                                  "vendorId": 0,
                                  "colorId": ColorData,
                                  "rating": RateData,
                                  "sizeId": SizeData,
                                  "brandId": BrandsData]
        
    return parameters
    }
}


