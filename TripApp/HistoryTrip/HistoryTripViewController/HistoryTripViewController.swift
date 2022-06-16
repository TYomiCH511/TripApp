//
//  HistoryTripViewController.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import UIKit

class HistoryTripViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var historyTableView: UITableView!
    
    // MARK: - properies
    private var viewModel: HistoryTripViewModelProtocol!
    
    private var selectTrip = 0
    
    // MARK: - Life cicle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HistoryTripViewModel()
        viewModel.editTripDelegate = self 
        historyTableView.delegate = self
        historyTableView.dataSource = self
        let nib = UINib(nibName: String(describing: HistoryTableViewCell.self), bundle: .main)
        historyTableView.register(nib, forCellReuseIdentifier: "cell")
        historyTableView.backgroundColor = .darkGray
        historyTableView.showsVerticalScrollIndicator = false
        
        viewModel.trips.bind { _ in
            self.historyTableView.reloadData()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

}


extension HistoryTripViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tripsCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell()}
        selectTrip = indexPath.row
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select row \(indexPath.row)")
    }
    
    
}


extension HistoryTripViewController: EditTripProtocol {
    func editTrip(trip: Trip, tag: Int) {
        
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: "selectDirection") as? SelectDirectViewController else { return }
        editVC.viewModel = SelectDirectViewModel(trip: trip, isEdit: true)
        editVC.viewModel.editDelegate = self
        selectTrip = tag
        navigationController?.pushViewController(editVC, animated: true)
        
    }
    
    
    
}

extension HistoryTripViewController: EditTripDoneProtocol {
    func updateTrip(trip: Trip) {
        guard var user = UserStore.shared.getUser() else { return }
        user.trips[selectTrip] = trip
        UserStore.shared.save(user: user)
        viewModel.trips.value[selectTrip] = trip
    }
    
    
}
