//
//  SelectorViewController.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import UIKit

class SelectCityViewController: UIViewController {

    @IBOutlet weak var cityTableView: UITableView!
    
    
    var viewModel: SelectCityViewModelProtocol!
    weak var delegate: CallBackDataTripToRootVCProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        cityTableView.backgroundColor = mainBackgroundColor
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }
    

    
}


extension SelectCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.backgroundColor = mainBackgroundColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = viewModel.cities[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let staitionController = ViewControllers.SelectStaitionViewController.rawValue
        guard let staitionVC = storyboard?.instantiateViewController(withIdentifier: staitionController) as? SelectStaitionViewController else { return }
        staitionVC.delegate = delegate
        staitionVC.viewModel = SelectStaitionViewModel(staition: viewModel.cities[indexPath.row].staition)
        navigationController?.pushViewController(staitionVC, animated: true)
        
    }
    
}
