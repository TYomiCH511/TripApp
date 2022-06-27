//
//  TripsManager.swift
//  TripApp
//
//  Created by Artem on 27.06.22.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class TripsManager {
    
    static let shared = TripsManager()
    private init() {}
    private let db = Firestore.firestore()
    private let currenUser = Auth.auth().currentUser
    private let collection = "trips"
    private let collectionTrips = "historyTrips"
    
    func setTrip(withUserId id: String, trip: Trip, complition: @escaping (Trip) -> ()) {
        
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection("trips").document(uid).collection(collectionTrips)
        
        
        userTripsData.document(trip.id).setData(trip.representation) { error in
            guard error == nil else {
                print("Order trip failure")
                print(error)
                return }
            
            print("order trip done")
        }
        
    }
    
    
    
}
