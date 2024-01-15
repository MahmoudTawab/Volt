//
//  TapMenuCell.swift
//  Volt (iOS)
//
//  Created by Emojiios on 01/08/2022.
//

import UIKit

protocol TapMenuDelegate {
    func TapMenuSelected(SegmentIndex:Int)
}

class TapMenuCell: UITableViewCell {
    
    var Delegate:TapMenuDelegate?
    let largerRedTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Muli", size: ControlWidth(15.5)),
                                   NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
    let largerRedTextHighlightAttributes = [NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: ControlWidth(14.5)),
                                            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
    let largerRedTextSelectAttributes = [NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: ControlWidth(14.5)),
                                         NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
    
    
    
    lazy var MenuTapCollection : ScrollableSegmentedControl = {
        let View = ScrollableSegmentedControl()
        View.tintColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
        View.segmentStyle = .textOnly
        View.underlineHeight = ControlWidth(2)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.insertSegment(withTitle: "Description".localizable, image: nil, at: 0)
        View.insertSegment(withTitle: "Specifications".localizable, image: nil, at: 1)
        View.insertSegment(withTitle: "Installments".localizable, image: nil, at: 2)
        View.insertSegment(withTitle: "Reviews".localizable, image: nil, at: 3)
        View.setTitleTextAttributes(largerRedTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        View.setTitleTextAttributes(largerRedTextHighlightAttributes as [NSAttributedString.Key : Any], for: .highlighted)
        View.setTitleTextAttributes(largerRedTextSelectAttributes as [NSAttributedString.Key : Any], for: .selected)
        View.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        return View
    }()
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        Delegate?.TapMenuSelected(SegmentIndex: sender.selectedSegmentIndex)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isHidden = true
                
        addSubview(MenuTapCollection)
        MenuTapCollection.fixedSegmentWidth = true
        MenuTapCollection.selectedSegmentIndex = 0
        MenuTapCollection.underlineSelected = true
        MenuTapCollection.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        MenuTapCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-10)).isActive = true
        MenuTapCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        MenuTapCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
