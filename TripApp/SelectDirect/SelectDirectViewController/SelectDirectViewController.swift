//
//  SelectDirectViewController.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import UIKit
import FirebaseAuth

protocol CallBackDataTripToRootVCProtocol: AnyObject {
    func callBack(data: String)
    func callBack(date: Date, countPassager: Int)
}

class SelectDirectViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var orderTableVIew: UITableView!
    @IBOutlet weak var fillVIew: UIView!
    @IBOutlet weak var orderTripButton: UIButton!
    
    
    // MARK: - Properties
    var viewModel: SelectDirectViewModelProtocol!
    
    private var selectRow = 0
    
    // MARK: - life cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.trip?.countPasseger ?? 0 <= 0 {
            
            switch viewModel.typeSelectDirection {
            case .new:
                orderTripButton.grayButton(with: "Заказать", isEnable: false)
            case .orderBack:
                orderTableVIew.reloadData()
                orderTripButton.grayButton(with: "Заказать", isEnable: false)
            case .edit:
                orderTripButton.grayButton(with: "Изменить", isEnable: false)
            }
            
        } else {
            switch viewModel.typeSelectDirection {
            case .new:
                
                orderTripButton.mainActionButton(with: "Заказать", isEnable: true)
            case .orderBack:
                orderTripButton.mainActionButton(with: "Заказать", isEnable: true)
            case .edit:
                orderTripButton.mainActionButton(with: "Изменить", isEnable: true)
            }
        }
    }
    
    
    @IBAction func orderTripButtonPressed(_ sender: UIButton) {
        
        switch viewModel.typeSelectDirection {
        case .new:
            
            viewModel.orderTrip { [weak self] in
                let orderDoneController = ViewControllers.OrderDoneViewController.rawValue
                guard let orderDoneVC = self?.storyboard?.instantiateViewController(withIdentifier: orderDoneController) as? OrderDoneViewController else { return }
                orderDoneVC.viewModel = self?.viewModel.viewModelOrderDone()
                self?.tabBarController?.viewControllers![1].tabBarItem.badgeColor = mainColor
                self?.tabBarController?.viewControllers![1].tabBarItem.badgeValue = "1"
                self?.navigationController?.pushViewController(orderDoneVC, animated: true)
            }
            
        case .orderBack:
            
            viewModel.orderTrip { [weak self] in
                let orderDoneController = ViewControllers.OrderDoneViewController.rawValue
                guard let orderDoneVC = self?.storyboard?.instantiateViewController(withIdentifier: orderDoneController) as? OrderDoneViewController else { return }
                orderDoneVC.viewModel = self?.viewModel.viewModelOrderDone()
                self?.navigationController?.pushViewController(orderDoneVC, animated: true)
            }
            
        case .edit:
            viewModel.orderTrip { [unowned self] in
                let alertView = UIView()
                
                view.addSubview(alertView)
                alertView.center = self.orderTableVIew.center
                
                alertView.frame.size = CGSize(width: 100, height: 100)
                alertView.backgroundColor = .black
                alertView.layer.cornerRadius = 8
                alertView.alpha = 1
                let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
                imageView.frame.size = CGSize(width: 100, height: 100)
                
                imageView.tintColor = .white
                alertView.addSubview(imageView)
                
                UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                    alertView.alpha = 0
                    
                } completion: { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    private func setupUI() {
        navigationController?.title = "Выбор данных"
        view.backgroundColor = mainBackgroundColor
        orderTableVIew.delegate = self
        orderTableVIew.dataSource = self
        orderTableVIew.backgroundColor = mainBackgroundColor
        fillVIew.backgroundColor = .clear
        
        
        let nib = UINib(nibName: String(describing: DataTripTableViewCell.self), bundle: .main)
        orderTableVIew.register(nib, forCellReuseIdentifier: "cell")
    }
}


extension SelectDirectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DataTripTableViewCell else { return UITableViewCell() }
        
        cell.viewModel = viewModel.viewModelDataTripCell(at: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectRow = indexPath.row
        switch indexPath.row {
        case 0:
            let cityController = ViewControllers.SelectCityViewController.rawValue
            guard let selectCityVC = storyboard?.instantiateViewController(withIdentifier: cityController) as? SelectCityViewController else { return }
            navigationController?.pushViewController(selectCityVC, animated: true)
            selectCityVC.viewModel =  viewModel.viewModelFromCity()
            selectCityVC.navigationItem.title = "Откуда"
            selectCityVC.delegate = self
            
        case 1:
            if viewModel.trip?.startStaition != nil {
                let cityController = ViewControllers.SelectCityViewController.rawValue
                guard let selectCityVC = storyboard?.instantiateViewController(withIdentifier: cityController) as? SelectCityViewController else { return }
                navigationController?.pushViewController(selectCityVC, animated: true)
                selectCityVC.viewModel =  viewModel.viewModelWhereCity()
                selectCityVC.navigationItem.title = "Куда"
                selectCityVC.delegate = self
                
            }
            
        case 2:
            if viewModel.trip?.finishStaition != nil {
                let selectDateController = ViewControllers.SelectDateViewController.rawValue
                guard let selectDateVC = storyboard?.instantiateViewController(withIdentifier: selectDateController) as? SelectDateViewController else { return }
                selectDateVC.navigationItem.title = "Выбор даты и времени"
                selectDateVC.delegate = self
                navigationController?.pushViewController(selectDateVC, animated: true)
            }
        default:
            if viewModel.trip?.date != nil {
                let staitionController = ViewControllers.SelectStaitionViewController.rawValue
                guard let selectCountPassagerVC = storyboard?.instantiateViewController(withIdentifier: staitionController) as? SelectStaitionViewController else { return }
                var count: [String] = []
                if viewModel.countPassager > 3 {
                    for i in 1...3 {
                        count.append("\(i)")
                    }
                } else if viewModel.countPassager == 1 {
                    count.append("1")
                } else {
                    for i in 1...viewModel.countPassager {
                        count.append("\(i)")
                    }
                }
                selectCountPassagerVC.navigationItem.title = "Количество пассажиров"
                selectCountPassagerVC.delegate = self
                selectCountPassagerVC.viewModel = SelectStaitionViewModel(staition: count)
                navigationController?.pushViewController(selectCountPassagerVC, animated: true)
            }
            
        }
        
    }
    
}

extension SelectDirectViewController: CallBackDataTripToRootVCProtocol {
    
    func callBack(date: Date, countPassager: Int) {
        
        viewModel.trip?.date = date
        let currentDay = CustomDate.shared.showDate(from: Date())
        let orderTripDay = CustomDate.shared.showDate(from: date)
        
        if currentDay == orderTripDay {
            viewModel.trip?.tripStatus = TripStatus.reserved.rawValue
        } 
        viewModel.countPassager = countPassager
        orderTableVIew.reloadData()
    }
    
    func callBack(data: String) {
        switch selectRow {
        case 0:
            
            viewModel.trip = Trip(id: UUID().uuidString,
                                  date: nil,
                                  startCity: nil,
                                  startStaition: nil,
                                  finishCity: nil,
                                  finishStaition: nil,
                                  tripStatus: TripStatus.notReserved.rawValue,
                                  countPassager: nil
                                  )
            
            var city1 = ""
            CitySrore.shared.getCities().forEach { city in
                if city.staition.contains(data) {
                    city1 = city.name
                }
                
            }
            viewModel.trip?.startCity = city1
            viewModel.trip?.startStaition = data
            
        case 1:
            var city1 = ""
            CitySrore.shared.getCities().forEach { city in
                if city.staition.contains(data) {
                    city1 = city.name
                }
                
            }
            viewModel.trip?.finishCity = city1
            viewModel.trip?.finishStaition = data
            
        case 2:
            var city1 = ""
            CitySrore.shared.getCities().forEach { city in
                if city.staition.contains(data) {
                    city1 = city.name
                }
                
            }
            viewModel.trip?.finishCity = city1
            viewModel.trip?.finishStaition = data
            
        case 3:
            if let countPassager = Int(data) {
                viewModel.trip?.countPasseger = countPassager
            }
            
            
        default: break
        }
        
        orderTableVIew.reloadData()
    }
    
    
}
