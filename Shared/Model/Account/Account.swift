//
//  Account.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 07/12/2021.
//

import Foundation

class Account {
      
    var IsUser : Bool?
    var Cart = [String:Any]()
    
    init(dictionary:[String:Any]) {
       
    if let ISUser = dictionary["IsUser"] as? Bool {
    IsUser = ISUser
    }
        
    if let Jwt = dictionary["JWT"] as? String {
    defaults.set(Jwt, forKey: "JWT")
    defaults.synchronize()
    }
        
    ///
    if let UserData = dictionary["user"] as? [String:Any]  {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: UserData)
    defaults.set(encodedData, forKey: "User")
    defaults.synchronize()
    }
        
    ///
    if let CartData = dictionary["cart"] as? [String:Any] {
    Cart = CartData
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: CartData)
    defaults.set(encodedData, forKey: "Cart")
    defaults.synchronize()
    }
        
    }


}
