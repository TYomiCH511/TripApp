//
//  User.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation
import FirebaseFirestore


struct User: Codable {
    var name: String?
    var surname: String?
    var email: String?
    let phoneNumber: String?
    var password: String?
    
    
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["name"] = self.name
        repres["surname"] = self.surname
        repres["email"] = self.email
        repres["phoneNumber"] = self.phoneNumber
        repres["password"] = self.password
        
        return repres
    }
    
    init(name: String, surname: String, email: String?,
         phoneNumber: String, password: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
    }
    
    init?(userdData: DocumentSnapshot) {
        
        let data = userdData.data()
        
        guard let name = data?["name"] as? String else { return nil }
        guard let surname = data?["surname"] as? String else { return nil }
        guard let email = data?["email"] as? String else { return nil }
        guard let phoneNumber = data?["phoneNumber"] as? String else { return nil }
        guard let password = data?["password"] as? String else { return nil }
        
        self.name = name
        self.surname = surname
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
    }
    
    

}
