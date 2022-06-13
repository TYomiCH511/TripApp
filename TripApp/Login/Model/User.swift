//
//  User.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

struct User: Codable {
    var name: String
    var surname: String
    let phoneNumber: String
    var email: String?
    var password: String
    var trips: [Trip]
}


