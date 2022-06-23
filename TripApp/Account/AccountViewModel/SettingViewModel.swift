//
//  SettingViewModel.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

protocol AccountViewModelProtocol {
    
    var user: User? { get }
    func logout(complition: @escaping () -> ())
    func saveChanges(name: String, surname: String, email: String?)
    func changePassword(current: String, new: String, confirm: String) -> Bool
    
}


class SettingViewModel: AccountViewModelProtocol {
    
    var user: User? = UserStore.shared.getUser()
    
    
    func logout(complition: @escaping () -> ()) {
        
        AuthManager.shared.singout {
            complition()
        }
        
    }
    
    func saveChanges(name: String, surname: String, email: String?) {
        guard var user = user else { return }
        
        if user.name != name || user.surname != surname || user.email != email  {
            user.name = name
            user.surname = surname
            user.email = email
            UserStore.shared.save(user: user)
            self.user = user
            
            // post to back-end changes
        } else {
            print("equal dont save")
        }
        
    }
    
    func changePassword(current: String, new: String, confirm: String) -> Bool {
        if current != "" {
            if user?.password == current && new == confirm {
                guard var user = user else { return false }
                user.password = new
                UserStore.shared.save(user: user)
                self.user = user
                
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
