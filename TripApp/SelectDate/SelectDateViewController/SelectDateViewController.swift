//
//  SelectDateViewController.swift
//  TripApp
//
//  Created by Artem on 15.06.22.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    @IBOutlet weak var selectDateLabel: UILabel!
    @IBOutlet weak var selectTimeLabel: UILabel!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var selectorDatePicker: UIDatePicker!
    
    private let window = UIScreen.main.bounds
    
    private var viewModel: SelectDateViewModelProtocol!
    
    private var sideWidth: CGFloat = 0
    private let sideHeight: CGFloat = 40
    
    weak var delegate: CallBackDataTripToRootVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SelectDateViewmodel()
        sideWidth = timeCollectionView.frame.width / 3 - 10
        let countOfRow = (CGFloat(self.viewModel.numberOfItem()) / 3).rounded(.up)
        heightCollectionView.constant = self.sideHeight * countOfRow  + 10 * countOfRow - 10
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .darkGray
        selectDateLabel.textColor = .white
        selectDateLabel.textColor = .white
        let nib = UINib(nibName: String(describing: TimeCollectionViewCell.self), bundle: .main)
        timeCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        timeCollectionView.dataSource = self
        timeCollectionView.delegate = self
        timeCollectionView.backgroundColor = .darkGray
        selectDateLabel.text = "Выберите дату"
        selectTimeLabel.text = "Выберите время"
        setupDatePicker()
    }
    
    //Setup date picker
    private func setupDatePicker() {
        
        selectorDatePicker.addTarget(self, action: #selector(showFreeTimeAndSeat), for: .valueChanged)
        selectorDatePicker.datePickerMode = .date
        
        // acces date only 1 month = 2 560 000 seconds
        selectorDatePicker.maximumDate = Date(timeIntervalSinceNow: 2_560_000)
        selectorDatePicker.minimumDate = Date()
        selectorDatePicker.tintColor = .systemOrange
        selectorDatePicker.locale = .init(identifier: "ru_RU")
        selectorDatePicker.timeZone = .init(abbreviation: "ru_RU")
        selectorDatePicker.backgroundColor = .darkGray
    }
    
    @objc private func showFreeTimeAndSeat(sender: UIDatePicker, for event: UIEvent) {
        DateTripManager.shared.getTime(inDate: selectorDatePicker.date) { day in
            print(day)
            self.viewModel.times = TimeStore.shared.getTime()
            self.timeCollectionView.reloadData()
            UIView.animate(withDuration: 1) {
                let countOfRow = (CGFloat(self.viewModel.numberOfItem()) / 3).rounded(.up)
                self.heightCollectionView.constant = self.sideHeight * countOfRow  + 10 * countOfRow - 10
                self.loadViewIfNeeded()
            }
        }
        
    }
    
}


extension SelectDateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                   
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell()}
        cell.viewModel = viewModel.viewModelTimeCell(at: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: sideWidth, height: sideHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if viewModel.times[indexPath.item].countPassager != 0 {
            
            guard let selectDirectionVC = navigationController?.viewControllers[1] as? SelectDirectViewController else { return }
            let date = selectorDatePicker.date
            let dateTrip = viewModel.dateTrip(date: date, indexPath: indexPath)
            delegate?.callBack(date: dateTrip, countPassager: viewModel.times[indexPath.item].countPassager)
            
            navigationController?.popToViewController(selectDirectionVC, animated: true)
        }
    }
}
