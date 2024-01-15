//
//  Details.swift
//  Volt (iOS)
//
//  Created by Emojiios on 14/02/2022.
//

import UIKit
import AVKit
import SDWebImage
import AVFoundation

enum EnumDetails {
case Description
case Specifications
case Installments
case Reviews
}

// SetUp Collection
extension ProductDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout , BannerLayoutDelegate ,DetailsImageDelegate , MediaBrowserDelegate , ItemCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case ProductDetailsImage:
        return Details?.Images.count ?? 0 == 0 ? 1 : Details?.Images.count ?? 0
            
        case ProductDetailsColor:
        return Details?.Colors.count ?? 0
            
        case ProductDetailsSize:
        return Details?.Sizes.count ?? 0
            
        case CollectionSimilarProducts:
        return Details?.SimilarItems.count ?? 0
            
        default:
        return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case ProductDetailsImage:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsImageID, for: indexPath) as! DetailsImageCell
        cell.Delegate = self
            
        if Details?.Images.count != 0 {
        cell.playButton.isHidden = Details?.Images[indexPath.item].mediaType?.uppercased() == "V" ? false:true
        cell.Image.image = Details?.Images[indexPath.item].Image
        }else{
        cell.Image.image = UIImage(named: "Group 26056")
        }
            
        return cell
        case ProductDetailsColor:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorID, for: indexPath) as! DetailsColorCell
        let Details = Details?.Colors[indexPath.item]
        cell.backgroundColor = .white
        cell.ViewColor.backgroundColor = Details?.color?.hexStringToUIColor()
        cell.ImageSelect.layer.borderColor = Details?.color?.hexStringToUIColor().cgColor
        cell.ImageSelect.isHidden = ColorSelect == indexPath ? false : true
        return cell
            
        case ProductDetailsSize:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeID, for: indexPath) as! DetailsSizeCell
        let Details = "lang".localizable == "en" ? Details?.Sizes[indexPath.item].title ?? "" : Details?.Sizes[indexPath.item].title?.NumAR() ?? ""
        cell.SizeLabel.text = Details
        cell.layer.borderWidth = ControlWidth(2)
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.backgroundColor = SizeSelect == indexPath ?  #colorLiteral(red: 0.9606148601, green: 0.7349409461, blue: 0.1471969187, alpha: 1) : #colorLiteral(red: 0.9950696826, green: 0.9619323611, blue: 0.889089644, alpha: 1)
        cell.layer.borderColor = SizeSelect == indexPath ?  #colorLiteral(red: 0.8640989661, green: 0.3406433463, blue: 0.06052432954, alpha: 1) : #colorLiteral(red: 0.8797233903, green: 0.8797233903, blue: 0.8797233903, alpha: 1)
        return cell
            
        case CollectionSimilarProducts:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarProductsID, for: indexPath) as! ItemCell
        cell.backgroundColor = .white
            
        cell.Delegate = self
        if let Item = Details?.SimilarItems[indexPath.item] {
        cell.update(icon: Item.image, Rating: Item.rating, Details: Item.title, PriceAfter: Item.price, PriceBefore: Item.oldPrice, Favourite: Item.isFavourite , discount: Item.discount?.toInt())
        cell.PriceBeforeLabel.MutableStrikethrough(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), UIFont(name: "Muli", size: ControlWidth(13)) ?? UIFont.systemFont(ofSize: ControlWidth(13)))
        }
        return cell
        default:
        return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {

        case ProductDetailsColor:
        let Details = Details?.Colors[indexPath.item]
        if let isAvailable = Details?.isAvailable {
        cell.alpha = isAvailable ? 1:0.4
        cell.setNeedsDisplay()
        }
            
        case ProductDetailsSize:
        let Details = Details?.Sizes[indexPath.item]
        if let isAvailable = Details?.isAvailable {
        cell.alpha = isAvailable ? 1:0.4
        cell.setNeedsDisplay()
        }
        default:
        break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {

        case ProductDetailsColor:
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
            
        case ProductDetailsSize:
        let nw = Details?.Sizes[indexPath.row].title ?? ""
        let estimatedFrame = nw.textSizeWithFont(UIFont.systemFont(ofSize: ControlWidth(15)))
        return CGSize(width: estimatedFrame.width + ControlWidth(70), height: collectionView.frame.height)
          
        case CollectionSimilarProducts :
        return CGSize(width: collectionView.frame.width / 2.3, height: collectionView.frame.height)
        
        default:
        return .zero
        }
    }
    
    // Collection Image
    func collectionView(_ collectionView: UICollectionView, focusAt indexPath: IndexPath?) {
        self.pageControl.set(progress: Int(indexPath?.item ?? 0), animated: true)
    }

    
    func ActionImage(_ Cell: DetailsImageCell) {
    if Details?.Images.count != 0 {
    if let index = ProductDetailsImage.indexPath(for: Cell) {
    if Details?.Images[index.item].mediaType?.uppercased() == "V" {
    if let videoUrlString = Details?.Images[index.item].path , let url = NSURL(string: videoUrlString)  {
    player = AVPlayer(url: url as URL)
    let vc = AVPlayerViewController()
    vc.player = player
    vc.modalPresentationStyle = .fullScreen
    vc.modalTransitionStyle = .crossDissolve
    vc.view.contentMode = .scaleAspectFill
    present(vc, animated: true) {
    vc.player?.play()
    }
    }
    }else{
    DidSelect(index: index.item)
    }
    }
    }
    }
    
    @objc func DidSelect(index:Int) {
    let browser = MediaBrowser(delegate: self)
    browser.setCurrentIndex(at: index)
    browser.displayMediaNavigationArrows = true
    let nc = UINavigationController(rootViewController: browser)
    nc.modalPresentationStyle = .fullScreen
    nc.modalTransitionStyle = .coverVertical
    present(nc, animated: true)
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
    return Details?.Images.count ?? 0
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    var photo = Media()
    if Details?.Images[index].mediaType?.uppercased() == "V" {
    if let Url = URL(string: Details?.Images[index].path ?? "") {
    photo = Media(videoURL: Url, previewImageURL: Url , Image: Details?.Images[index].Image ?? UIImage())
    return photo
    }
    }else{
    photo = Media(image: Details?.Images[index].Image ?? UIImage() ,caption: "Product Pictures".localizable)
    return photo
    }
    return photo
    }
    
    func thumbnail(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
    var photo = Media()
    if Details?.Images[index].mediaType?.uppercased() == "V" {
    if let Url = URL(string: Details?.Images[index].path ?? "") {
    photo = Media(videoURL: Url, previewImageURL: Url, Image: Details?.Images[index].Image ?? UIImage())
    return photo
    }
    }else{
    photo = Media(image: Details?.Images[index].Image ?? UIImage() ,caption: "Product Pictures".localizable)
    return photo
    }
    return photo
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case ProductDetailsColor:
        SelectColor(indexPath)
        if let Cell = ProductDetailsColor.cellForItem(at: indexPath) {
        ColorSelect = indexPath
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = Cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = .identity
        }, completion: { _ in
        self.ProductDetailsColor.reloadData()
        })
        })
        }
            
        case ProductDetailsSize:
        SelectSize(indexPath)
        if let Cell = ProductDetailsSize.cellForItem(at: indexPath) {
        SizeSelect = indexPath
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = Cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = .identity
        }, completion: { _ in
        self.ProductDetailsSize.reloadData()
        })
        })
        }
            
        default:
        break
        }
    }
    
    
    func ActionBackground(_ Cell: ItemCell) {
    guard let index = CollectionSimilarProducts.indexPath(for: Cell) else { return }
    guard let Item = Details?.SimilarItems[index.item] else { return }
    guard let itemId = Item.itemId else { return }

    let ProductDetails = ProductDetailsVC()
    ProductDetails.GetProduct(ProductId: itemId)
    Present(ViewController: self, ToViewController: ProductDetails)
    }
        
    func ActionHeart(_ Cell: ItemCell) {
    if let index = CollectionSimilarProducts.indexPath(for: Cell) {
    if let Item = Details?.SimilarItems[index.item] {
    let UrlAddOrRemove = Item.isFavourite == false ? AddItemFavourite : RemoveItemFavourite
    guard let url = defaults.string(forKey: "API") else{return}
    let token = defaults.string(forKey: "JWT") ?? ""
        
    let api = "\(url + UrlAddOrRemove)"

    guard let uid = getUserObject().Uid else{return}
    guard let ItemId = Item.itemId else{return}
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
                    
    let parameters:[String : Any] = ["AppId": "bee4a01a-7260-4e33-a315-fe623f223846",
                                    "Platform": "I",
                                    "uid": uid,
                                    "deviceID": udid,
                                    "itemId": ItemId]
                       
    Cell.heart.isUserInteractionEnabled = false
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    Item.isFavourite = !(Item.isFavourite ?? false)
    self.CollectionSimilarProducts.reloadItems(at: [index])
    Cell.heart.isUserInteractionEnabled = true
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    Cell.heart.isUserInteractionEnabled = true
    if error != "" {ShowMessageAlert("warning","Error".localizable, error, true){}}
    }
    }
    }
    }
    
    func GoToLogIn() {
    Present(ViewController: self, ToViewController: SignInController())
    }
    
}


