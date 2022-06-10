//
//  Alert.swift
//  TripApp
//
//  Created by Artem on 10.06.22.
//

import Foundation
import UIKit

class Alert {
    
    static let shared = Alert()
    
    private init() {}
    
    func showAlertPhoneNumber() -> UIAlertController {
        let alert = UIAlertController(title: "Support",
                                      message: "You can call us and oedr car",
                                      preferredStyle: .actionSheet)
        
        let phoneNumber = UIAlertAction(title: "+375 29 511 57 11",
                                        style: .default)
        { _ in
            print("call phone number")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(phoneNumber)
        alert.addAction(cancel)
        
        return alert
    }
    
}
