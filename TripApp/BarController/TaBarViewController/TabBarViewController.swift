//
//  TabBarViewController.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = mainColor
        tabBar.barStyle = .black
        tabBar.unselectedItemTintColor = .lightText
    }
    
}
