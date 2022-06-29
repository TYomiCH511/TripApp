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
    
    func getUserData(complition: @escaping (User) -> ()) {
        let currenUser = Auth.auth().currentUser
        guard let uid = currenUser?.uid else { return }
        let userData = db.collection("users").document(uid)
        
        
        userData.getDocument { userData, error in
            guard let userData = userData, error == nil else { return }
            guard let user = User(userdData: userData) else { return }
            complition(user)
        }
        
    }
    
    
    func updateUserData(user: User) {
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
