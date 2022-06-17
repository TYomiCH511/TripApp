//
//  UITextField+extension.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import Foundation
import UIKit


extension UITextField {
    
    func customConfigure(with placeHolder: String, returnKey: UIReturnKeyType) {
        textColor = .black
        backgroundColor = .white
        self.font = .systemFont(ofSize: 17, weight: .light)
        returnKeyType = returnKey
        self.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
    }
}
