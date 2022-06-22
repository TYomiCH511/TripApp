//
//  UIView+extension.swift
//  TripApp
//
//  Created by Artem on 20.06.22.
//

import Foundation
import UIKit


extension UIView {
    
    func addShadowOnView() {
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.8
        layer.rasterizationScale = 0.1
        layer.shadowColor = CGColor.init(srgbRed: 1, green: 1, blue: 1, alpha: 0.4)
    }

}
