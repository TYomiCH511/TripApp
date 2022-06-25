//
//  SettingViewModel.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

enum StaitPassword {
    case success
    case wrongCurrent
    case notEqualNew
}



protocol AccountViewModelProtocol {
    
    var user: Bindable<User1> { get set }
    func getUser()
    func logout(complition: @escaping () -> ())
    func saveChanges(name: String, surname: String, email: String?)
    func changePassword(current: String,
                        newPassword: String,
                        confirmPassword: String,
                        complition: @escaping (StaitPassword) -> ())
    
}


class SettingViewModel: AccountViewModelProtocol {
    
    
    
    var user: Bindable<User1> = Bindable<User1>(User1(name: "",
                                                      surname: "",
                                                      phoneNumber: "",
                                                      password: "",
                                                      email: ""))
    
    func getUser() {
        UserManager.shared.getUserData { user in
            guard let user = user else { return }
            self.user.value = user
        }
    }
    
    
    func saveChanges(name: String, surname: String, email: String?) {
        
        if user.value.name != name || user.value.surname != surname || user.value.email != email  {
            user.value.name = name
            user.value.surname = surname
            user.value.email = email
            UserManager.shared.updateUserData(user: user.value)
        }
    }
    
    func changePassword(current: String,
                        newPassword: String,
                        confirmPassword: String,
                        complition: @escaping (StaitPassword) -> ()) {
        
        if user.value.password == current {
            
            if newPassword == confirmPassword && newPassword.count > 5  {
                
                UserManager.shared.updatePassword(password: newPassword) { [weak self] success in
                    guard success else { return }
                    self?.user.value.password = newPassword
                    complition(.success)
                }
                
            } else {
                complition(.notEqualNew)
            }
            
            
        } else {
            complition(.wrongCurrent)
        }
    }
    
    func logout(complition: @escaping () -> ()) {
        AuthManager.shared.singout {
            complition()
        }
    }
    
}
