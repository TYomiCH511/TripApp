//
//  StorageManager.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation


class StorageManeger {
    static let shared = StorageManeger()
    private init() {}
    private var users = [
        User(name: "Artem", surname: "Timankov",
             phoneNumber: "5115711", email: nil,
             password: "5115711", trips: [
                Trip(date: "\(Date())")
        ]),
        
        User(name: "Kolya", surname: "Pupkin",
             phoneNumber: "1111111", email: nil,
             password: "1111111", trips: [
                Trip(date: "\(Date())")
        ]),
    ]
    
    
    func getUser(phoneNumber: String) -> User? {
        var user1: User?
        users.forEach { user in
            if user.phoneNumber.contains(phoneNumber) {
                user1 = user
                return
            }
        }
        return user1
    }
}


class UserStore {
    private let defaults = UserDefaults.standard
    static let shared = UserStore()
    let currentUser = "user"
    private init() {}
    
    func save(user: User) {
        guard let user = try? JSONEncoder().encode(user) else { return }
            defaults.set(user, forKey: currentUser)
        print("Save current user")
    
    }
    
    func getUser() -> User? {
        
        guard let userData = defaults.value(forKey: currentUser) as? Data else { return nil }
        let user = try? JSONDecoder().decode(User.self, from: userData)
        print("Get current user")
        return user
    }
    
    
    
    func deleteUser() {
        defaults.removeObject(forKey: currentUser)
    }
}
