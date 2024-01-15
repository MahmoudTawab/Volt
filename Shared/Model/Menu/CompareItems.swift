//
//  CompareItems.swift
//  Volt (iOS)
//
//  Created by Emojiios on 13/03/2022.
//

import Foundation

class CompareItems {
    
    var firstItemId : String?
    var firstItemTitle : String?
    var firstItemImage : String?
    var secondItemId : String?
    var secondItemTitle : String?
    var secondItemImage : String?
    var Categories = [ComparisonCategories]()
    
    init(dictionary:[String:Any]) {
    firstItemId = dictionary["firstItemId"] as? String
    firstItemTitle = dictionary["firstItemTitle"] as? String
    firstItemImage = dictionary["firstItemImage"] as? String
    secondItemId = dictionary["secondItemId"] as? String
    secondItemTitle = dictionary["secondItemTitle"] as? String
    secondItemImage = dictionary["secondItemImage"] as? String
        
    for item in dictionary["ComparisonCategories"] as? [[String:Any]] ?? [[String:Any]()] {
    Categories.append(ComparisonCategories(dictionary: item))
    }
    }
}

class ComparisonCategories {
    
    var title : String?
    var Fields = [ComparisonFields]()
    
    init(dictionary:[String:Any]) {
    title = dictionary["title"] as? String
        
    for item in dictionary["ComparisonFields"] as? [[String:Any]] ?? [[String:Any]()] {
    Fields.append(ComparisonFields(dictionary: item))
    }
    }
}

class ComparisonFields {
    
    var title : String?
    var firstItemValue : String?
    var secondItemValue : String?
    var isRating : Bool?
    var isDifferent : Bool?
    
    init(dictionary:[String:Any]) {
    
    title = dictionary["title"] as? String
        
    firstItemValue = dictionary["firstItemValue"] as? String
    
    secondItemValue = dictionary["secondItemValue"] as? String

    isRating = dictionary["isRating"] as? Bool
    isDifferent = dictionary["isDifferent"] as? Bool
    }
}
