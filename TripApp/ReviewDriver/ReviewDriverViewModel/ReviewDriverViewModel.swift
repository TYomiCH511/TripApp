//
//  ReviewDriverViewModel.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import Foundation

protocol ReviewDriverViewModelProtocol {
    var tripDirection: String { get }
    var tripTime: String { get }
    var photo: String { get }
    var fullName: String { get }
    
    func leaveReview()
}


class ReviewDriverViewModel: ReviewDriverViewModelProtocol {
    
    var tripDirection: String {
        guard let startStaition = trip.startStaition,
              let startCity = trip.startCity,
              let finishCity = trip.finishCity else { return "" }
        let tripDirection = "\(startStaition)(\(startCity)) - \(finishCity)"
        return tripDirection
    }
    
    var tripTime: String {
        guard let date = trip.date else { return ""}
        let dateTrip = CustomDate.shared.showDate(from: date)
        let timeTrip = "\(CustomDate.shared.showTime(from: date)) - ????"
        return "\(dateTrip), \(timeTrip)"
    }
    
    var photo: String {
        //return trip.driver.photo
        
        return ""
    }
    
    var fullName: String {
        //return trip.driver.fullName
        
        return ""
    }
    
    var trip: Trip
    var tripSelect: Int
    
    init(trip: Trip, tripSelect: Int) {
        self.trip = trip
        self.tripSelect = tripSelect
    }
    
    func leaveReview() {
        
        guard var user = UserStore.shared.getUser() else { return }
        trip.isReviewDriver = true
        user.trips[tripSelect] = trip
        UserStore.shared.save(user: user)
        
        
        //send to back-end
    }
    
}
