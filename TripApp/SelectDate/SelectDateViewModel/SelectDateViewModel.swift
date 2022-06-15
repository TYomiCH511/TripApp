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
    
    
}
