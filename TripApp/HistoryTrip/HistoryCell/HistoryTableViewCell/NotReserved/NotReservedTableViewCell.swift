//
//  HistoryTableViewCell.swift
//  TripApp
//
//  Created by Artem on 10.06.22.
//

import UIKit

class NotReservedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainConteinerView: UIView!
    @IBOutlet weak var dataConteinerView: UIView!
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
    
    @IBOutlet weak var reservTripButton: UIButton!
    @IBOutlet weak var reservedLabel: UILabel!
    @IBOutlet weak var reservedImageView: UIImageView!
    
    @IBOutlet weak var reminderLabel: UILabel!
    
    @IBOutlet weak var editTripButton: UIButton!
    @IBOutlet weak var cancelTripButton: UIButton!
    
    @IBOutlet weak var startCircleView: UIView!
    @IBOutlet weak var finalyStaitionCircleView: UIView!
    @IBOutlet weak var infoAndButtonView: UIView!
    
    @IBOutlet weak var heightFullData: NSLayoutConstraint!
    
    var viewModel: HistoryViewModelCellProtocol! {
        didSet {
            let dateFormat = CustomDate.shared
            guard let date = viewModel.trip.date else { return }
            if dateFormat.showDate(from: Date()) == dateFormat.showDate(from: date) {
                reservTripButton.isHidden = false
                reservedLabel.isHidden = true
                reservedImageView.isHidden = true
                reminderLabel.isHidden = true
                reminderLabel.font = .systemFont(ofSize: 1, weight: .thin)
            } else {
                reservTripButton.isHidden = true
                reservedLabel.isHidden = false
                reservedImageView.isHidden = false
                reminderLabel.isHidden = false
                reminderLabel.font = .systemFont(ofSize: 14, weight: .thin)
            }
            
            dayOfWeekLabel?.text = dateFormat.showDay(from: date)
            dateTripLabel?.text = dateFormat.showDate(from: date)
            timeTripLabel?.text = dateFormat.showTime(from: date)
            startCityLabel?.text = viewModel.trip.startCity
            startStaitionLabel?.text = viewModel.trip.startStaition
            finalyCityLabel?.text = viewModel.trip.finishCity
            finalyStaitionLabel?.text = viewModel.trip.finishStaition
            countPassenger?.text = String(viewModel.trip.countPasseger!)
            costTripLabel?.text = "Итого: " + String(viewModel.trip.countPasseger! * costTrip) + " руб"
            mainConteinerView?.backgroundColor = .systemOrange
            setupReservedTrip(with: "Бронь не подтверждена", color: .systemOrange, image: "pause.circle")
            
            if !viewModel.fullData {
                dataConteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                heightFullData.constant = 0
                fullDataTripConteinerView.isHidden = true
            } else {
                dataConteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                heightFullData.constant = 508
                fullDataTripConteinerView.isHidden = false
            }
        }
    }
    
    override func prepareForReuse() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        selectionStyle = .none
    }
    
    @IBAction func reservTripButtonPressed(_ sender: UIButton) {
        viewModel.reservTrip()
    }
    
    
    @IBAction func editTripButtonPressed(_ sender: UIButton) {
        viewModel.editTrip()
    }
    
    @IBAction func cancelTripButtonPressed(_ sender: UIButton) {
        viewModel.cancelTrip()
    }
    
    private func setupUI() {
        
        fullDataTripConteinerView.backgroundColor = .clear
        backgroundColor = .darkGray
        directionConteinerView.backgroundColor = .white
        infoAndButtonView.backgroundColor = .clear
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
        
        reservTripButton.mainActionButton(with: "Забронировать",
                                          isEnable: true,
                                          color: .white,
                                          fontColor: .darkGray,
                                          sizeFont: 19)
        timeTripLabel.textColor = .black
        startCityLabel.textColor = .black
        startCityLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        finalyCityLabel.textColor = .black
        finalyCityLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        startStaitionLabel.textColor = .gray
        finalyStaitionLabel.textColor = .gray
        reminderLabel.font = .systemFont(ofSize: 16, weight: .thin)
        reminderLabel.textColor = .black
        costTripLabel.textColor = .black
        countPassenger.textColor = .black
        
        editTripButton.setTitle("Редактировать", for: .normal)
        editTripButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        cancelTripButton.setTitle("Отменить", for: .normal)
        cancelTripButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
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
    
    private func removeFullDataView() {
        guard let dataView = fullDataTripConteinerView else { return}
        dataView.removeFromSuperview()
    }
    
}
