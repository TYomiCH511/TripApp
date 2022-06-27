//
//  Trip.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation
import FirebaseFirestore


enum TripState: Codable {
    case cancel
    case reserved
    case notReserved
    case complition
    
}

struct Trip: Codable {
    var id: String = UUID().uuidString
    var date: Date?
    var startCity: String?
    var startStaition: String?
    var finishCity: String?
    var finishStaition: String?
    var tripStait: TripState
    var countPasseger: Int?
    let driver: Driver
    var isReviewDriver: Bool = false
    
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["date"] = Timestamp(date: date!)
        repres["startCity"] = startCity
        repres["startStaition"] = startStaition
        repres["finishCity"] = finishCity
        repres["finishStaition"] = finishStaition
        repres["countPassager"] = countPasseger
        repres["isReviewDriver"] = isReviewDriver
        repres["orderDate"] = Timestamp(date: Date())
        
        
        return repres
    }
}


struct Driver: Codable {
    
    let carModel: String
    let carColor: String
    let carNumber: String
    let phoneNumber: String
    let raiting: String
    let fullName: String
    let photo: String
    
}
