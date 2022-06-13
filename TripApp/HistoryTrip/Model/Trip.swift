//
//  Trip.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation



enum TripState: Codable {
    case cancel
    case reserved
    case notReserved
    case complition
    
}

struct Trip: Codable {
    let date: Date
    var startCity: String
    let startStaition: String
    let finishCity: String
    let finishStaition: String
    var tripStait: TripState
    let countPasseger: Int
    let driver: Driver?
}


struct Driver: Codable {
    
    let carModel: String
    let carColor: String
    let carNumber: String
    let phoneNumber: String
    let raiting: String
    
}
