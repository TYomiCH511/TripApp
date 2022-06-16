//
//  RegisterViewModel.swift
//  TripApp
//
//  Created by Artem on 16.06.22.
//

import Foundation


protocol RegisterViewModelProtocol {
    func registerUser(with surname: String,
                      name: String,
                      phoneNumber: String,
                      password: String)
}


class RegisterViewModel: RegisterViewModelProtocol {
    
    
    func registerUser(with surname: String,
                      name: String,
                      phoneNumber: String,
                      password: String) {
        
        let user = User(name: name,
                        surname: surname,
                        phoneNumber: phoneNumber,
                        password: password,
                        trips: []
        )
        
        UserStore.shared.addNewUser(user)
    }
}
