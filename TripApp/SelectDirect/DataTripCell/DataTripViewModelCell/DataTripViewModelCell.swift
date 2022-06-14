//
//  DataTripViewModelCell.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import Foundation


protocol DataTripViewModelProtocol {
    var mainText: String? { get }
    var secondaryText: String? { get }
    init(mainText: String? , secondaryText: String?)
}


class DataTripViewModel: DataTripViewModelProtocol {
    var mainText: String?
    
    var secondaryText: String?
    
    required init(mainText: String?, secondaryText: String?) {
        self.mainText = mainText
        self.secondaryText = secondaryText
    }
    
    
    
    
}
