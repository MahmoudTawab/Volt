//
//  ExtensionDate.swift
//  Volt (iOS)
//
//  Created by Emojiios on 03/07/2022.
//

import UIKit

extension Date {
func Formatter(_ dateFormat: String = "yyyy-MM-dd") -> String {
let dateFormatter = DateFormatter()
dateFormatter.locale = Locale(identifier: "en")
dateFormatter.dateFormat = dateFormat
let calendar = NSCalendar.current
let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: self)
let finalDate = calendar.date(from:components) ?? Date()
return dateFormatter.string(from: finalDate)
}
}
