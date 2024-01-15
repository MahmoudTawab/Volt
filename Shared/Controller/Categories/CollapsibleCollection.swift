//
//  CollapsibleCollection.swift
//  CollapsibleCollection
//
//  Created by Yong Su on 7/20/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit

//
// MARK: - CollapsibleCollectionDelegate
//
@objc public protocol CollapsibleCollectionSectionDelegate {
    @objc optional func shouldCollapseByDefault(_ collectionView: UICollectionView) -> Bool
    @objc optional func shouldCollapseOthers(_ collectionView: UICollectionView) -> Bool
}

//
// MARK: - View Controller
//
class CollapsibleCollection: ViewController {
             
    var delegate: CollapsibleCollectionSectionDelegate?
    
    let CellCategories = "Categories"
    let CellCompare = "Compare"
    var CollectionCollapsible: CollectionAnimations!
    fileprivate var _sectionsState = [Int : Bool]()
    
    public func isSectionCollapsed(_ section: Int) -> Bool {
        if _sectionsState.index(forKey: section) == nil {
            _sectionsState[section] = delegate?.shouldCollapseByDefault?(CollectionCollapsible) ?? false
        }
        return _sectionsState[section]!
    }
    
    func getSectionsNeedReload(_ section: Int) -> [Int] {
        var sectionsNeedReload = [section]
        
        // Toggle collapse
        let isCollapsed = !isSectionCollapsed(section)
        
        // Update the sections state
        _sectionsState[section] = isCollapsed
        
        let shouldCollapseOthers = delegate?.shouldCollapseOthers?(CollectionCollapsible) ?? false
        
        if !isCollapsed && shouldCollapseOthers {
            // Find out which sections need to be collapsed
            let filteredSections = _sectionsState.filter { !$0.value && $0.key != section }
            let sectionsNeedCollapse = filteredSections.map { $0.key }
            
            // Mark those sections as collapsed in the state
            for item in sectionsNeedCollapse { _sectionsState[item] = true }
            
            // Update the sections that need to be redrawn
            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }
        
        return sectionsNeedReload
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        // Create the CollectionView
        CollectionCollapsible = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        CollectionCollapsible.backgroundColor = .clear
        CollectionCollapsible.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        CollectionCollapsible.register(CategoriesCell.self, forCellWithReuseIdentifier: CellCategories)
        CollectionCollapsible.register(CompareCollectionCell.self, forCellWithReuseIdentifier: CellCompare)
        CollectionCollapsible.register(CategoriesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ViewHeader")
    }
        
}


extension UICollectionView {
  var totalItems: Int {
    (0..<numberOfSections).reduce(0) { res, cur in
      res + numberOfItems(inSection: cur)
    }
  }
}
