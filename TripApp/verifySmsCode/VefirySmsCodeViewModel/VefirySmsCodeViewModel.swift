//
//  VefirySmsCodeViewModel.swift
//  TripApp
//
//  Created by Artem on 22.06.22.
//

import Foundation

protocol VerifySmsCodeViewModelProtocol {
    func newPassword(newPassword: String, confirmPassword: String, complition: @escaping () -> ())
}


class VerifySmsCodeViewModel: VerifySmsCodeViewModelProtocol {
    
    
    func newPassword(newPassword: String, confirmPassword: String, complition: @escaping () -> ()) {
        
        if newPassword == confirmPassword {
            AuthManager.shared.newPassword(password: newPassword) { success in 
                guard success else { return }
                complition()
            }
        } else {
            print("not equal password")
        }
        
    }
}
