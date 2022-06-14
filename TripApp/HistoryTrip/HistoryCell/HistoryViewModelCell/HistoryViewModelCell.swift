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
    var cancelDelegate: ActionTripPressedProtocol? { get }
    init(trip: Trip, tag: Int, delegate: ActionTripPressedProtocol)
    func cancelTrip()
    func editTrip()
}


class HistoryViewModelCell: HistoryViewModelCellProtocol {
    
    weak var cancelDelegate: ActionTripPressedProtocol?
    var trip: Trip
    var tag: Int
    
    required init(trip: Trip, tag: Int, delegate: ActionTripPressedProtocol) {
        self.trip = trip
        self.tag  = tag
        cancelDelegate = delegate
    }
    
    func cancelTrip() {
        if trip.tripStait != .complition, trip.tripStait != .cancel {
            trip.tripStait = .cancel
            cancelDelegate?.cancelTripPressed(trip: trip, tag: tag, action: .cancel)
        }
    }
    
    func editTrip() {
        cancelDelegate?.cancelTripPressed(trip: trip, tag: tag, action: .edit)
    }
    
}
