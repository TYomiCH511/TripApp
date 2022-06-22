//
//  ComplitionTableViewCell.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import UIKit

class ComplitionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainConteinerView: UIView!
    
    @IBOutlet weak var dataConteinerView: UIView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dateTripLabel: UILabel!
    @IBOutlet weak var reservedTripInDataImageView: UIImageView!
    @IBOutlet weak var reservedInDataLabel: UILabel!
    
    @IBOutlet weak var fullDataTripConteinerView: UIView!
    
    @IBOutlet weak var directionConteinerView: UIView!
    @IBOutlet weak var timeTripLabel: UILabel!
    @IBOutlet weak var startCityLabel: UILabel!
    @IBOutlet weak var startStaitionLabel: UILabel!
    @IBOutlet weak var finalyCityLabel: UILabel!
    @IBOutlet weak var finalyStaitionLabel: UILabel!
    @IBOutlet weak var startCircleView: UIView!
    @IBOutlet weak var finalyStaitionCircleView: UIView!
    @IBOutlet weak var costTripLabel: UILabel!
    @IBOutlet weak var countPassenger: UILabel!
    
    @IBOutlet weak var reservedConteinerView: UIView!
    @IBOutlet weak var reservedLabel: UILabel!
    @IBOutlet weak var reservedImageView: UIImageView!
    
    @IBOutlet weak var leaveReviewButton: UIButton!
    
    @IBOutlet weak var heightFullData: NSLayoutConstraint!
    var viewModel: HistoryViewModelCellProtocol! {
        didSet {
            let dateFormat = CustomDate.shared
            guard let date = viewModel.trip.date else { return }
            dayOfWeekLabel?.text = dateFormat.showDay(from: date)
            dateTripLabel?.text = dateFormat.showDate(from: date)
            timeTripLabel?.text = dateFormat.showTime(from: date)
            startCityLabel?.text = viewModel.trip.startCity
            startStaitionLabel?.text = viewModel.trip.startStaition
            finalyCityLabel?.text = viewModel.trip.finishCity
            finalyStaitionLabel?.text = viewModel.trip.finishStaition
            countPassenger?.text = String(viewModel.trip.countPasseger!)
            costTripLabel?.text = "Итого: " + String(viewModel.trip.countPasseger! * costTrip) + " руб"
            
            mainConteinerView.backgroundColor = .lightGray

            setupReservedTrip(with: "Поездка завершена", color: .lightGray, image: "flag.circle.fill")
            
            if !viewModel.fullData {
                dataConteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                heightFullData.constant = 0
                fullDataTripConteinerView.isHidden = true
            } else {
                heightFullData.constant = 508
                fullDataTripConteinerView.isHidden = false
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        selectionStyle = .none
        
    }
    
    @IBAction func leaveReviewPressed(_ sender: UIButton) {
        viewModel.reviewTrip()
    }
    
   
    private func setupUI() {
        leaveReviewButton.grayButton(with: "Оставить отзыв", isEnable: true)
        leaveReviewButton.backgroundColor = .white
        leaveReviewButton.setTitleColor(.systemBrown, for: .normal)
        reservedConteinerView.backgroundColor = .clear
        fullDataTripConteinerView.backgroundColor = .clear
        backgroundColor = .darkGray
        directionConteinerView.backgroundColor = .white
        mainConteinerView.layer.cornerRadius = 8
        dataConteinerView.layer.cornerRadius = 8
        dataConteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        directionConteinerView.layer.cornerRadius = 8
        directionConteinerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        startCircleView.layer.cornerRadius = startCircleView.frame.height / 2
        finalyStaitionCircleView.layer.cornerRadius = finalyStaitionCircleView.frame.height / 2
        
        dayOfWeekLabel.textColor = .gray
        dayOfWeekLabel.font = .systemFont(ofSize: 19, weight: .semibold)
        reservedLabel.font = .systemFont(ofSize: 19, weight: .semibold)
        reservedInDataLabel.font = .systemFont(ofSize: 19, weight: .semibold)
        dateTripLabel.textColor = .systemBlue
        dateTripLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        timeTripLabel.textColor = .black
        startCityLabel.textColor = .black
        startCityLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        finalyCityLabel.textColor = .black
        finalyCityLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        startStaitionLabel.textColor = .gray
        finalyStaitionLabel.textColor = .gray
        costTripLabel.textColor = .black
        countPassenger.textColor = .black
        
        
    }
    
    
    private func setupReservedTrip(with text: String, color: UIColor, image: String) {
        reservedInDataLabel?.text = text
        reservedInDataLabel?.textColor = color
        reservedTripInDataImageView?.tintColor = color
        reservedTripInDataImageView?.backgroundColor = .white
        reservedLabel?.text = text
        reservedLabel?.textColor = .white
        reservedImageView?.tintColor = .white
        reservedImageView?.backgroundColor = color
        reservedTripInDataImageView?.image = UIImage(systemName: image)
        reservedImageView?.image = UIImage(systemName: image)
    }
    
    
}
