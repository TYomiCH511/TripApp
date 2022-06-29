//
//  Trip.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation
import FirebaseFirestore


enum TripStatus: String, Codable {
    case notReserved = "notReserved"
    case reserved = "reserved"
    case complition = "complition"
    case cancel = "cancel"
}

struct Trip: Codable {
    var id: String = UUID().uuidString
    var date: Date?
    var startCity: String?
    var startStaition: String?
    var finishCity: String?
    var finishStaition: String?
    var tripStatus: String?
    var countPasseger: Int?
    //let driver: Driver
    var isReviewDriver: Bool = false
    
        
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["id"] = id
        repres["date"] = Timestamp(date: date!)
        repres["startCity"] = startCity
        repres["startStaition"] = startStaition
        repres["finishCity"] = finishCity
        repres["finishStaition"] = finishStaition
        repres["countPassager"] = countPasseger
        repres["isReviewDriver"] = isReviewDriver
        repres["orderDate"] = Timestamp(date: Date())
        repres["tripStatus"] = tripStatus
        
        return repres
    }
    
    init(id: String, date: Date?, startCity: String?, startStaition: String?, finishCity: String?, finishStaition: String?, tripStatus: String, countPassager: Int?, isReviewDriver: Bool = false) {
        self.date = date
        self.id = id
        self.startCity = startCity
        self.startStaition = startStaition
        self.finishCity = finishCity
        self.finishStaition = finishStaition
        self.tripStatus = tripStatus
        self.countPasseger = countPassager
        //self.driver: Driver
        self.isReviewDriver = isReviewDriver
    }
    
    init?(tripData: QueryDocumentSnapshot) {
        
        let data = tripData.data()
        
        guard let id = data["id"] as? String else { return }
        guard let date = data["date"] as? Timestamp else { return }
        guard let startCity = data["startCity"] as? String else { return }
        guard let startStaition = data["startStaition"] as? String else { return }
        guard let finishCity = data["finishCity"] as? String else { return }
        guard let finishStaition = data["finishStaition"] as? String else { return }
        guard let countPassager = data["countPassager"] as? Int else { return }
        guard let isReviewDriver = data["isReviewDriver"] as? Bool else { return }
        guard let tripStatus = data["tripStatus"] as? String else { return }
        
        self.date = date.dateValue()
        self.id = id
        self.startCity = startCity
        self.startStaition = startStaition
        self.finishCity = finishCity
        self.finishStaition = finishStaition
        self.tripStatus = tripStatus
        self.countPasseger = countPassager
        //self.driver: Driver
        self.isReviewDriver = isReviewDriver
        
    }
    
}

struct Driver: Codable {
    let carModel: String
    let carColor: String
    let carNumber: String
    let countSits: Int
    let phoneNumber: String
    let raiting: String
    let fullName: String
    let photo: String
    
}
