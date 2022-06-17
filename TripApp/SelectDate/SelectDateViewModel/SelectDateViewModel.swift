//
//  SelectDateViewModel.swift
//  TripApp
//
//  Created by Artem on 15.06.22.
//

import Foundation


protocol SelectDateViewModelProtocol {
    var times: [Time] { get set }
    func numberOfItem() -> Int
    func viewModelTimeCell(at indexPath: IndexPath) -> TimeViewModelProtocol
    func dateTrip(date: Date, indexPath: IndexPath) -> Date
}




class SelectDateViewmodel: SelectDateViewModelProtocol {
    
    var times: [Time]  = TimeStore.shared.getTime()
    
    
    func viewModelTimeCell(at indexPath: IndexPath) -> TimeViewModelProtocol {
        
        let time = times[indexPath.item]
        
        return TimeViewModel(time: time)
    }
    
    func numberOfItem() -> Int {
        return times.count
    }
    
    
    func dateTrip(date: Date, indexPath: IndexPath) -> Date {
        let timeTrip = times[indexPath.row].hour + ":00 "
        let date = CustomDate.shared.orderDateTrip(dateTrip: date, timeTrip: timeTrip)
        return date
    }
    
    
}
