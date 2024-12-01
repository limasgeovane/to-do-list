//
//  Date.swift
//  AppToDoList
//
//  Created by Geovane Lima dos Santos on 01/12/24.
//

import Foundation

extension Date {
    
    public func convertDateToString(date: Date, dateFormatter: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let myString = formatter.string(from: date)
        
        if let yourDate = formatter.date(from: myString) {
            formatter.dateFormat = dateFormatter ?? "yyyy-MM-dd'T'HH:mm:ss"
            return formatter.string(from: yourDate)
        } else {
            return ""
        }
    }
    
    public func convertStringToDate(dateString: String, dateFormatter: String?) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter ?? "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter.date(from: dateString) ?? nil
    }
    
}
