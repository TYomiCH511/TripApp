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
    private let collection = "trips"
    private let collectionTrips = "historyTrips"
    
    
    
    func setTrip(withUserId id: String, trip: Trip, complition: @escaping () -> ()) {
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection(collection).document(uid).collection(collectionTrips)
        
        userTripsData.document(trip.id).setData(trip.representation) { error in
            guard error == nil else {
                return }
            complition()
        }
    }
    
    func getTrips(withUserId id: String,
                  complition: @escaping ([Trip]) -> ()) {
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection(collection).document(uid).collection(collectionTrips)
        
        userTripsData.getDocuments { tripsSnap, error in
            
            guard let tripsSnap = tripsSnap else { return }
            var trips = [Trip]()
            for trip in tripsSnap.documents {
                guard var trip = Trip(tripData: trip) else { return }
                if let date = trip.date, date < Date(timeIntervalSinceNow: -1000) {
                    trip.tripStatus = TripStatus.complition.rawValue
                }
                
                // -1_200_000 - equal 14 days
                if let date = trip.date, date < Date(timeIntervalSinceNow: -1_200_000) {
                    
                    userTripsData.document(trip.id).delete { error in
                        guard error == nil else { return }
                        print("deleted")
                    }
                } else {
                    trips.append(trip)
                }
            }
            complition(trips.sorted(by: { one, two in
                guard let one = one.orderDate, let two = two.orderDate else { return false }
                return one > two
            }))
        }
    }
    
    func reservTrip(tripId: String,
                    complition: @escaping () -> ()) {
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection(collection).document(uid).collection(collectionTrips)
        
        let reservData: [String: Any] = ["tripStatus": TripStatus.reserved.rawValue]
        userTripsData.document(tripId).setData(reservData, merge: true) { error in
            guard error == nil else { return }
            complition()
        }
    }
    
    func editTrip(trip: Trip, complition: @escaping () -> ()) {
        
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection(collection).document(uid).collection(collectionTrips)
        
        userTripsData.document(trip.id).setData(trip.representation, merge: true) { error in
            guard error == nil else { return }
            complition()
        }
    }
    
    func leaveReview(tripId: String,
                     complition: @escaping () -> ()) {
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let userTripsData = db.collection(collection).document(uid).collection(collectionTrips)
        
        let reservData: [String: Any] = ["isReviewDriver": true]
        userTripsData.document(tripId).setData(reservData, merge: true) { error in
            guard error == nil else { return }
            complition()
        }
    }
}
