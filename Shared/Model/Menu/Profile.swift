//
//  Profile.swift
//  Volt (iOS)
//
//  Created by Emojiios on 07/03/2022.
//

import Foundation

class Profile {
    
    var user: User?
    
    init(dictionary:[String:Any]) {
        
    if let Jwt = dictionary["JWT"] as? String {
    defaults.set(Jwt, forKey: "JWT")
    defaults.synchronize()
    }
    
    if let UserData = dictionary["user"] as? [String:Any] {
    user = User(dictionary: UserData)
        
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: UserData)
    defaults.set(encodedData, forKey: "User")
    defaults.synchronize()
    }
    }
}
