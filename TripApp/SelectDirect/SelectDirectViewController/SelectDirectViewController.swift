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
        
        orderTableVIew.delegate = self
        orderTableVIew.dataSource = self
        view.backgroundColor = .white
        orderTableVIew.backgroundColor = .white
        fillVIew.backgroundColor = .clear
        orderTripButton.orangeButton(with: "Завершить", isEnable: true)
        
        let nib = UINib(nibName: String(describing: DataTripTableViewCell.self), bundle: .main)
        orderTableVIew.register(nib, forCellReuseIdentifier: "cell")
    }
    
    
    @IBAction func orderTripButtonPressed(_ sender: UIButton) {
        viewModel.addTrip()
        navigationController?.popToRootViewController(animated: true)
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
                viewModel.trip = Trip(date: nil, startCity: nil, startStaition: nil, finishCity: nil, finishStaition: nil, tripStait: .notReserved, countPasseger: nil, driver: nil)
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
