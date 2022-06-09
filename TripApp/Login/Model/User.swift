//
//  User.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

struct User {
    let name: String?
    let surname: String
    let phoneNumber: String
    let email: String?
    let password: String
    let trips: [Trip]
}


