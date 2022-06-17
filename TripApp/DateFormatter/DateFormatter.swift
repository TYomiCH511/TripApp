//
//  DateFormatter.swift
//  TripApp
//
//  Created by Artem on 10.06.22.
//

import Foundation
import UIKit


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
    
    func showHour(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        formatter.dateFormat = "HH"
        
        return formatter.string(from: date).capitalized
    }
    
    func orderDateTrip(dateTrip: Date, timeTrip: String) -> Date {
     
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        //formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "MM dd yyyy"
        let stringDateTrip = timeTrip + formatter.string(from: dateTrip) 
        print(stringDateTrip)
        formatter.dateFormat = "HH:mm MM dd yyyy"
        guard let dateTrip = formatter.date(from: stringDateTrip) else { return Date() }
        print(dateTrip)
        return dateTrip
    }
    
    
}
