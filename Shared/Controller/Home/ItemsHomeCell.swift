//
//  ItemsHomeCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 06/03/2022.
//

import UIKit

class ItemsHomeCell: UICollectionViewCell {

    var Home:HomeVC?
    var Items = [CategoryItems]() {
        didSet {
            CollectionItems.reloadData()
        }
    }
    
    lazy var StackItems : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LabelItems,CollectionItems])
    Stack.axis = .vertical
    Stack.spacing = ControlWidth(10)
    Stack.distribution = .fillProportionally
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    lazy var LabelItems : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()
    
    var ItemID = "Item"
    lazy var CollectionItems: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = ControlWidth(1)
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        vc.dataSource = self
        vc.delegate = self
        vc.register(ItemCell.self, forCellWithReuseIdentifier: ItemID)
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(240)).isActive = true
        return vc
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(StackItems)
        StackItems.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(5)).isActive = true
        StackItems.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-5)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
        
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemsHomeCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,ItemCellDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemID, for: indexPath) as! ItemCell
        let Item = Items[indexPath.item]
        cell.backgroundColor = .white
        cell.Delegate = self

        cell.update(icon: Item.image, Rating: Item.rating, Details: Item.title, PriceAfter: Item.price, PriceBefore: Item.oldPrice, Favourite: Item.isFavourite, discount: Item.discount?.toInt())
        cell.PriceBeforeLabel.MutableStrikethrough(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)))
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.3, height: collectionView.frame.height)
    }
    

    func ActionHeart(_ Cell: ItemCell) {
    if let index = CollectionItems.indexPath(for: Cell) {
    let UrlAddOrRemove = Items[index.item].isFavourite == false ? AddItemFavourite : RemoveItemFavourite
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
    let api = "\(url + UrlAddOrRemove)"

    guard let uid = getUserObject().Uid else{return}
    guard let ItemId = Items[index.item].itemId else{return}
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
                
    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "itemId": ItemId]
        
    Cell.heart.isUserInteractionEnabled = false
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.Items[index.item].isFavourite = !(self.Items[index.item].isFavourite ?? false)
    self.CollectionItems.reloadItems(at: [index])
    Cell.heart.isUserInteractionEnabled = true
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    Cell.heart.isUserInteractionEnabled = true
    if error != "" {ShowMessageAlert("warning","Error".localizable, error, true){}}
    }
    }
    }
    
    func GoToLogIn() {
    guard let Product = Home else { return }
    Present(ViewController: Product, ToViewController: SignInController())
    }
    
    func ActionBackground(_ Cell: ItemCell) {
    guard let index = CollectionItems.indexPath(for: Cell) else { return }
    guard let itemId = Items[index.item].itemId else { return }
    guard let Product = Home else { return }

    let ProductDetails = ProductDetailsVC()
    ProductDetails.GetProduct(ProductId: itemId)
    Present(ViewController: Product, ToViewController: ProductDetails)
    }

}
