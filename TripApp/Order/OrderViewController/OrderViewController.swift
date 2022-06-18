//
//  OrderViewController.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var selectDirectionLabel: UILabel!
    @IBOutlet weak var minskDirectionButton: UIButton!
    @IBOutlet var vitebskDirectionButton: UIButton!
    
    
    var viewModel: OrderViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OrderViewmodel()
        setupUI()
    }
    
    @IBAction func minskDirectionButtonPressed(_ sender: UIButton) {
        guard let selectDirectionVC = storyboard?.instantiateViewController(withIdentifier: "nav") as? UINavigationController else { return }
        guard let startVC = selectDirectionVC.viewControllers.first as? SelectDirectViewController else { return }
        startVC.viewModel = SelectDirectViewModel(trip: nil, isEdit: false)
        selectDirectionVC.modalPresentationStyle = .currentContext
        navigationController?.pushViewController(startVC, animated: true)
    }
    
    
    @IBAction func vitebskDirectionButtonPressed(_ sender: UIButton) {
    }
    
    private func setupUI() {
        selectDirectionLabel.text = "Выберите направление"
        minskDirectionButton.setTitle("Минск - Полоцк - Новополоцк", for: .normal)
        vitebskDirectionButton.setTitle("Витебск - Полоцк - Новополоцк", for: .normal)
    }
    
}
