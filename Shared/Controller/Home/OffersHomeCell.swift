//
//  OffersHomeCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 06/03/2022.
//

import UIKit
import SDWebImage

class OffersHomeCell: UICollectionViewCell {

    var Home:HomeVC?
    var Offers = [MainOffers]() {
        didSet {
            CollectionOffers.reloadData()
        }
    }
    
    var OffersID = "Offers"
   lazy var CollectionOffers: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
       vc.backgroundColor = .white
       vc.dataSource = self
       vc.delegate = self
       vc.isScrollEnabled = false
       vc.showsHorizontalScrollIndicator = false
       vc.translatesAutoresizingMaskIntoConstraints = false
       vc.register(CollectionOffersCell.self, forCellWithReuseIdentifier: OffersID)
       return vc
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(CollectionOffers)
        CollectionOffers.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(5)).isActive = true
        CollectionOffers.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-5)).isActive = true
        CollectionOffers.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
        CollectionOffers.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
        
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension OffersHomeCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Offers[section].OfferType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersID, for: indexPath) as! CollectionOffersCell
                
    let OffersSection = Offers[indexPath.section]
    if let Image = OffersSection.OfferType[indexPath.item].image {
    cell.Image.sd_setImage(with: URL(string: Image), placeholderImage: UIImage(named: "Group 26056"))
    }
                
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Offers[indexPath.section].type == "Single" ?
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2):
        CGSize(width: collectionView.frame.width  / 2.06, height: collectionView.frame.height  / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        } else {
            return UIEdgeInsets(top: 10.0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let OffersSection = Offers[indexPath.section].OfferType[indexPath.item]
            if OffersSection.itemId != "" {
            if let itemId = OffersSection.itemId {
            if let home = Home {
            let ProductDetails = ProductDetailsVC()
            ProductDetails.GetProduct(ProductId: itemId)
            Present(ViewController: home, ToViewController: ProductDetails)
            }
            }
            }
        
            if OffersSection.categoryId != "" {
            if let CategoryId = OffersSection.categoryId {
            if let home = Home {
            let Categories = ItemCategories()
            Categories.CategoryId = CategoryId
            Categories.SetCategoryItems(removeAll: true)
            Categories.SetUpDismiss(text: "Offers")
            Present(ViewController: home, ToViewController: Categories)
            }
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
