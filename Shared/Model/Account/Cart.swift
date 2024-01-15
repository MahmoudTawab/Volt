//
//  Cart.swift
//  Volt (iOS)
//
//  Created by Emojiios on 19/02/2022.
//

import UIKit
import CoreData

class CartGet {
        
    var id : String?
    var SubtotalPrice : String?
    var ShippingPrice : String?
    var totalPrice : String?
    var Items = [CartItems]()
    
    init(dictionary:[String:Any]) {
        
    id = dictionary["id"] as? String
    SubtotalPrice = dictionary["SubtotalPrice"] as? String
        
    ShippingPrice = dictionary["ShippingPrice"] as? String
    totalPrice = dictionary["totalPrice"] as? String
        
    for item in dictionary["Items"] as? [[String:Any]] ?? [[String:Any]]() {
    Items.append(CartItems(dictionary: item))
    }
    }
}

class CartItems: Codable {
    
    var itemId : String?
    var title : String?
    
    var image : String?
    
    var price : String?
    
    var oldPrice : String?
    
    var outOfStock : Bool?
        
    var limit : String?
    
    var rating : String?
    
    var isFav : Bool?
    
    var categoryId : String?
    var categoryName : String?
    
    var ColorId : String?
    var ColorTitle : String?
    var Color : String?
    
    var SizeId : String?
    var SizeTitle : String?
    
    var ItemCount : Int?
    
    init(itemId:String? ,title : String? ,image : String?, price : String? , outOfStock : Bool? , limit : String? , isFav : Bool?, categoryId : String? , categoryName : String? , ColorId : String? , ColorTitle : String? , Color : String?, SizeId : String? , SizeTitle : String? , ItemCount : Int?) {
        self.itemId = itemId
        self.title = title

        self.image = image
        self.price = price

        self.outOfStock = outOfStock
        self.limit = limit
            
        self.isFav = isFav
        self.categoryId = categoryId
        self.categoryName = categoryName
    
        self.ColorId = ColorId
        self.ColorTitle = ColorTitle
        self.Color = Color
        
        self.SizeId = SizeId
        self.SizeTitle = SizeTitle
        
        self.ItemCount = ItemCount
    }
    
    init(OffLine:[String:Any]) {
        itemId = OffLine["itemId"] as? String
        title = OffLine["title"] as? String

        image = OffLine["image"] as? String
        price = OffLine["price"] as? String
                    
        outOfStock = OffLine["outOfStock"] as? Bool
        limit = OffLine["limit"] as? String
            
        
        isFav = OffLine["isFav"] as? Bool
        categoryId = OffLine["categoryId"] as? String
        categoryName = OffLine["categoryName"] as? String
    
        ColorId = OffLine["ColorId"] as? String
        ColorTitle = OffLine["ColorTitle"] as? String
        Color = OffLine["Color"] as? String
        
        SizeId = OffLine["SizeId"] as? String
        SizeTitle = OffLine["SizeTitle"] as? String
        
        ItemCount = OffLine["ItemCount"] as? Int
    }
        
    init(dictionary:[String:Any]) {
        itemId = dictionary["itemId"] as? String
        
        title = dictionary["title"] as? String

        image = dictionary["image"] as? String
        
        price = dictionary["price"] as? String
        
        oldPrice = dictionary["oldPrice"] as? String
            
        outOfStock = dictionary["outOfStock"] as? Bool
        
        limit = dictionary["limit"] as? String
            
        rating = dictionary["rating"] as? String
        
        isFav = dictionary["isFavourite"] as? Bool
        
        categoryId = dictionary["categoryId"] as? String
        
        categoryName = dictionary["categoryName"] as? String
            
        ItemCount = Int(dictionary["cartCount"] as? String ?? "")
        
        if let color = dictionary["color"] as? [String:Any]  {
        ColorId = color["id"] as? String
        ColorTitle = color["title"] as? String
        Color = color["color"] as? String
        }
        
        if let size = dictionary["size"] as? [String:Any]  {
        SizeId = size["id"] as? String
        SizeTitle = size["title"] as? String
        }
    }
}

// Cart Items OffLine

public enum CartStyle {
    case Add,UpDate,Remove
}

func AddCart(Items:CartItems,Style:CartStyle)  {
    switch Style {
    case .Remove:
    if var ItemsArray = defaults.array(forKey: "ItemsCart") as? [[String:Any]] {
    ItemsArray.removeAll(where: {$0.contains(where: {$0.value as? String == Items.itemId})})
    defaults.set(ItemsArray, forKey: "ItemsCart")
    defaults.synchronize()
    }
        
    case .Add:
    guard let Dict = Items.convertToDict() else { return }
    if var ItemsArray = defaults.array(forKey: "ItemsCart") as? [[String:Any]] {
    ItemsArray.removeAll(where: {$0.contains(where: {$0.value as? String == Items.itemId})})
    defaults.synchronize()
        
    ItemsArray.append(Dict)
    defaults.set(ItemsArray, forKey: "ItemsCart")
    defaults.synchronize()
    }else{
    defaults.set([Dict], forKey: "ItemsCart")
    defaults.synchronize()
    }
        
    case .UpDate:
    guard let Dict = Items.convertToDict() else { return }
    if var ItemsArray = defaults.array(forKey: "ItemsCart") as? [[String:Any]] {
    if let Array = ItemsArray.firstIndex(where: {$0.contains(where: {$0.value as? String == Items.itemId})}) {
    ItemsArray[Array] = Dict
    defaults.set(ItemsArray, forKey: "ItemsCart")
    defaults.synchronize()
    }
    }
    }
 }

extension CartItems {
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
        print(error)
        }
        return dict
    }
}

func GetCartOffLine() -> Any {
var NewArray = [[String:Any]]()
NewArray.removeAll()
if let ItemsArray = defaults.array(forKey: "ItemsCart") as? [[String:Any]] {
ItemsArray.forEach { Array in
let ID = Array["itemId"] as? String ?? ""
let Count = Array["ItemCount"] as? Int ?? 0
NewArray.append(["itemId" : ID , "cartCount" : Count])
}
return NewArray
}
return []
}


func getCartObject() -> CartGet? {
if let data = defaults.object(forKey: "Cart") as? Data {
if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:Any] {
let Cart = CartGet(dictionary: decodedPeople)
return Cart
}
}
return nil
}

func UpDateCartObject(Data:[String:Any]?) {
    if let data = Data {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: data)
    defaults.set(encodedData, forKey: "Cart")
    defaults.synchronize()
    }
}
