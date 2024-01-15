//
//  FilterColorCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 24/03/2022.
//

import UIKit

protocol FilterColorCellDelegate {
    func ColorAction(_ indexPath:[IndexPath])
}

class FilterColorCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {

    var ColorID = "Color"
    var Colors = [ItemColors]()
    var ColorSelect = [IndexPath]()
    var Delegate : FilterColorCellDelegate?
    lazy var CollectionColor: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = UIColor.clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(DetailsColorCell.self, forCellWithReuseIdentifier: ColorID)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return Colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorID, for: indexPath) as! DetailsColorCell
    cell.backgroundColor = .white
    cell.ViewColor.backgroundColor = Colors[indexPath.item].color?.hexStringToUIColor()
    cell.ImageSelect.layer.borderColor = Colors[indexPath.item].color?.hexStringToUIColor().cgColor
    cell.ImageSelect.isHidden = ColorSelect.contains(where: {$0.item == indexPath.item}) ? false : true
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let Cell = CollectionColor.cellForItem(at: indexPath) {
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = Cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = .identity
        }, completion: { _ in
        self.CollectionColor.reloadData()
        })
        })
        }

        if self.ColorSelect.contains(indexPath) {
        if let index = self.ColorSelect.firstIndex(of: indexPath) {
        ColorSelect.remove(at: index)
        Delegate?.ColorAction(ColorSelect)
        CollectionColor.reloadItems(at: [indexPath])
        }
        }else{
        ColorSelect.append(indexPath)
        Delegate?.ColorAction(ColorSelect)
        CollectionColor.reloadItems(at: [indexPath])
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(CollectionColor)
        CollectionColor.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        CollectionColor.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        CollectionColor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-25)).isActive = true
        CollectionColor.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
