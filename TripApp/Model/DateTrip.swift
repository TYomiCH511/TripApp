//
//  DateTrip.swift
//  TripApp
//
//  Created by Artem on 28.06.22.
//

import Foundation
import FirebaseFirestore

struct DateTrip {
    
    var id: String = UUID().uuidString
    var date: Date?
    var houres: [Hour]?
    
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        
        repres["id"] = self.id
        repres["date"] = Timestamp(date: self.date ?? Date())
        repres["houres"] = self.houres
        return repres
    }
    
    init?(dateData: QueryDocumentSnapshot) {
        
        let data = dateData.data()
    
        
        guard let id = data["id"] as? String else { return }
        guard let date = data["date"] as? Timestamp else { return }
        
        
        self.id = id
        self.date = date.dateValue()
    }
    
}


struct Hour {
    let id: String
    let hour: Date
    let countPassager: Int
    let driver: Driver
    
    
}
