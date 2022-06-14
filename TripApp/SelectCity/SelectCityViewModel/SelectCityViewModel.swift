//
//  SelectorViewModel.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import Foundation


protocol SelectCityViewModelProtocol {
    var cities: [City] { get }
    init(cities: [City])
    func numberOfRows() -> Int
}



class SelectCityViewModel: SelectCityViewModelProtocol {
    var cities: [City]
    
    
    required init(cities: [City]) {
        self.cities = cities
        
    }
    
    func numberOfRows() -> Int {
        return cities.count
    }
    
}
