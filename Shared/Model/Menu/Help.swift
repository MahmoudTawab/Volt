//
//  Help.swift
//  Volt (iOS)
//
//  Created by Emojiios on 11/03/2022.
//

import Foundation

class Help {
    
    var id:String?
    var question:String?
    var answer:String?
    var HelpHidden = true
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    question = dictionary["question"] as? String
    answer = dictionary["answer"] as? String
    }
}
