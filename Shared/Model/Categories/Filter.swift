//
//  Filter.swift
//  Volt (iOS)
//
//  Created by Emojiios on 23/03/2022.
//

import Foundation

class Filter {
    
    var minPrice : String?
    var maxPrice : String?
    var itemCount : String?
    var SubCategories = [CategoriesSub]()
    var Brand = [Itembrands]()
    var Colors = [ItemColors]()
    var Sizes = [ItemSizes]()

    init(dictionary:[String:Any]) {
    minPrice = dictionary["minPrice"] as? String
    maxPrice = dictionary["maxPrice"] as? String
    itemCount = dictionary["itemCount"] as? String
        
    for item in dictionary["SubCategories"] as? [[String:Any]] ?? [[String:Any]()] {
    SubCategories.append(CategoriesSub(dictionary: item))
    }

    for item in dictionary["Brand"] as? [[String:Any]] ?? [[String:Any]()] {
    Brand.append(Itembrands(dictionary: item))
    }
        
    for item in dictionary["Color"] as? [[String:Any]] ?? [[String:Any]()] {
    Colors.append(ItemColors(dictionary: item))
    }
        
    for item in dictionary["Size"] as? [[String:Any]] ?? [[String:Any]()] {
    Sizes.append(ItemSizes(dictionary: item))
    }

    }
}

