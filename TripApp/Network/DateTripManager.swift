//
//  DateTripManager.swift
//  TripApp
//
//  Created by Artem on 28.06.22.
//

import Foundation
import FirebaseFirestore


class DateTripManager {
    
    static let shared = DateTripManager()
    private init() {}
    private let db = Firestore.firestore()
    private let collection = "dateTrip"
    
    func getTime(inDate date: Date, complition: @escaping (DateTrip) -> ()) {
        
        db.collection(collection).getDocuments { snapDate, error in
            guard let snapDate = snapDate, error == nil else {
                let day: [String: Any] = ["id": UUID().uuidString,
                                          "date": Timestamp(date: date),
                                          "houres": []
                ]
               
                return }
            
            
            for dateData in snapDate.documents {
                guard let day = DateTrip(dateData: dateData) else { return }
                if CustomDate.shared.showDate(from: day.date!) == CustomDate.shared.showDate(from: date) {
                    complition(day)
                } else {
                    print("11111111111111111")
                    print(CustomDate.shared.showDate(from: day.date!))
                    print(CustomDate.shared.showDate(from: date))
                }
               
            }
        }
    }
    
    func chekDay() {
        db.collection(collection).getDocuments { snapDate, error in
            guard let snapDate = snapDate, error == nil else { return }
            if snapDate.count != 3 {
                let id = UUID().uuidString
                let day: [String: Any] = ["id": id,
                                          "date": Timestamp(date: Date(timeIntervalSinceNow: 172000)),
                                          "houres": ["0": "06:00",
                                                     "1": "07:00",
                                                     "2": "08:00",]
                ]
                self.db.collection(self.collection).document(id).setData(day)
                print("less 30")
                print(snapDate.count)
            }
            
        }
    }
    
}
