//
//  TimeCollectionViewCell.swift
//  TripApp
//
//  Created by Artem on 15.06.22.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    var viewModel: TimeViewModelProtocol! {
        didSet {
            timeLabel.text = viewModel.getInfoPerHour()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .darkGray
        
    }

}
