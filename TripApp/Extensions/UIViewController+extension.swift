//
//  UIViewController+extension.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation
import UIKit


extension UIViewController {
    func onMain(block: @escaping () -> ()) {
        if Thread.current == Thread.main {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