// SetUp Table
extension ProductDetailsVC : UITableViewDelegate ,UITableViewDataSource, TapMenuDelegate , ReviewsViewAllDelegate {
            
    func numberOfSections(in tableView: UITableView) -> Int {
    if tableView == self.tableView {
    return 2
    }else{
    return 1
    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == self.tableView {
    if section == 0 {
    return 1
    }else{
    switch Enum {
    case .Description:
    return Details?.Description.count ?? 0
    case .Specifications:
    return Details?.Specifications.count ?? 0 > 0 ?  Details?.Specifications.count ?? 0 + 1 : 0
    case .Installments:
    return DataInstallments.count + 1
    case .Reviews:
    let ReviewsCount = (Details?.Reviews.count ?? 0) <= 2 ? (Details?.Reviews.count ?? 0) : 2
    let ViewAllReviewsCount = ReviewsCount != 0 ? 1 : 0
    self.RatingCount = ButtonRatingTitle.count + ReviewsCount + ViewAllReviewsCount + 1
    return self.RatingCount
    }
    }
    }else{
    return listTitle.count
    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == self.tableView {
    switch indexPath.section {
    case 0:
    let cell = tableView.dequeueReusableCell(withIdentifier: TapId, for: indexPath) as! TapMenuCell
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    cell.Delegate = self
    return cell
            
    case 1:
//  Set up Cell Details
        
    switch Enum {
    case .Description:
            
    let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionId, for: indexPath) as! DescriptionCell
    cell.selectionStyle = .none
    if let DataDetails = Details?.Description {
    cell.TitleLabel.text = DataDetails[indexPath.row].title
    cell.Details.text = DataDetails[indexPath.row].details?.htmlToString ?? ""
    cell.Image.sd_setImage(with: URL(string: DataDetails[indexPath.row].path ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    };return cell
            
    case .Specifications:
    let cell = tableView.dequeueReusableCell(withIdentifier: SpecificationsId, for: indexPath) as! SpecificationsCell
    if let DataDetails = Details?.Specifications {
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    cell.IsFristRow(IsFrist: indexPath.row == 0 ? true : false, indexPath: indexPath, DataDetails: DataDetails)
    };return cell
            
    case .Installments:
    let cell = tableView.dequeueReusableCell(withIdentifier: InstallmentsId, for: indexPath) as! InstallmentsCell
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    cell.IsFristRow(IsFrist: indexPath.row == 0 ? true : false, indexPath: indexPath, DataDetails: DataInstallments)
    return cell
            
    case .Reviews:
    if indexPath.row == 0 {
    let cell = tableView.dequeueReusableCell(withIdentifier: OverallRatingId, for: indexPath) as! OverallRating
    if let DataDetails = Details {
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    cell.Rate = DataDetails.Rate
    cell.SetViewRating()
    };return cell
            
    }else if indexPath.row <= 5 {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsRatingId, for: indexPath) as! ReviewsRatingCell
    if let DataDetails = Details {
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    cell.SetDataIndex(indexPath: indexPath, ButtonRatingTitle: ButtonRatingTitle, DataDetails:DataDetails)
    };return cell
    }else{
        
    if RatingCount > 5 && RatingCount < 8 {
    if indexPath.row == 7 {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsViewAllId, for: indexPath) as!  ReviewsViewAll
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    cell.Delegate = self
    return cell
    }else{
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsCommentId, for: indexPath) as! ReviewsCommentCell
    if let DataDetails = Details {
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    cell.LabelName.text = DataDetails.Reviews.first?.userName
    cell.ViewRating.rating = DataDetails.Reviews.first?.rat?.toDouble() ?? 1
    cell.Comment.text = DataDetails.Reviews.first?.Review
    cell.LabelDate.text = DataDetails.Reviews.first?.date?.Formatter().Formatter("d MMM, yyyy")
    };return cell
    }
    }else if RatingCount > 7 {
    if indexPath.row == 8 {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsViewAllId, for: indexPath) as!  ReviewsViewAll
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    cell.Delegate = self
    return cell
    }else{
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsCommentId, for: indexPath) as! ReviewsCommentCell
    if let DataDetails = Details {
    cell.selectionStyle = .none
    cell.backgroundColor = .white
    if indexPath.row == 6 {
    cell.LabelName.text = DataDetails.Reviews.first?.userName
    cell.ViewRating.rating = DataDetails.Reviews.first?.rat?.toDouble() ?? 1
    cell.Comment.text = DataDetails.Reviews.first?.Review
    cell.LabelDate.text = DataDetails.Reviews.first?.date?.Formatter().Formatter("d MMM, yyyy")
    }else{
    cell.LabelName.text = DataDetails.Reviews.last?.userName
    cell.ViewRating.rating = DataDetails.Reviews.last?.rat?.toDouble() ?? 1
    cell.Comment.text = DataDetails.Reviews.last?.Review
    cell.LabelDate.text = DataDetails.Reviews.last?.date?.Formatter().Formatter("d MMM, yyyy")
    }
        
    };return cell
    }
    }else{
    return UITableViewCell()
    }
        
    }
    }
        
    default:
    return UITableViewCell()
    }
    }else{
    let cell = tableView.dequeueReusableCell(withIdentifier: listId, for: indexPath)
    cell.backgroundColor = .white
    cell.selectionStyle = .none
    cell.textLabel?.textColor = .black
    cell.textLabel?.text = listTitle[indexPath.row]
    cell.imageView?.image = listImage[indexPath.row]
    cell.textLabel?.font = UIFont(name: "Muli" ,size: ControlWidth(14))
    return cell
    }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if tableView == self.tableView {
    switch indexPath.section {
    case 0:
    return ControlWidth(60)
        
    case 1:
    return UITableView.automaticDimension
        
    default:
    return 0
    }
    }else{
    return UITableView.automaticDimension
    }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if tableView == self.tableView {
    return ViewScroll.contentSize.height
    }else{
    return 0
    }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if tableView == self.tableView {
    return ControlWidth(320)
    }else{
    return 0
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func ActionViewAll() {
    if let DataDetails = Details {
    let ItemReviews = ItemReviewsVC()
    ItemReviews.itemId = DataDetails.itemId
    Present(ViewController: self, ToViewController: ItemReviews)
    }
    }
    
    func TapMenuSelected(SegmentIndex:Int) {
    switch SegmentIndex {
    case 0 :
    self.Enum = .Description
    case 1:
    self.Enum = .Specifications
    case 2:
    self.Enum = .Installments
    case 3:
    self.Enum = .Reviews
    default:
    break
    }
    self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
    }
    

}



