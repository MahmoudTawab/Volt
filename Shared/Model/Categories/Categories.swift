//
//  Categories.swift
//  Volt (iOS)
//
//  Created by Emojiios on 06/03/2022.
//

import Foundation
import AVKit
import SDWebImage
import AVFoundation

class Categories {
    
    var id : String?
    var title : String?
    var icon : String?
    var image : String?
    var hasSub : Bool?
    var SubCategories = [CategoriesSub]()

    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    icon = dictionary["icon"] as? String
    image = dictionary["image"] as? String
    hasSub = dictionary["hasSub"] as? Bool
        

    for item in dictionary["SubCategories"] as? [[String:Any]] ?? [[String:Any]()] {
    SubCategories.append(CategoriesSub(dictionary: item))
    }
    }
}

class Items {
    
    var Sub = [CategoriesSub]()
    var Items = [CategoryItems]()
    init(dictionary:[String:Any]) {
        
    for item in dictionary["SubCategories"] as? [[String:Any]] ?? [[String:Any]()] {
    Sub.append(CategoriesSub(dictionary: item))
    }
        
    for item in dictionary["Items"] as? [[String:Any]] ?? [[String:Any]()] {
    Items.append(CategoryItems(dictionary: item))
    }
    }
}

class CategoriesSub {
    
    var id : String?
    var title : String?
    var icon : String?
    var image : String?
    var hasSub : Bool?

    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    icon = dictionary["icon"] as? String
    image = dictionary["image"] as? String
    hasSub = dictionary["hasSub"] as? Bool
    }
}


class ItemDetails {
    
    var itemId : String?
    var price : String?
    var oldPrice : String?
    var discount : String?
    var isFavourite : Bool?
    var SKU : String?
    var selectedColorId : String?
    var selectedSizeId : String?
    var cartCount : String?
    var Warranty : String?
    var showStock : Bool?
    var stock : String?
    var limit : String?
    var title : String?
    var details : String?
    var productId : String?
    var categoryId : String?
    var categoryName : String?
    var subCategoryID : String?
    
    var brands:Itembrands?
    var Description = [ItemDescription]()
    var Specifications = [ItemSpecifications]()
    var Images = [ItemImages]()
    var Colors = [ItemColors]()
    var Sizes = [ItemSizes]()
    var Vendor : ItemVendor?
    var Rate : ItemRate?
    var Reviews = [ItemReviews]()
    var SimilarItems = [CategoryItems]()
    
    var image:String?
    var outOfStock:Bool?
    
    init(dictionary:[String:Any]) {
        itemId = dictionary["itemId"] as? String
        price = dictionary["price"] as? String
        oldPrice = dictionary["oldPrice"] as? String
        discount = dictionary["discount"] as? String
        isFavourite = dictionary["isFavourite"] as? Bool
        SKU = dictionary["SKU"] as? String
        selectedColorId = dictionary["selectedColorId"] as? String
        selectedSizeId = dictionary["selectedSizeId"] as? String
        cartCount = dictionary["cartCount"] as? String
        Warranty = dictionary["Warranty"] as? String
        showStock = dictionary["showStock"] as? Bool
        stock = dictionary["stock"] as? String
        limit = dictionary["limit"] as? String
        title = dictionary["title"] as? String
        details = dictionary["details"] as? String
        productId = dictionary["productId"] as? String
        categoryId = dictionary["categoryId"] as? String
        categoryName = dictionary["categoryName"] as? String
        subCategoryID = dictionary["subCategoryID"] as? String
        
        if let brand = dictionary["brands"] as? [String:Any] {
        brands = Itembrands(dictionary: brand)
        }
        
        if let vendor = dictionary["vendor"] as? [String:Any] {
        Vendor = ItemVendor(dictionary: vendor)
        }
        
        if let rate = dictionary["rate"] as? [String:Any] {
        Rate = ItemRate(dictionary: rate)
        }

        for item in dictionary["Description"] as? [[String:Any]] ?? [[String:Any]()] {
        Description.append(ItemDescription(dictionary: item))
        }
        
        for item in dictionary["Specifications"] as? [[String:Any]] ?? [[String:Any]()] {
        Specifications.append(ItemSpecifications(dictionary: item))
        }
        
        for item in dictionary["images"] as? [[String:Any]] ?? [[String:Any]()] {
        Images.append(ItemImages(dictionary: item))
        }

        for item in dictionary["colors"] as? [[String:Any]] ?? [[String:Any]()] {
        Colors.append(ItemColors(dictionary: item))
        }

        for item in dictionary["sizes"] as? [[String:Any]] ?? [[String:Any]()] {
        Sizes.append(ItemSizes(dictionary: item))
        }
        
        
        for item in dictionary["Reviews"] as? [[String:Any]] ?? [[String:Any]()] {
        Reviews.append(ItemReviews(dictionary: item))
        }

        for item in dictionary["SimilarItems"] as? [[String:Any]] ?? [[String:Any]()] {
        SimilarItems.append(CategoryItems(dictionary: item))
        }
        
        image = dictionary["image"] as? String
        outOfStock = dictionary["outOfStock"] as? Bool
    }
}


