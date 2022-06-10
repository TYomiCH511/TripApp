//
//  SettingViewModel.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

protocol SettingViewModelProtocol {
    
    var user: User? { get set }
    func logout()
    func saveChanges(name: String, surname: String, email: String?)
    func changePassword(current: String, new: String, confirm: String) -> Bool
    
}


class SettingViewModel: SettingViewModelProtocol {
    
    var user: User? = UserStore.shared.getUser()
    
    func logout() {
        UserStore.shared.deleteUser()
    }
    
    func saveChanges(name: String, surname: String, email: String?) {
        if user?.name == name, user?.surname == surname, user?.email == email {
            user?.name = name
            user?.surname = surname
            user?.email = email
            guard let user = user else { return }
            UserStore.shared.save(user: user)
            
            // post to back-end changes
        }
        
    }
    
    func changePassword(current: String, new: String, confirm: String) -> Bool {
        if current != "" {
            if user?.password == current && new == confirm {
                print("change password")
                return true
            } else {
                print("Not correct current password or confirm password")
                return false
            }
        }
        return false
    }
    
}
