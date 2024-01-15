//
//  NotificationsSettings.swift
//  Volt (iOS)
//
//  Created by Emojiios on 11/03/2022.
//

import Foundation

class NotificationsSettings {
    
    var ReceiveNotifications : Bool?
    var ReceiveEmail : Bool?
    
    init(dictionary:[String:Any]) {
    ReceiveNotifications = dictionary["ReceiveNotifications"] as? Bool
        
    ReceiveEmail = dictionary["ReceiveEmail"] as? Bool
    }
}
