//
//  AuthManager.swift
//  TripApp
//
//  Created by Artem on 22.06.22.
//
import FirebaseAuth
import Foundation



class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    private let auth = Auth.auth()
    private var verificationId: String?
    
    public func startAuth(phoneNumber: String, complition: @escaping (Bool) -> ()) {
        PhoneAuthProvider
            .provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
                guard let verificationId = verificationId, error == nil else {
                    complition(false)
                    return
                }
                self?.verificationId = verificationId
                complition(true)
            }
    }
    
    public func verifyCode(smsCode: String,
                           phoneNumber: String,
                           password: String,
                           complition: @escaping (Bool) -> ()) {
        
        guard let verifyId = verificationId else {
            complition(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyId,
                                                                 verificationCode: smsCode)
        
        auth.signIn(with: credential) { result, error in
            guard let result = result, error == nil else {
                complition(false)
                return
            }
            complition(true)
            let credentialEmail = EmailAuthProvider.credential(withEmail: "+375\(phoneNumber)@gmail.com", password: password)
            result.user.link(with: credentialEmail) { result, error in
                guard let result = result, error == nil else {
                    print(error!)
                    return }
            }
        }
    }
    
    
    public func singin(withEmail email: String, password: String, complition: @escaping (Bool) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result, error == nil else {
                complition(false)
                return
            }
            print(result)
            complition(true)
        }
    }
    
    public func singout(complition: @escaping (Bool) -> ()) {
        do {
            try? auth.signOut()
            complition(true)
        } catch let error {
            complition(false)
            print(error)
        }
        
    }
}
