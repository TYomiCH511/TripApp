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
        
    }
    

}


extension HistoryTripViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else { return UITableViewCell()}
        
        
        return cell
    }
    
    
    
    
}
