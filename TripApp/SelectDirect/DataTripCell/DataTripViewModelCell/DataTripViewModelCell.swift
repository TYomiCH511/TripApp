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
    var imageName: String { get }
    init(mainText: String? , secondaryText: String?, imageName: String)
}


class DataTripViewModel: DataTripViewModelProtocol {
    var mainText: String?
    
    var secondaryText: String?
    var imageName: String
    required init(mainText: String?, secondaryText: String?, imageName: String) {
        self.mainText = mainText
        self.secondaryText = secondaryText
        self.imageName = imageName
    }
    
    
    
    
}
