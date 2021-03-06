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
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.6
        layer.shadowColor = backgroundColor?.cgColor
        
    }
    
    func mainActionButton(with title: String, isEnable: Bool, color: UIColor = mainColor, fontColor: UIColor = .white, sizeFont: CGFloat = 22) {
        backgroundColor = color
        setTitle(title, for: .normal)
        layer.cornerRadius = cornerRadiusButton
        titleLabel?.font = .systemFont(ofSize: sizeFont, weight: .semibold)
        tintColor = fontColor
        self.addShadow()
        isEnabled = isEnable
    }
    
    func grayButton(with title: String, isEnable: Bool, sizeFont: CGFloat = 20) {
        backgroundColor = .lightGray
        setTitle(title, for: .normal)
        layer.cornerRadius = cornerRadiusButton
        titleLabel?.font = .systemFont(ofSize: sizeFont, weight: .semibold)
        tintColor = .white
        self.addShadow()
        isEnabled = isEnable
    }
    
    func clearBackgroundButton(with title: String) {
        backgroundColor = .clear
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        tintColor = mainColor
    }
    
    
}
