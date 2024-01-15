//
//  FilterSizeCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 24/03/2022.
//

import UIKit

protocol FilterSizeCellDelegate {
    func SizeAction(_ indexPath:[IndexPath])
}

class FilterSizeCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {

    var SizeID = "Size"
    var Sizes = [ItemSizes]()
    var SizeSelect = [IndexPath]()
    var Delegate : FilterSizeCellDelegate?
    lazy var CollectionSize: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlWidth(10)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = UIColor.clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(DetailsSizeCell.self, forCellWithReuseIdentifier: SizeID)
        return vc
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return Sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeID, for: indexPath) as! DetailsSizeCell
    cell.SizeLabel.text = "lang".localizable == "en" ? Sizes[indexPath.item].title ?? "" : Sizes[indexPath.item].title?.NumAR() ?? ""
    cell.layer.borderWidth = ControlWidth(2)
    cell.layer.cornerRadius = cell.frame.height / 2
    cell.backgroundColor = SizeSelect.contains(where: {$0.item == indexPath.item}) ?  #colorLiteral(red: 0.9606148601, green: 0.7349409461, blue: 0.1471969187, alpha: 1) : #colorLiteral(red: 0.9950696826, green: 0.9619323611, blue: 0.889089644, alpha: 1)
    cell.layer.borderColor = SizeSelect.contains(where: {$0.item == indexPath.item}) ?  #colorLiteral(red: 0.8640989661, green: 0.3406433463, blue: 0.06052432954, alpha: 1) : #colorLiteral(red: 0.8797233903, green: 0.8797233903, blue: 0.8797233903, alpha: 1)
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nw = Sizes[indexPath.row].title ?? ""
        let estimatedFrame = nw.textSizeWithFont(UIFont.systemFont(ofSize: ControlWidth(16)))
        return CGSize(width: estimatedFrame.width + ControlWidth(70), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let Cell = CollectionSize.cellForItem(at: indexPath) {
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = Cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
        Cell.transform = .identity
        }, completion: { _ in
        self.CollectionSize.reloadData()
        })
        })
        }

        if self.SizeSelect.contains(indexPath) {
        if let index = self.SizeSelect.firstIndex(of: indexPath) {
        SizeSelect.remove(at: index)
        Delegate?.SizeAction(SizeSelect)
        CollectionSize.reloadItems(at: [indexPath])
        }
        }else{
        SizeSelect.append(indexPath)
        Delegate?.SizeAction(SizeSelect)
        CollectionSize.reloadItems(at: [indexPath])
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(CollectionSize)
        CollectionSize.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        CollectionSize.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        CollectionSize.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        CollectionSize.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
        contentView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
