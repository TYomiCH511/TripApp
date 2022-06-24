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
        
        var email = ""
        var phone = ""
        if isTested {
            //For test
            email = "+1650555\(phoneNumber)@gmail.com"
            phone = "+1650555\(phoneNumber)"
        } else {
            //For real phone
            email = "+375\(phoneNumber)@gmail.com"
            phone = "+375\(phoneNumber)"
        }
        
        AuthManager.shared.checkUserInDataBase(withEmail: email, phoneNumber: phone) { success in
            guard success else {
                complition(false)
                return }
            complition(true)
            
        }
    }
}
