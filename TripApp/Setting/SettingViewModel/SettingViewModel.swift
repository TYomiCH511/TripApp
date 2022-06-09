//
//  SettingViewModel.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

protocol SettingViewModelProtocol {
    var user: User? { get }
    
}


class SettingViewModel: SettingViewModelProtocol {
    var user: User? {
        return UserStore.shared.getUser()
    }
    
    
    

    
}
