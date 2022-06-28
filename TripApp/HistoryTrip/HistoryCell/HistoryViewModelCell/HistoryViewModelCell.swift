//
//  HistoryViewModelCell.swift
//  TripApp
//
//  Created by Artem on 10.06.22.
//

import Foundation


protocol HistoryViewModelCellProtocol {
    var trip: Trip { get }
    var tag: Int { get }
    var fullData: Bool { get }
    var actionTripDelegate: ActionTripPressedProtocol? { get }
    init(trip: Trip, tag: Int, delegate: ActionTripPressedProtocol, fullData: Bool)
    func cancelTrip()
    func editTrip()
    func reviewTrip()
    func reservTrip()
}


class HistoryViewModelCell: HistoryViewModelCellProtocol {
    
    weak var actionTripDelegate: ActionTripPressedProtocol?
    var trip: Trip
    var tag: Int
    var fullData: Bool
    required init(trip: Trip, tag: Int, delegate: ActionTripPressedProtocol, fullData: Bool = false) {
        self.trip = trip
        self.tag  = tag
        actionTripDelegate = delegate
        self.fullData = fullData
    }
    
    func cancelTrip() {
        if trip.tripStatus != TripStatus.complition.rawValue,
           trip.tripStatus != TripStatus.cancel.rawValue {
            
            trip.tripStatus = TripStatus.cancel.rawValue
            actionTripDelegate?.actionTripPressed(trip: trip, tag: tag, action: .cancel)
        }
    }
    
    func editTrip() {
        actionTripDelegate?.actionTripPressed(trip: trip, tag: tag, action: .edit)
    }
    
    func reviewTrip() {
        actionTripDelegate?.actionTripPressed(trip: trip, tag: tag, action: .review)
    }
    
    func reservTrip() {
        TripsManager.shared.reservTrip(tripId: trip.id) { [weak self] in
            guard let self = self else { return }
            self.actionTripDelegate?.actionTripPressed(trip: self.trip, tag: self.tag, action: .reserv)
        }
        
        
    }
    
}
