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
    var cancelDelegate: CancelTripButtonPressedProtocol? { get }
    init(trip: Trip, tag: Int, delegate: CancelTripButtonPressedProtocol)
    func cancelTrip()
    
}


class HistoryViewModelCell: HistoryViewModelCellProtocol {
    
    weak var cancelDelegate: CancelTripButtonPressedProtocol?
    var trip: Trip
    var tag: Int
    
    required init(trip: Trip, tag: Int, delegate: CancelTripButtonPressedProtocol) {
        self.trip = trip
        self.tag  = tag
        cancelDelegate = delegate
    }
    
    func cancelTrip() {
        if trip.tripStait != .complition, trip.tripStait != .cancel {
            trip.tripStait = .cancel
            cancelDelegate?.cancelTripPressed(trip: trip, tag: tag)
        }
        
    }
    
}
