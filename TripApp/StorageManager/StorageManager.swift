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
    lazy private var users = [
        User(name: "Artem", surname: "Timankov",
             phoneNumber: "5115711", email: nil,
             password: "5115711", trips: trips),
        
        User(name: "Kolya", surname: "Pupkin",
             phoneNumber: "1111111", email: nil,
             password: "1111111", trips: trips),
    ]
    
    var trips = [
        
        Trip(date: Date(), startCity: "Минск", startStaition: "ЖД вокзал",
             finishCity: "Новополоцк", finishStaition: "Кинотеатр Минск",
             tripStait: .cancel, countPasseger: 1,
             driver: Driver(carModel: "Mercedes Sprinter", carColor: "Белый", carNumber: "8888-2",
                            phoneNumber: "+375 29 566 47 58", raiting: "4.84")),
        
        Trip(date: Date(), startCity: "Полоцк", startStaition: "ЖД вокзал",
             finishCity: "Минск", finishStaition: "ЭкспоБел",
             tripStait: .notReserved, countPasseger: 2, driver:
                Driver(carModel: "Mercedes Sprinter", carColor: "Белый", carNumber: "8888-2",
                       phoneNumber: "+375 29 566 47 58", raiting: "4.84")),
        
        Trip(date: Date(), startCity: "Полоцк", startStaition: "ЖД вокзал",
             finishCity: "Минск", finishStaition: "ЭкспоБел",
             tripStait: .reserved, countPasseger: 1,
             driver: Driver(carModel: "Mercedes Sprinter", carColor: "Белый", carNumber: "8888-2",
                            phoneNumber: "+375 29 566 47 58", raiting: "4.84")),
        
        Trip(date: Date(), startCity: "Полоцк", startStaition: "ЖД вокзал",
             finishCity: "Минск", finishStaition: "ЭкспоБел",
             tripStait: .complition, countPasseger: 3,
             driver: Driver(carModel: "Mercedes Sprinter", carColor: "Белый", carNumber: "8888-2",
                            phoneNumber: "+375 29 566 47 58", raiting: "4.84")),
        
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
