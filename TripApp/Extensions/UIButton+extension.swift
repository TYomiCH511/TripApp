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
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.6
        layer.shadowColor = backgroundColor?.cgColor
        
    }
}
