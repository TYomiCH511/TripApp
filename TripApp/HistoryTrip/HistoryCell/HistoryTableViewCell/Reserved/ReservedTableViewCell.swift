//
//  ReservedTableViewCell.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import UIKit

class ReservedTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var mainConteinerView: UIView!
    @IBOutlet weak var DataConteinerView: UIView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dateTripLabel: UILabel!
    
    @IBOutlet weak var reservedTripInDataImageView: UIImageView!
    
    @IBOutlet weak var fullDataTripConteinerView: UIView!
    @IBOutlet weak var directionConteinerView: UIView!
    @IBOutlet weak var reservedInDataLabel: UILabel!
    @IBOutlet weak var timeTripLabel: UILabel!
    @IBOutlet weak var startCityLabel: UILabel!
    @IBOutlet weak var startStaitionLabel: UILabel!
    @IBOutlet weak var finalyCityLabel: UILabel!
    @IBOutlet weak var finalyStaitionLabel: UILabel!
    @IBOutlet weak var costTripLabel: UILabel!
    @IBOutlet weak var countPassenger: UILabel!
    
    @IBOutlet weak var reservedLabel: UILabel!
    @IBOutlet weak var reservedImageView: UIImageView!
    
    @IBOutlet weak var reminderLabel: UILabel!
    
    
    @IBOutlet weak var editTripButton: UIButton!
    @IBOutlet weak var cancelTripButton: UIButton!
    
    @IBOutlet weak var startCircleView: UIView!
    @IBOutlet weak var finalyStaitionCircleView: UIView!
    @IBOutlet weak var infoAndButtonView: UIView!
    
    //Driver and car IBOutlets
    @IBOutlet weak var driverConteinerView: UIView!
    @IBOutlet weak var modelOfCarLabel: UILabel!
    @IBOutlet weak var colorOfCarLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberDriverLabel: UILabel!
    @IBOutlet weak var raitingOfDriverLabel: UILabel!
    
    var viewModel: HistoryViewModelCellProtocol! {
        didSet {
            let dateFormat = CustomDate.shared
            guard let date = viewModel.trip.date else { return }
            dayOfWeekLabel?.text = dateFormat.showDay(from: date)
            dateTripLabel.text = dateFormat.showDate(from: date)
            timeTripLabel.text = dateFormat.showTime(from: date)
            startCityLabel.text = viewModel.trip.startCity
            startStaitionLabel.text = viewModel.trip.startStaition
            finalyCityLabel.text = viewModel.trip.finishCity
            finalyStaitionLabel.text = viewModel.trip.finishStaition
            countPassenger.text = String(viewModel.trip.countPasseger!)
            costTripLabel.text = "Итого: " + String(viewModel.trip.countPasseger! * costTrip) + " руб"
            
            //setup driver
            if let driver = viewModel.trip.driver {
                modelOfCarLabel?.text = "Модель автобуса: " + driver.carModel
                colorOfCarLabel?.text = "Цвет автобуса: " + driver.carColor
                carNumberLabel?.text = "Номер автобуса: " + driver.carNumber
                phoneNumberDriverLabel?.text = "Телефон водителя: " + driver.phoneNumber
                raitingOfDriverLabel?.text = "Рейтинг водителя: " + driver.raiting + " ⭐️"
            }
            mainConteinerView.backgroundColor = .systemGreen
            
            reminderLabel?.text = ""
            setupReservedTrip(with: "Бронь подтверждена", color: .systemGreen, image: "checkmark.circle.fill")
            
        }
    }
    
    
    var isShowFull = false {
        willSet {
            if newValue {
                infoAndButtonView.removeFromSuperview()
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        selectionStyle = .none
        
    }
    
    @IBAction func editTripButtonPressed(_ sender: UIButton) {
        viewModel.editTrip()
        
    }
    
    @IBAction func cancelTripButtonPressed(_ sender: UIButton) {
        viewModel.cancelTrip()
    }
    
    
    private func setupUI() {
        driverConteinerView.backgroundColor = .clear
        fullDataTripConteinerView.backgroundColor = .clear
        backgroundColor = .darkGray
        directionConteinerView.backgroundColor = .white
        infoAndButtonView.backgroundColor = .clear
        mainConteinerView.layer.cornerRadius = 8
        DataConteinerView.layer.cornerRadius = 8
        startCircleView.layer.cornerRadius = startCircleView.frame.height / 2
        finalyStaitionCircleView.layer.cornerRadius = finalyStaitionCircleView.frame.height / 2
        
        dayOfWeekLabel?.textColor = .gray
        
        dateTripLabel.textColor = .systemBlue
        dateTripLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        timeTripLabel.textColor = .black
        startCityLabel.textColor = .black
        startCityLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        finalyCityLabel.textColor = .black
        finalyCityLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        startStaitionLabel.textColor = .gray
        finalyStaitionLabel.textColor = .gray
        
        reminderLabel.textColor = .black
        costTripLabel.textColor = .black
        countPassenger.textColor = .black
        
        editTripButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        cancelTripButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        
        
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