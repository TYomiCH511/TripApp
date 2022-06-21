//
//  OrderDoneViewController.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import UIKit

class OrderDoneViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var doneOrderImageView: UIImageView!
    @IBOutlet weak var doneOrderLabel: UILabel!
    
    @IBOutlet weak var orderInfoConteinerView: UIView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dateTripLabel: UILabel!
    @IBOutlet weak var timeTripLabel: UILabel!
    
    @IBOutlet weak var startInfoConteinerView: UIView!
    @IBOutlet weak var startCityLabel: UILabel!
    @IBOutlet weak var startStaitionLabel: UILabel!
    @IBOutlet weak var startCirceView: UIView!
    
    @IBOutlet weak var finishCircleView: UIView!
    @IBOutlet weak var finishInfoConteinerView: UIView!
    @IBOutlet weak var finishCityLabel: UILabel!
    @IBOutlet weak var finishStaitionLabel: UILabel!
    
    @IBOutlet weak var coustTrip: UILabel!
    @IBOutlet weak var countPassagerTrip: UILabel!
    
    @IBOutlet weak var informationOfReservedLabel: UILabel!
    
    @IBOutlet weak var orderBackButton: UIButton!
    
    // MARK: - Properties
    
    
    // MARK: - Life cycle view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func orderBackButtonPressed(_ sender: UIButton) {
        guard let orderVC = navigationController?.viewControllers[1] as? SelectDirectViewController else { return }
        orderVC.viewModel = SelectDirectViewModel(trip: nil, typeSelectDirection: .orderBack)
        navigationController?.popToViewController(orderVC, animated: true)
    }
    
    
    // MARK: - Custom functions
    private func setupUI() {
        view.backgroundColor = mainBackgroundColor
        orderInfoConteinerView.backgroundColor = #colorLiteral(red: 0.2143622637, green: 0.2143622637, blue: 0.2143622637, alpha: 1)
        orderInfoConteinerView.addShadowOnView()
        
        orderInfoConteinerView.layer.cornerRadius = cornerRadiusButton
        startInfoConteinerView.backgroundColor = .clear
        finishInfoConteinerView.backgroundColor = .clear
        
        doneOrderImageView.backgroundColor = .clear
        doneOrderImageView.tintColor = .white
        doneOrderImageView.image = UIImage(systemName: "checkmark.circle.fill")
        doneOrderLabel.text = "Ваши билеты заказаны!"
        doneOrderLabel.textColor = .white
        doneOrderLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        startCirceView.layer.cornerRadius = startCirceView.frame.width / 2
        finishCircleView.layer.cornerRadius = startCirceView.layer.cornerRadius
        
        informationOfReservedLabel.text = "За сутки до выезда (до 15.00) обязательно подтвердите бронь в разделе История. За час до времени выезда на ваш номер, указанные при регистрации, придет СМС оповещение с данными автобуса."
        informationOfReservedLabel.numberOfLines = 5
        orderBackButton.orangeButton(with: "Заказать обратно", isEnable: true)
    }






}
