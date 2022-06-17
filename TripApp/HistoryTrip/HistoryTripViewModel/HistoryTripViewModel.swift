//
//  HistoryTripViewModel.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

enum ActionTrip {
    case edit
    case cancel
}

protocol HistoryTripViewModelProtocol {
    var showInfoDelegate: ShowFullInfoOfTripProtocol? { get }
    var editTripDelegate: EditTripProtocol? { get set }
    var trips: Bindable<[Trip]> { get }
    func tripsCount() -> Int
    func cellViewModel(at indexPath: IndexPath) -> HistoryViewModelCellProtocol
    
}

protocol ActionTripPressedProtocol: AnyObject {
    func cancelTripPressed(trip: Trip, tag: Int, action: ActionTrip)
}

protocol EditTripProtocol: AnyObject {
    func editTrip(trip: Trip, tag: Int)
}


protocol ShowFullInfoOfTripProtocol: AnyObject {
    func showFullInfo()
}


class HistoryTripViewModel: HistoryTripViewModelProtocol, ActionTripPressedProtocol {
    weak var editTripDelegate: EditTripProtocol?
    
    var trips: Bindable<[Trip]> = Bindable<[Trip]>(UserStore.shared.getUser()?.trips ?? tripsStore)
    
    weak var showInfoDelegate: ShowFullInfoOfTripProtocol?
    
    func tripsCount() -> Int {
        return trips.value.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HistoryViewModelCellProtocol {
        
        let trip = trips.value[indexPath.row]
        return HistoryViewModelCell(trip: trip, tag: indexPath.row, delegate: self)
    }
    
    
    func cancelTripPressed(trip: Trip, tag: Int, action: ActionTrip) {
        switch action {
        case .edit:
            editTripDelegate?.editTrip(trip: trip, tag: tag)
        case .cancel:
            trips.value[tag] = trip
            guard var user = UserStore.shared.getUser() else { return }
            user.trips[tag] = trip
            UserStore.shared.save(user: user)
            // send trip to back-end
            
        }
    }
    
    
    
    
    
}


