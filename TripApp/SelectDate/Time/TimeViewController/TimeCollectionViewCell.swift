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
            if viewModel.time.countPassager == 0 {
                timeLabel.textColor = .lightGray
                self.isSelected = true
            }
        }
    }
    
    override func prepareForReuse() {
        timeLabel.textColor = .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .darkGray
        
    }

}
