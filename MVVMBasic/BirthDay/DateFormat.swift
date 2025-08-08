//
//  DateFormat.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/7/25.
//

import Foundation

extension DateFormatter {
    static func checkYear(text: String) -> Bool {
        let format = DateFormatter()
        
        format.dateFormat = "YYYY"
        
        return format.date(from: text) == nil ? false : true
    }
    
    static func checkMonth(text: String) -> Bool {
        let format = DateFormatter()
        
        format.dateFormat = "MM"
        
        return format.date(from: text) == nil ? false : true
    }
    
    static func checkDay(text: String) -> Bool {
        let format = DateFormatter()
        
        format.dateFormat = "dd"
        
        return format.date(from: text) == nil ? false : true
    }
    
    static func untilDay(year: String, month: String, day: String) -> String {
        let dateString = "\(year)-\(month)-\(day)"
        let dateFormat = {
            let format = DateFormatter()
            
            format.locale = Locale(identifier: "ko_KR")
            format.timeZone = TimeZone(abbreviation: "KST")
            format.dateFormat = "YYYY-MM-dd"
            
            return format
        }()
        
        let date: Date = dateFormat.date(from: dateString)!
        
        let distanceDay = Calendar.current.dateComponents([.day], from: date, to: Date()).day
        
        return String(describing: distanceDay!)
    }
}
