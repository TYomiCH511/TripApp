//
//  OrderViewController.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import UIKit

class OrderViewController: UIViewController {

    var viewModel: OrderViewModelProtocol! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OrderViewmodel()
        
    }
    

    
}