class Itembrands {
    
    var id : String?
    var title : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        title = dictionary["title"] as? String
    }
}

class ItemDescription {
   
    var id : String?
    var title : String?
    var path : String?
    var https : String?
    var mediaType: String?
    var details : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        title = dictionary["title"] as? String
        
        path = dictionary["path"] as? String
        https = dictionary["https"] as? String
        
        mediaType = dictionary["mediaType"] as? String
        details = dictionary["details"] as? String
    }
    
}


class ItemSpecifications {
    var feature:String?
    var description:String?
    
    init(dictionary:[String:Any]) {
    feature = dictionary["feature"] as? String
    description = dictionary["description"] as? String
    }
}

class ItemImages {
    
    var id : String?
    var path : String?
    var mediaType : String?
    
    var Image : UIImage?
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    path = dictionary["path"] as? String
    mediaType = dictionary["mediaType"] as? String
     
    guard let Path = URL(string: path ?? "") else { return }
    SDWebImageManager.shared.loadImage(with: Path,
    options: .highPriority,progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
    self.Image = image
    if isFinished {
    let asset = AVAsset(url: Path)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    do{
    let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
    self.Image = UIImage(cgImage: thumbnailCGImage)
    }catch let err {
    print(err.localizedDescription)
    }
    }
    }
    }
}

class ItemColors {
    
    var id : String?
    var title : String?
    var color : String?
    var isAvailable : Bool?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    color = dictionary["color"] as? String
    isAvailable = dictionary["isAvailable"] as? Bool
    }
}


class ItemSizes {
    
    var id : String?
    var title : String?
    var isAvailable : Bool?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    isAvailable = dictionary["isAvailable"] as? Bool
    }
}

class ItemVendor {
    
    var id : String?
    var name : String?
    var show : Bool?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    name = dictionary["name"] as? String
    show = dictionary["show"] as? Bool
    }
}
 
class ItemRate {
    
    var rating : String?
    var oneStarsCount : String?
    var twoStarsCount : String?
    var threeStarsCount : String?
    var fourStarsCount : String?
    var fiveStarsCount : String?
    
    init(dictionary:[String:Any]) {
    rating = dictionary["rating"] as? String
    oneStarsCount = dictionary["oneStarsCount"] as? String
    twoStarsCount = dictionary["twoStarsCount"] as? String
        
    threeStarsCount = dictionary["threeStarsCount"] as? String
    fourStarsCount = dictionary["fourStarsCount"] as? String
    fiveStarsCount = dictionary["fiveStarsCount"] as? String
    }
}

class ItemReviews {
    
    var id : String?
    var Review : String?
    var userName : String?
    var rat : String?
    var date : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        Review = dictionary["Review"] as? String
        userName = dictionary["userName"] as? String
        rat = dictionary["rat"] as? String
        date = dictionary["date"] as? String
    }
}

class CategoryItems {
    var itemId : String?
    var title : String?
    var image : String?
    var price : String?
    var oldPrice : String?
    var rating : String?
    var discount : String?
    var isFavourite : Bool?
    var categoryId : String?
    
    init(dictionary:[String:Any]) {
    itemId = dictionary["itemId"] as? String
    title = dictionary["title"] as? String
    image = dictionary["image"] as? String
    price = dictionary["price"] as? String
    oldPrice = dictionary["oldPrice"] as? String
        
    rating = dictionary["rating"] as? String
    discount = dictionary["discount"] as? String
    isFavourite = dictionary["isFavourite"] as? Bool        
    categoryId = dictionary["categoryId"] as? String
    }
}
