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
        formatter.dateFormat = "HH:mm MM dd yyyy"
        guard let dateTrip = formatter.date(from: stringDateTrip) else { return Date() }
        return dateTrip
    }
    
    func dateReservedTripNotification(dateTrip: Date) -> Date {
        
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        //formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "MM dd yyyy"
        let stringDateTrip = "10:00 " + formatter.string(from: dateTrip.addingTimeInterval(-76000))
        formatter.dateFormat = "HH:mm MM dd yyyy"
        guard let dateTrip = formatter.date(from: stringDateTrip) else { return Date() }
        return dateTrip
        
    }
    
    func compare(firstDate: Date, secondDate: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        //formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "MM dd yyyy"
        let firstString = formatter.string(from: firstDate)
        let secondString = formatter.string(from: secondDate)
        guard let firstDate = formatter.date(from: firstString),
              let secondDate = formatter.date(from: secondString) else { return false}
        if firstDate > secondDate {
            return true
        }
        
        return false
    }
    
}
