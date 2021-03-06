//
//  SelectStaitionViewController.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import UIKit

class SelectStaitionViewController: UIViewController {

    @IBOutlet weak var staitionTableView: UITableView!
    
    var viewModel: SelectStaitionViewModelProtocol!
    weak var delegate: CallBackDataTripToRootVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackgroundColor
        staitionTableView.backgroundColor = mainBackgroundColor
        staitionTableView.delegate = self
        staitionTableView.dataSource = self
        
    }
    


}


extension SelectStaitionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staition", for: indexPath)
        cell.backgroundColor = mainBackgroundColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = viewModel.staition[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.callBack(data: viewModel.staition[indexPath.row])
        guard let vc = navigationController?.viewControllers[1] as? SelectDirectViewController else { return }
        navigationController?.popToViewController(vc, animated: true)
        
        
        
    }
    
}
