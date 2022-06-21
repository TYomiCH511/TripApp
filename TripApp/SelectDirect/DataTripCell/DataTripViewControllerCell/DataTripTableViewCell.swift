//
//  DataTripTableViewCell.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import UIKit

class DataTripTableViewCell: UITableViewCell {

    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var secondaryTextLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    
    var viewModel: DataTripViewModelProtocol! {
        didSet {
            mainTextLabel.text = viewModel.mainText
            secondaryTextLabel.text = viewModel.secondaryText
            let image = UIImage(systemName: viewModel.imageName)
            infoImageView.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = mainBackgroundColor
        conteinerView.backgroundColor = mainBackgroundColor
        selectionStyle = .none
        mainTextLabel.textColor = .white
        secondaryTextLabel.textColor = .white
    }

    
}
