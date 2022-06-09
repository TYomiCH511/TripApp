//
//  SettingViewController.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import UIKit

class SettingViewController: UIViewController {

    var viewModel: SettingViewModelProtocol! {
        didSet {
            print(viewModel.user?.phoneNumber)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingViewModel()
        
    }
    

    
}
