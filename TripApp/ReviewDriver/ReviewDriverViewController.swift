//
//  ReviewDriverViewController.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import UIKit

class ReviewDriverViewController: UIViewController {

    
    @IBOutlet weak var infoLabelConteinerView: UIView!
    @IBOutlet weak var driverInfoConteinerView: UIView!
    @IBOutlet weak var evaluationDriverConteinerView: UIView!
    @IBOutlet weak var evaluationCarConteinerView: UIView!
    
    
    @IBOutlet weak var leaveReviewDriverButton: UIButton!
    
    // MARK: - life cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }
    

    @IBAction func leaveReviewDriverPressed(_ sender: UIButton) {
    }
    
    private func setupUI() {
        
        view.backgroundColor = mainBackgroundColor
        
    }

}
