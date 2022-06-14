//
//  SelecStaitionViewModel.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import Foundation

protocol SelectStaitionViewModelProtocol {
    var staition: [String] { get }
    init(staition: [String])
    func numberOfRow() -> Int
}


class SelectStaitionViewModel: SelectStaitionViewModelProtocol {
    var staition: [String]
    
    required init(staition: [String]) {
        self.staition = staition
    }
    
    func numberOfRow() -> Int {
        staition.count
    }
    
    
}
