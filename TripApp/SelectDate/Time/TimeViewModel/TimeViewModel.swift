//
//  TimeViewModel.swift
//  TripApp
//
//  Created by Artem on 15.06.22.
//

import Foundation

protocol TimeViewModelProtocol {
    
    var time: Time { get }
    init(time: Time)
    func getInfoPerHour() -> String
}


class TimeViewModel: TimeViewModelProtocol {
    var time: Time
    
    required init(time: Time) {
        self.time = time
    }
    
    func getInfoPerHour() -> String {
        var infoHour = ""
        if time.hour < 10 {
            infoHour = "0\(time.hour):00"
        } else {
            infoHour = "\(time.hour):00"
        }
        
        var infoPassager = ""
        switch time.countPassager {
        case 0:
            infoPassager = "(нет)"
        case 1,2:
            infoPassager = "(\(time.countPassager))"
        default:
            infoPassager = "(>3)"
            
        }
        let info = infoHour + " " + infoPassager
        return info
    }
    
}
