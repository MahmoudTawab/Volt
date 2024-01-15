//
//  CategoriesCell.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 09/08/2021.
//

import UIKit
import SDWebImage

protocol CategoriesCellDelegate {
    func ActionViewAll(_ Cell: CategoriesCell)
    func ActionCollection(_ Cell: CategoriesCell ,_ IndexSelect:IndexPath)
}

class CategoriesCell: UICollectionViewCell , UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

    var Delegate : CategoriesCellDelegate?
    var CategoriesData : Categories? {
        didSet {
        CollectionCell.reloadData()
        }
    }
    
    var CategoriesID = "Categories"
    lazy var CollectionCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(CategoriesCollectionCell.self, forCellWithReuseIdentifier: CategoriesID)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoriesData?.SubCategories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesID, for: indexPath) as! CategoriesCollectionCell
        cell.backgroundColor = .white
        cell.Label.text = CategoriesData?.SubCategories[indexPath.row].title ?? ""
        cell.ImageView.sd_setImage(with: URL(string: CategoriesData?.SubCategories[indexPath.item].image ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    Delegate?.ActionCollection(self, indexPath)
    }

    lazy var ViewAllButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.backgroundColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("View All".localizable, for: .normal)
        Button.setTitleColor(.black, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionViewAll), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Muli-SemiBold", size: ControlWidth(15))
        return Button
    }()
    
    @objc func ActionViewAll() {
    Delegate?.ActionViewAll(self)
    }
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ViewLine)
        ViewLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ViewLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ViewLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ViewLine.heightAnchor.constraint(equalToConstant: ControlWidth(0.8)).isActive = true

        addSubview(CollectionCell)
        CollectionCell.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        CollectionCell.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        CollectionCell.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        CollectionCell.heightAnchor.constraint(equalTo: self.heightAnchor , constant: ControlX(-80)).isActive = true
        
        addSubview(ViewAllButton)
        ViewAllButton.widthAnchor.constraint(equalToConstant: ControlWidth(160)).isActive = true
        ViewAllButton.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        ViewAllButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ViewAllButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-20)).isActive = true
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CategoriesCollectionCell: UICollectionViewCell {
    
    lazy var ImageView : UIImageView = {
        let Image = UIImageView()
        Image.clipsToBounds = true
        Image.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()

    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Muli-Bold" ,size: ControlWidth(13))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(ImageView)
        ImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-50)).isActive = true
        
        addSubview(Label)
        Label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        Label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        Label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        Label.topAnchor.constraint(equalTo: ImageView.bottomAnchor ,constant: ControlY(10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
