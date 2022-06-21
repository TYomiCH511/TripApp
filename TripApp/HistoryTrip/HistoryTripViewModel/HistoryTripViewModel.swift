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
    case review
    case reserv
}

protocol HistoryTripViewModelProtocol {
    var showInfoDelegate: ShowFullInfoOfTripProtocol? { get }
    var editTripDelegate: EditTripProtocol? { get set }
    var reviewDelegate: LeaveReviewDriverProtocol? { get set }
    var trips: Bindable<[Trip]> { get }
    var isShowFull: [Bool] { get set }
    func tripsCount() -> Int
    func cellViewModel(at indexPath: IndexPath) -> HistoryViewModelCellProtocol
    func reviewViewModel(atSelectRow selectRow: Int) -> ReviewDriverViewModelProtocol
    
}

protocol ActionTripPressedProtocol: AnyObject {
    func actionTripPressed(trip: Trip, tag: Int, action: ActionTrip)
}

protocol EditTripProtocol: AnyObject {
    func editTrip(trip: Trip, tag: Int)
}


protocol ShowFullInfoOfTripProtocol: AnyObject {
    func showFullInfo()
}

protocol LeaveReviewDriverProtocol: AnyObject {
    func leaveReview(viewModel: ReviewDriverViewModelProtocol)
}


class HistoryTripViewModel: HistoryTripViewModelProtocol, ActionTripPressedProtocol {
    
    var trips: Bindable<[Trip]> = Bindable<[Trip]>(UserStore.shared.getUser()?.trips ?? tripsStore)
    weak var reviewDelegate: LeaveReviewDriverProtocol?
    weak var editTripDelegate: EditTripProtocol?
    weak var showInfoDelegate: ShowFullInfoOfTripProtocol?
    lazy var isShowFull: [Bool] = Array(repeating: false, count: trips.value.count)
    func tripsCount() -> Int {
        return trips.value.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HistoryViewModelCellProtocol {
        
        let trip = trips.value[indexPath.row]
        if isShowFull.count != trips.value.count {
        isShowFull = Array(repeating: false, count: trips.value.count)
        } 
        let isFullData = isShowFull[indexPath.row]
        return HistoryViewModelCell(trip: trip, tag: indexPath.row, delegate: self, fullData: isFullData)
    }
    
    
    func actionTripPressed(trip: Trip, tag: Int, action: ActionTrip) {
        
        switch action {
        case .edit:
            editTripDelegate?.editTrip(trip: trip, tag: tag)
            //TO DO
            // send trip to back-end
        case .cancel:
            trips.value[tag] = trip
            guard var user = UserStore.shared.getUser() else { return }
            user.trips[tag] = trip
            UserStore.shared.save(user: user)
            //TO DO
            // send trip to back-end
        case .review:
            let reviewViewModel = reviewViewModel(atSelectRow: tag)
            reviewDelegate?.leaveReview(viewModel: reviewViewModel)
            
            //TO DO
            // send trip to back-end
            
        case .reserv:
            guard var user = UserStore.shared.getUser() else { return }
            trips.value[tag].tripStait = .reserved
            user.trips = trips.value
            UserStore.shared.save(user: user)
        }
        
        
    }
    
    func reviewViewModel(atSelectRow selectRow: Int) -> ReviewDriverViewModelProtocol {
        let trip = trips.value[selectRow]
        return ReviewDriverViewModel(trip: trip, tripSelect: selectRow)
    }
    
    
}


