//
//  HistoryTripViewModel.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

protocol HistoryTripViewModelProtocol {
    var trips: Bindable<[Trip]> { get }
    func tripsCount() -> Int
    func cellViewModel(at indexPath: IndexPath) -> HistoryViewModelCellProtocol

}

protocol CancelTripButtonPressedProtocol: AnyObject {
    func cancelTripPressed(trip: Trip, tag: Int)
}


class HistoryTripViewModel: HistoryTripViewModelProtocol, CancelTripButtonPressedProtocol {
    
    
    var trips: Bindable<[Trip]> = Bindable<[Trip]>(UserStore.shared.getUser()?.trips ?? StorageManeger.shared.trips)
       
    
        
    func tripsCount() -> Int {
        return trips.value.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HistoryViewModelCellProtocol {
        
        let trip = trips.value[indexPath.row]
        return HistoryViewModelCell(trip: trip, tag: indexPath.row, delegate: self)
    }
    
    
    func cancelTripPressed(trip: Trip, tag: Int) {
        trips.value[tag] = trip
        guard var user = UserStore.shared.getUser() else { return }
        user.trips[tag] = trip
        UserStore.shared.save(user: user)
        
        // send trip to back-end
    }
}


