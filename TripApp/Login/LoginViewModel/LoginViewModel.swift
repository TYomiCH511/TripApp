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
    //func login(with phoneNumber: String, password: String) -> Bool
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
    
    func login(with phoneNumber: String, password: String) -> Bool {
        if phoneNumber == user?.phoneNumber && password == user?.password {
            return true
        } else {
            print("11111")
        }
        return false
    }
    
    func fetchUser(phoneNumber: String, password: String, complition: @escaping (User) -> ()) {
        guard let user = StorageManeger.shared.getUser(phoneNumber: phoneNumber) else {
            delegate?.showAlertLoginWrong()
            return
        }
        self.user = user
        if login(with: phoneNumber, password: password) {
            complition(user)
        } else {
            print("Password nor correct")
        }
       
    }
    
    func saveUser() {
        guard let user = user else { return }
        UserStore.shared.save(user: user)
    }
    
    
}
