//
//  LoginViewModel.swift
//  TripApp
//
//  Created by Artem on 8.06.22.
//

import Foundation

// MARK: - LoginViewModelProcol
protocol LoginViewModelProcol: AnyObject {
    
    var autoLogin: Bool { get }
    
    func login(with phoneNumber: String, password: String) -> Bool
    func fetchUser(phoneNumber: String, password: String, complition: @escaping (User) -> ())
}

// MARK: - LoginViewModel class
class LoginViewModel: LoginViewModelProcol {
       
    
    //Property
    var autoLogin: Bool = false
    private var user: User?
    
    //Functions
    func setAutoLogin() {
        autoLogin.toggle()
    }
    
    func login(with phoneNumber: String, password: String) -> Bool {
        if phoneNumber == user?.phoneNumber && password == user?.password {
            return true
        }
        return false
    }
    
    func fetchUser(phoneNumber: String, password: String, complition: @escaping (User) -> ()) {
        guard let user = StorageManeger.shared.getUser(phoneNumber: phoneNumber) else { return }
        self.user = user
        if login(with: phoneNumber, password: password) {
            complition(user)
        } else {
            print("Password nor correct")
        }
       
    }
}
