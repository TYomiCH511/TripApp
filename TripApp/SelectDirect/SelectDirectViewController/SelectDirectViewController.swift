//
//  SelectDirectViewController.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import UIKit


protocol CallBackDataTripToRootVCProtocol: AnyObject {
    func callBack(data: String)
    func callBack(date: Date)
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
                
                orderTripButton.orangeButton(with: "Заказать", isEnable: true)
            case .orderBack:
                orderTripButton.orangeButton(with: "Заказать", isEnable: true)
            case .edit:
                orderTripButton.orangeButton(with: "Изменить", isEnable: true)
            }
        }
    }
    
    
    @IBAction func orderTripButtonPressed(_ sender: UIButton) {
        
        switch viewModel.typeSelectDirection {
        case .new:
            guard let orderDoneVC = storyboard?.instantiateViewController(withIdentifier: "orderDone") as? OrderDoneViewController else { return }
            viewModel.addTrip()
            navigationController?.pushViewController(orderDoneVC, animated: true)
            tabBarController?.viewControllers![1].tabBarItem.badgeColor = mainColor
            tabBarController?.viewControllers![1].tabBarItem.badgeValue = "1"
        case .orderBack:
            guard let orderDoneVC = storyboard?.instantiateViewController(withIdentifier: "orderDone") as? OrderDoneViewController else { return }
            viewModel.addTrip()
            
            navigationController?.pushViewController(orderDoneVC, animated: true)
        case .edit:
            viewModel.addTrip()
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
    
    private func setupUI() {
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
            
            guard let selectCityVC = storyboard?.instantiateViewController(withIdentifier: "city") as? SelectCityViewController else { return }
            navigationController?.pushViewController(selectCityVC, animated: true)
            selectCityVC.viewModel =  viewModel.viewModelCity()
            selectCityVC.delegate = self
            
        case 1:
            if viewModel.trip?.startStaition != nil {
                guard let selectCityVC = storyboard?.instantiateViewController(withIdentifier: "city") as? SelectCityViewController else { return }
                navigationController?.pushViewController(selectCityVC, animated: true)
                selectCityVC.viewModel =  viewModel.viewModelCity()
                selectCityVC.delegate = self
                
            }
            
        case 2:
            if viewModel.trip?.finishStaition != nil {
                print("select date row")
                guard let selectDateVC = storyboard?.instantiateViewController(withIdentifier: "selectDate") as? SelectDateViewController else { return }
                selectDateVC.delegate = self
                navigationController?.pushViewController(selectDateVC, animated: true)
            }
        default:
            if viewModel.trip?.date != nil {
                guard let selectCityVC = storyboard?.instantiateViewController(withIdentifier: "staitionVC") as? SelectStaitionViewController else { return }
                let count = ["1", "2", "3"]
                selectCityVC.delegate = self
                selectCityVC.viewModel = SelectStaitionViewModel(staition: count)
                navigationController?.pushViewController(selectCityVC, animated: true)
            }
            
        }
        
        
        
    }
    
}

extension SelectDirectViewController: CallBackDataTripToRootVCProtocol {
    func callBack(date: Date) {
        print(date)
        viewModel.trip?.date = date
        orderTableVIew.reloadData()
    }
    
    func callBack(data: String) {
        switch selectRow {
        case 0:
            if viewModel.trip == nil {
                viewModel.trip = Trip(date: nil, startCity: nil,
                                      startStaition: nil, finishCity: nil,
                                      finishStaition: nil, tripStait: .notReserved,
                                      countPasseger: nil,
                                      driver: Driver(carModel: "Mercedes Sprinter",
                                                     carColor: "Белый",
                                                     carNumber: "8888-2",
                                                     phoneNumber: "+375 29 566 47 58",
                                                     raiting: "4.84",
                                                     fullName: "Сидоров Алексей Петрович",
                                                     photo: "avatar"))
            }
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
            print(Int(data)!)
            viewModel.trip?.countPasseger = Int(data)!
            
        default: break
        }
        
        orderTableVIew.reloadData()
    }
    
    
}
