//
//  HistoryTableViewCell.swift
//  TripApp
//
//  Created by Artem on 10.06.22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dateTripLabel: UILabel!
    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var timeTripLabel: UILabel!
    @IBOutlet weak var startCityLabel: UILabel!
    @IBOutlet weak var startStaitionLabel: UILabel!
    @IBOutlet weak var finalyCityLabel: UILabel!
    @IBOutlet weak var finalyStaitionLabel: UILabel!
    @IBOutlet weak var costTripLabel: UILabel!
    @IBOutlet weak var countPassenger: UILabel!
    @IBOutlet weak var reservedLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    
    @IBOutlet weak var editTripButton: UIButton!
    @IBOutlet weak var cancelTripButton: UIButton!
    
    @IBOutlet weak var startCircleView: UIView!
    @IBOutlet weak var finalyStaitionCircleView: UIView!
    
    
    private var viewModel: HistoryTripViewModelProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func editTripButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func cancelTripButtonPressed(_ sender: UIButton) {
    }
    
}
