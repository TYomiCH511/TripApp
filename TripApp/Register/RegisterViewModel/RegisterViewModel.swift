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
                      password: String,
                      complition: @escaping (Bool) -> ())
}


class RegisterViewModel: RegisterViewModelProtocol {
    
    
    func registerUser(with surname: String,
                      name: String,
                      phoneNumber: String,
                      password: String,
                      complition: @escaping (Bool) -> ()) {
        
        //For test
        let email = "+1650555\(phoneNumber)@gmail.com"
        let phoneNumber = "+1650555\(phoneNumber)"
        //For real phone
        //let email = "+375\(phoneNumber)@gmail.com"
        //let number = "+375\(numberString)"
        AuthManager.shared.checkUserInDataBase(withEmail: email, phoneNumber: phoneNumber) { success in
            guard success else {
                complition(false)
                return }
            complition(true)
            
        }
    }
}
