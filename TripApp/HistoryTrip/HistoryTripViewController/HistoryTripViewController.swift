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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell()}
        
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select row \(indexPath.row)")
    }
    
    
}


