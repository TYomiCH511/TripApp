//
//  UIButton+extension.swift
//  TripApp
//
//  Created by Artem on 8.06.22.
//

import Foundation
import UIKit


extension UIButton {
    
    func addShadow() {
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.8
        layer.shadowColor = backgroundColor?.cgColor
        
    }
}
