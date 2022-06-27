//
//  AuthManager.swift
//  TripApp
//
//  Created by Artem on 22.06.22.
//
import FirebaseAuth
import Foundation
import FirebaseFirestore
import FirebaseCore

enum StaitSignin {
    case newSignin
    case resetPassword
}

class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    private let auth = Auth.auth()
    private let store = Firestore.firestore()
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
                           user: User1?,
                           typeSingin: StaitSignin,
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
                
                switch typeSingin {
                case .newSignin:
                    guard let phoneNumber = user?.phoneNumber, let password = user?.password else {
                        complition(false)
                        return
                    }
                    var email = ""
                    if isTested {
                        email = "+1650555\(phoneNumber)@gmail.com"
                    } else {
                        email = "+375\(phoneNumber)@gmail.com"
                    }
                    
                    let credentialEmail = EmailAuthProvider.credential(withEmail: email, password: password)
                    result.user.link(with: credentialEmail) { result, error in
                        guard let _ = result, error == nil else {
                            complition(false)
                            print(error?.localizedDescription ?? "Not vefiried")
                            return }
                        
                        guard let userId = self.auth.currentUser?.uid, let user = user else { return }
                        let userData: [String: Any] = ["name": user.name,
                                                       "surname": user.surname,
                                                       "password":user.password,
                                                       "email": user.email ?? "",
                        ]
                        self.store.collection("users").document(userId).setData(userData)
                        complition(true)
                    }
                case .resetPassword:
                    isChangePassword = true
                    print("isChangePassword - \(isChangePassword)")
                    print("user confirm smsCode")
                }
            
        }
    }
    
    
    public func singin(withEmail email: String, password: String, complition: @escaping (Bool) -> ()) {
        auth.signIn(withEmail: email, password: password) { _, error in
            guard error == nil else {
                complition(false)
                return
            }
            complition(true)
        }
    }
    
    public func newPassword(password: String, complition: @escaping (Bool) -> ()) {
        auth.currentUser?.updatePassword(to: password, completion: { error in
            guard error == nil else {
                complition(false)
                return }
            print("password Changed")
            complition(true)
        })
    }
    
    public func changePassword(currentPassword: String, newPassword: String, complition: @escaping (Bool) -> ()) {
        
        auth.currentUser?.updatePassword(to: newPassword, completion: { error in
            guard error == nil else {
                complition(false)
                return }
            self.singout()
            complition(true)
        })
    }
    
    public func checkUserInDataBase(withEmail: String, phoneNumber: String, complition: @escaping (Bool) -> ()) {
        
        auth.signIn(withEmail: withEmail, password: "password") { _, error in
            
            guard let error = error else { return }
            let responseError = error as NSError
            print(responseError.code)
            
            switch responseError.code {
            case AuthErrorCode.wrongPassword.rawValue:
                print("user is alredy in data base")
                complition(false)
            
            default:
                self.startAuth(phoneNumber: phoneNumber) { success in
                    complition(true)
                }
            }
            
            
        }
    }
    
    public func singout(complition: (() -> ())? = nil) {
        do {
            try? auth.signOut()
            complition?()
        } 
        
    }
}
