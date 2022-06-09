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
