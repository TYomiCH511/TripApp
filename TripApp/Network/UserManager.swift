//
//  UserManager.swift
//  TripApp
//
//  Created by Artem on 25.06.22.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class UserManager {
    
    static let shared = UserManager()
    private init() {}
    private let db = Firestore.firestore()
    
    private let collection = "users"
    
    func getUserData(complition: @escaping (User1?) -> ()) {
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let userData = db.collection("users").document(uid)
        var user: User1?
        
        userData.getDocument { document, error in
            guard error == nil else { return }
            
            user = User1(name: document?.get("name") as? String ?? "",
                         surname: document?.get("surname") as? String ?? "",
                         phoneNumber: "",
                         password: document?.get("password") as? String ?? "",
                         email: document?.get("email") as? String ?? "")
            
            complition(user)
        }
        
    }
    
    
    func updateUserData(user: User1) {
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let data: [String: Any] = ["name": user.name,
                                   "surname": user.surname,
                                   "email": user.email ?? "",
        ]
        db.collection(collection).document(uid).setData(data, merge: true)
        
    }
    
    func updatePassword(password: String,
                        complition: @escaping (Bool) -> ()) {
        let currenUser = Auth.auth().currentUser
        currenUser?.updatePassword(to: password) { error in
            guard error == nil else {
                complition(false)
                return }
            
            guard let uid = currenUser?.uid else { return }
            let password: [String: Any] = ["password": password]
            self.db.collection(self.collection).document(uid).setData(password, merge: true)
            complition(true)
        }
    }
}
