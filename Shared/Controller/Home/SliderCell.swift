//
//  SliderCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 06/03/2022.
//

import UIKit
import SDWebImage

class SliderCell: UICollectionViewCell {

    var Home:HomeVC?
    var Slider = [MainSlider]() {
        didSet {
            Advertisements.reloadData()
            pageControl.reloadInputViews()
        }
    }
    
    
    var AdvertisementsID = "Advertisements"
    lazy var Advertisements: UICollectionView = {
        let vc = UICollectionView(frame: .zero, collectionViewLayout: MMBannerLayout())
        vc.backgroundColor = UIColor.clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(CellAdvertisements.self, forCellWithReuseIdentifier: AdvertisementsID)
        return vc
    }()
    
    lazy var pageControl : WOPageControl = {
        let pc = WOPageControl(frame: CGRect(x: 0, y:0, width: 100, height: 10))
        pc.cornerRadius = ControlWidth(3);
        pc.dotHeight = ControlWidth(6);
        pc.otherDotWidth = ControlWidth(6);
        pc.dotSpace = ControlWidth(10);
        pc.currentDotWidth = ControlWidth(30);
        pc.otherDotColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        pc.currentDotColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        (self.Advertisements.collectionViewLayout as? MMBannerLayout)?.autoPlayStatus = .play(duration: 4.0)
        
        addSubview(Advertisements)
        Advertisements.topAnchor.constraint(equalTo: self.topAnchor ,constant: ControlX(10)).isActive = true
        Advertisements.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
        Advertisements.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
        Advertisements.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlX(-30)).isActive = true
        
        addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: Advertisements.bottomAnchor ,constant: ControlX(5)).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlX(-5)).isActive = true
       
        contentView.isHidden = true
        
        BannerLayoutPlay()
        NotificationCenter.default.addObserver(self, selector: #selector(BannerLayoutPlay), name: HomeVC.SlidePlay , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BannerLayoutStop), name: HomeVC.SlideStop , object: nil)
    }
    
    
    @objc func BannerLayoutPlay() {
    if let layout = Advertisements.collectionViewLayout as? MMBannerLayout {
    layout.autoPlayStatus = .play(duration: 4.0)
    }
    }
    
    @objc func BannerLayoutStop() {
    if let layout = Advertisements.collectionViewLayout as? MMBannerLayout {
    layout.autoPlayStatus = .none
    }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SliderCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,BannerLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Slider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementsID, for: indexPath) as! CellAdvertisements
        if let img = Slider[indexPath.item].image {
        cell.Image.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "Group 26056"))
        }

        cell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.shadowOffset = CGSize(width: 4, height: 8)
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowRadius = 5.0
        cell.layer.masksToBounds = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    if Slider[indexPath.item].itemId != "" {
    if let itemId = Slider[indexPath.item].itemId {
    if let home = Home {
    let ProductDetails = ProductDetailsVC()
    ProductDetails.GetProduct(ProductId: itemId)
    Present(ViewController: home, ToViewController: ProductDetails)
    }
    }
    }
       
    if Slider[indexPath.item].CategoryID != "" {
    if let CategoryId = Slider[indexPath.item].CategoryID {
    if let home = Home {
    let Categories = ItemCategories()
    Categories.CategoryId = CategoryId
    Categories.SetCategoryItems(removeAll: true)
    Categories.SetUpDismiss(text: "Categories")
    Present(ViewController: home, ToViewController: Categories)
    }
    }
    }
        
    if Slider[indexPath.item].url != "" {
    if let url = Slider[indexPath.item].url {
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
    
    func collectionView(_ collectionView: UICollectionView, focusAt indexPath: IndexPath?) {
        if collectionView == Advertisements {
        pageControl.currentPage = indexPath?.item ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .zero
    }
    
}
