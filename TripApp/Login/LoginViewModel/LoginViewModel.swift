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
    func login(with phoneNumber: String, password: String, complition: @escaping () -> ())
    func resetPassword(withPhone phoneNumber: String, complition: @escaping () -> ())
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
    
    func login(with phoneNumber: String, password: String, complition: @escaping () -> ()) {
        var email = ""
        if isTested {
            //For text
            email = "+1650555\(phoneNumber)@gmail.com"
        } else {
            // For real phone
            email = "+375\(phoneNumber)@gmail.com"
        }
           
        AuthManager.shared.singin(withEmail: email, password: password) { success in
            guard success else { return }
            complition()
        }
        
    }
    
    
    func resetPassword(withPhone phoneNumber: String, complition: @escaping () -> ()) {
        var phone = ""
        if isTested {
            //For text
            phone = "+1650555\(phoneNumber)"
        } else {
            // For real phone
            phone = "+375\(phoneNumber)"
        }
        
        AuthManager.shared.startAuth(phoneNumber: phone) { success in
            guard success else { return }
            complition()
        }
    }
    
}
