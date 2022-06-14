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
    

}


extension HistoryTripViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tripsCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell()}
        
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select row \(indexPath.row)")
    }
    
    
}


extension HistoryTripViewController: EditTripProtocol {
    func editTrip(trip: Trip, tag: Int) {
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: "nav") as? UINavigationController else { return }
        guard let startVC = editVC.viewControllers.first as? SelectDirectViewController else { return }
        startVC.viewModel = SelectDirectViewModel(trip: trip)
        editVC.modalPresentationStyle = .currentContext
        startVC.modalPresentationStyle = .currentContext
        present(editVC, animated: true)
        //show(editVC, sender: nil)
    }
    
    
    
}
