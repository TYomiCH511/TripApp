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
            if viewModel.secondaryText == "" {
                secondaryTextLabel.font = .systemFont(ofSize: 1, weight: .thin)
            } else {
                secondaryTextLabel.font = .systemFont(ofSize: 16, weight: .medium)
                backgroundColor = .gray
                conteinerView.backgroundColor = backgroundColor
            }
            if mainTextLabel.text == "1" || mainTextLabel.text == "2" || mainTextLabel.text == "3" {
                backgroundColor = .gray
                conteinerView.backgroundColor = backgroundColor
            }
            
            secondaryTextLabel.text = viewModel.secondaryText
            let image = UIImage(systemName: viewModel.imageName)
            infoImageView.image = image
        }
    }
    
    override func prepareForReuse() {
        backgroundColor = mainBackgroundColor
        conteinerView.backgroundColor = backgroundColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = mainBackgroundColor
        conteinerView.backgroundColor = mainBackgroundColor
        infoImageView.tintColor = mainColor
        selectionStyle = .none
        mainTextLabel.textColor = .white
        mainTextLabel.font = .systemFont(ofSize: 22, weight: .medium)
        secondaryTextLabel.textColor = .lightText
        
    }

    
}
