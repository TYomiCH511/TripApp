//
//  LoginViewModel.swift
//  TripApp
//
//  Created by Artem on 8.06.22.
//

import Foundation
import UIKit

// MARK: - LoginViewModelProcol
protocol LoginViewModelProcol: AnyObject {
    
    var autoLogin: Bool { get }
    var delegate: AlertLoginProtocol? { get set }
    func login(with phoneNumber: String, password: String, complition: @escaping (Bool) -> ())
    func fetchUser(phoneNumber: String, password: String, complition: @escaping (User) -> ())
    func saveUser()
}

protocol AlertLoginProtocol: AnyObject {
    func showAlertLoginWrong()
}

// MARK: - LoginViewModel class
class LoginViewModel: LoginViewModelProcol {
       
    
    //Property
    var autoLogin: Bool = false
    private var user: User?
    weak var delegate: AlertLoginProtocol?
    
    //Functions
    func setAutoLogin() {
        autoLogin.toggle()
    }
    
    func login(with phoneNumber: String, password: String, complition: @escaping (Bool) -> ()) {
        let email = "+375\(phoneNumber)@gmail.com"
        AuthManager.shared.singin(withEmail: email, password: password) { success in
            guard success else {
                complition(false)
                return
            }
            complition(true)
        }
        complition(false)
    }
    
    func fetchUser(phoneNumber: String, password: String, complition: @escaping (User) -> ()) {
        
        guard let users = UserStore.shared.getUsers() else { return }
        
        guard let user = StorageManeger.shared.getUser(in: users, phoneNumber: phoneNumber) else {
            delegate?.showAlertLoginWrong()
            return
        }
        self.user = user
        
       
    }
    
    func saveUser() {
        guard let user = user else { return }
        UserStore.shared.save(user: user)
    }
    
    
}
