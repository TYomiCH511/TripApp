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
    
    
    
    func setTrip(withUserId id: String, trip: Trip, complition: @escaping () -> ()) {
        
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
    
    func getTrips(withUserId id: String, complition: @escaping ([Trip]) -> ()) {
        
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection("trips").document(uid).collection(collectionTrips)
        
        
        userTripsData.getDocuments { tripsSnap, error in
            
            guard let tripsSnap = tripsSnap else { return }
            var trips = [Trip]()
            for trip in tripsSnap.documents {
                guard let trip = Trip(trip: trip) else { return }
                trips.append(trip)
                print(trip)
            }
            complition(trips)
        }
    }
    
    func reservTrip(tripId: String, complition: @escaping () -> ()) {
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection("trips").document(uid).collection(collectionTrips)
        
        let reservData: [String: Any] = ["tripStatus": "reserved"]
        userTripsData.document(tripId).setData(reservData, merge: true) { error in
            guard error == nil else { return }
            complition()
        }
    }
    
    
    
}
