//
//  JWT.swift
//  Volt (iOS)
//
//  Created by Emojiios on 19/02/2022.
//

import Foundation

class JWT {
      
    init(dictionary:[String:Any]) {
    if let Jwt = dictionary["JWT"] as? String {
    defaults.set(Jwt, forKey: "JWT")
    defaults.synchronize()
    }
        
    }
}
