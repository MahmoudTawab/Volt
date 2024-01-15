//
//  Addresses.swift
//  Volt (iOS)
//
//  Created by Emojiios on 12/03/2022.
//

import Foundation

class Addresses {
    
    var id : String?
    var Name : String?
    var phone : String?
    var streetName : String?
    var buildingNumber : String?
    var floorNumber : String?
    var landmark : String?
    var IsDefault : Bool?
    var lat : String?
    var lon : String?
    
    var city : CitiesAndAreas?
    var area : CitiesAndAreas?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    Name = dictionary["Name"] as? String
    phone = dictionary["phone"] as? String
        
    streetName = dictionary["streetName"] as? String
    buildingNumber = dictionary["buildingNumber"] as? String
    floorNumber = dictionary["floorNumber"] as? String

    landmark = dictionary["landmark"] as? String
    IsDefault = dictionary["IsDefault"] as? Bool
    lat = dictionary["lat"] as? String
    lon = dictionary["lon"] as? String
        
    if let City = dictionary["city"] as? [String:Any] {
    city = CitiesAndAreas(dictionary: City)
    }
        
    if let Area = dictionary["area"] as? [String:Any] {
    area = CitiesAndAreas(dictionary: Area)
    }
    }
}

class CitiesAndAreas {
    var id : String?
    var title : String?
    
    var Areas = [CitiesAndAreas]()
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
        
    if let areas = dictionary["Areas"] as? [[String:Any]] {
    for item in areas {
    Areas.append(CitiesAndAreas(dictionary: item))
    }
    }
    }
}



