//
//  OrderDoneViewModel.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import Foundation


protocol OrderDoneViewModelProtocol {
    var trip: Trip { get }
    init(trip: Trip)
}


class OrderDoneViewModel: OrderDoneViewModelProtocol {
    
    var trip: Trip
    
    required init(trip: Trip) {
        self.trip = trip
    }
    
    
}
