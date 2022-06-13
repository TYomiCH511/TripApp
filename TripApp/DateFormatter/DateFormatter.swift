//
//  DateFormatter.swift
//  TripApp
//
//  Created by Artem on 10.06.22.
//

import Foundation


class CustomDate {
    
    static let shared = CustomDate()
    private init() {}
    
    func showDay(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        formatter.dateFormat = "EEEE"
        
        return formatter.string(from: date).capitalized
    }
    
    func showDate(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        formatter.dateFormat = "d MMM yyyy"
        
        return formatter.string(from: date).capitalized
    }
    
    func showTime(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date).capitalized
    }
    
    
}