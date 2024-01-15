//
//  CategoriesHomeCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 06/03/2022.
//

import UIKit
import SDWebImage

class CategoriesHomeCell: UICollectionViewCell {
    
    var Home:HomeVC?
    var Categories = [CategoriesSub]() {
        didSet {
            CollectionCategories.reloadData()
        }
    }
    
    lazy var StackCategories : UIStackView = {
    let Stack = UIStackView(arrangedSubviews: [LabelCategories,CollectionCategories])
    Stack.axis = .vertical
    Stack.spacing = ControlWidth(10)
    Stack.distribution = .fillEqually
    Stack.alignment = .fill
    Stack.backgroundColor = .clear
    Stack.translatesAutoresizingMaskIntoConstraints = false
    return Stack
    }()
    
    lazy var LabelCategories : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(18))
        Label.backgroundColor = .clear
        return Label
    }()

    var CategoriesID = "Categories"
    lazy var CollectionCategories: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(CellCategories.self, forCellWithReuseIdentifier: CategoriesID)
        return vc
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(StackCategories)
        StackCategories.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(5)).isActive = true
        StackCategories.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-10)).isActive = true
        StackCategories.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(10)).isActive = true
        StackCategories.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-10)).isActive = true
        
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CategoriesHomeCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesID, for: indexPath) as! CellCategories
        cell.clipsToBounds = true
        cell.layer.borderColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        cell.backgroundColor = .white
        cell.layer.borderWidth = ControlWidth(1)
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.Label.text = Categories[indexPath.item].title
        cell.Image.sd_setImage(with: URL(string: Categories[indexPath.item].icon ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let CategoryId = Categories[indexPath.item].id {
    if let home = Home {
    let categories = ItemCategories()
    categories.CategoryId = CategoryId
    categories.SetCategoryItems(removeAll: true)
    categories.SetUpDismiss(text: Categories[indexPath.item].title ?? "Categories")
    Present(ViewController: home, ToViewController: categories)
    }
    }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    cell.alpha = 0
    UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
    cell.alpha = 1
    }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let nw = Categories[indexPath.row].title ?? ""
    let estimatedFrame = nw.textSizeWithFont(UIFont.systemFont(ofSize: ControlWidth(16)))
    return CGSize(width: estimatedFrame.width + ControlWidth(75), height: collectionView.frame.height)
    }
}

