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
    var actionTripDelegate: ActionTripPressedProtocol? { get }
    init(trip: Trip, tag: Int, delegate: ActionTripPressedProtocol)
    func cancelTrip()
    func editTrip()
    func reviewTrip()
}


class HistoryViewModelCell: HistoryViewModelCellProtocol {
    
    weak var actionTripDelegate: ActionTripPressedProtocol?
    var trip: Trip
    var tag: Int
    
    required init(trip: Trip, tag: Int, delegate: ActionTripPressedProtocol) {
        self.trip = trip
        self.tag  = tag
        actionTripDelegate = delegate
    }
    
    func cancelTrip() {
        if trip.tripStait != .complition, trip.tripStait != .cancel {
            trip.tripStait = .cancel
            actionTripDelegate?.actionTripPressed(trip: trip, tag: tag, action: .cancel)
        }
    }
    
    func editTrip() {
        actionTripDelegate?.actionTripPressed(trip: trip, tag: tag, action: .edit)
    }
    
    func reviewTrip() {
        actionTripDelegate?.actionTripPressed(trip: trip, tag: tag, action: .review)
    }
    
}
