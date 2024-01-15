//
//  About.swift
//  Volt (iOS)
//
//  Created by Emojiios on 13/03/2022.
//

import Foundation

class About {
    
    var id : String?
    var title : String?
    var body : String?
    var image : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    body = dictionary["body"] as? String
    image = dictionary["image"] as? String
    }
}
