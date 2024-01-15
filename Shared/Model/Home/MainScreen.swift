//
//  MainScreen.swift
//  Volt (iOS)
//
//  Created by Emojiios on 03/03/2022.
//

import Foundation

class MainScreen {
      
    var componentName : String?
    
    var title : String?
    
    var Slider = [MainSlider]()
    
    var Categories = [CategoriesSub]()
    
    var Offers = [MainOffers]()
    
    var items = [CategoryItems]()

    init(dictionary:[String:Any]) {
    componentName = dictionary["componentName"] as? String
    title = dictionary["title"] as? String
        
        
    for item in dictionary["Slider"] as? [[String:Any]] ?? [[String:Any]()] {
    Slider.append(MainSlider(dictionary: item))
    }

    for item in dictionary["PopularCategories"] as? [[String:Any]] ?? [[String:Any]()] {
    Categories.append(CategoriesSub(dictionary: item))
    }

    for item in dictionary["Offers"] as? [[String:Any]] ?? [[String:Any]()] {
    Offers.append(MainOffers(dictionary: item))
    }

    for item in dictionary["items"] as? [[String:Any]] ?? [[String:Any]()] {
    items.append(CategoryItems(dictionary: item))
    }
    }
    
}


class MainSlider {
    
    var Id : Int?
    var image : String?
    var mediaType : String?
    var type : Int?
    var url : String?
    var itemId : String?
    var CategoryID : String?
    
    init(dictionary:[String:Any]) {
        Id = dictionary["Id"] as? Int
        image = dictionary["image"] as? String
        mediaType = dictionary["mediaType"] as? String
        type = dictionary["type"] as? Int
        url = dictionary["url"] as? String
        itemId = dictionary["itemId"] as? String
        CategoryID = dictionary["CategoryID"] as? String
    }
}

class MainOffers {
    
    var type : String?
    var OfferType = [MainOfferType]()
     
    init(dictionary:[String:Any]) {
    type = dictionary["type"] as? String
        
    for item in dictionary["offer"] as? [[String:Any]] ?? [[String:Any]()] {
    OfferType.append(MainOfferType(dictionary: item))
    }
    }
    
}

class MainOfferType {
    var id : String?
    var title : String?
    var image : String?
    var type : String?
    var itemId : String?
    var categoryId : String?
    var url : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        title = dictionary["title"] as? String
        image = dictionary["image"] as? String
        type = dictionary["type"] as? String
        itemId = dictionary["itemId"] as? String
        categoryId = dictionary["categoryId"] as? String
        url = dictionary["url"] as? String
    }
}
