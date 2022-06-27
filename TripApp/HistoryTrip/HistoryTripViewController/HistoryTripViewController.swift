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
    private var viewModel: HistoryTripViewModelProtocol! {
        didSet {
            
        }
    }
    private var selectTrip = 0
    
    // MARK: - Life cicle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HistoryTripViewModel()
        viewModel.getTrips { [weak self] in
            self?.historyTableView.refreshControl?.endRefreshing()
            
        }
        viewModel.editTripDelegate = self
        viewModel.reviewDelegate = self
        historyTableView.delegate = self
        historyTableView.dataSource = self
        let notReservedNib = UINib(nibName: String(describing: NotReservedTableViewCell.self), bundle: .main)
        let reservedNib = UINib(nibName: String(describing: ReservedTableViewCell.self), bundle: .main)
        let complitionNib = UINib(nibName: String(describing: ComplitionTableViewCell.self), bundle: .main)
        let cancelNib = UINib(nibName: String(describing: CancelTableViewCell.self), bundle: .main)
        historyTableView.register(notReservedNib, forCellReuseIdentifier: "notReserved")
        historyTableView.register(reservedNib, forCellReuseIdentifier: "reserved")
        historyTableView.register(complitionNib, forCellReuseIdentifier: "complition")
        historyTableView.register(cancelNib, forCellReuseIdentifier: "cancel")
        
        historyTableView.backgroundColor = .darkGray
        historyTableView.showsVerticalScrollIndicator = false
        historyTableView.refreshControl = UIRefreshControl()
        
        historyTableView.refreshControl?.addTarget(self, action: #selector(fetchNewTrip), for: .valueChanged)
        viewModel.trips.bind { _ in
            self.historyTableView.reloadData()
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyTableView.refreshControl?.beginRefreshing()
        viewModel.getTrips { [weak self] in
            self?.historyTableView.refreshControl?.endRefreshing()
            
        }
        tabBarController?.tabBar.selectedItem?.badgeValue = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //This method past in fetch TripsData
        self.historyTableView.refreshControl?.endRefreshing()
    }
    
    @objc private func fetchNewTrip() {
        viewModel.getTrips { [weak self] in
            self?.historyTableView.refreshControl?.endRefreshing()
        }
        historyTableView.refreshControl?.endRefreshing()
    }
    
}


extension HistoryTripViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tripsCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.trips.value[indexPath.row].tripStatus {
        case "notReserved":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "notReserved", for: indexPath) as? NotReservedTableViewCell else { return UITableViewCell() }
            selectTrip = indexPath.row
            cell.viewModel = viewModel.cellViewModel(at: indexPath)
            return cell
        case "reserved":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "reserved", for: indexPath) as? ReservedTableViewCell else { return UITableViewCell() }
            selectTrip = indexPath.row
            cell.viewModel = viewModel.cellViewModel(at: indexPath)
            return cell
        case "complition":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "complition", for: indexPath) as? ComplitionTableViewCell else { return UITableViewCell() }
            selectTrip = indexPath.row
            cell.viewModel = viewModel.cellViewModel(at: indexPath)
            return cell
        case "cancel":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cancel", for: indexPath) as? CancelTableViewCell else { return UITableViewCell() }
            selectTrip = indexPath.row
            cell.viewModel = viewModel.cellViewModel(at: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.frame.size.height ?? 0 < 150 {
            viewModel.isShowFull[indexPath.row] = true
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            viewModel.isShowFull[indexPath.row] = false
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
    }
    
    
}


extension HistoryTripViewController: EditTripProtocol {
    func editTrip(trip: Trip, tag: Int) {
        
        let directionController = ViewControllers.SelectDirectViewController.rawValue
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: directionController) as? SelectDirectViewController else { return }
        editVC.viewModel = SelectDirectViewModel(trip: trip, typeSelectDirection: .edit)
        editVC.viewModel.editDelegate = self
        selectTrip = tag
        navigationController?.pushViewController(editVC, animated: true)
        
    }
    
    
    
}
// MARK: - EditTripDoneProtocol
extension HistoryTripViewController: EditTripDoneProtocol {
    func updateTrip(trip: Trip) {
        guard var user = UserStore.shared.getUser() else { return }
        user.trips[selectTrip] = trip
        UserStore.shared.save(user: user)
        viewModel.trips.value[selectTrip] = trip
    }
    
    
}

// MARK: - LeaveReviewDriverProtocol
extension HistoryTripViewController: LeaveReviewDriverProtocol {
    
    func leaveReview(viewModel: ReviewDriverViewModelProtocol) {
        
        let reviewController = ViewControllers.ReviewDriverViewController.rawValue
        guard let reviewVC = storyboard?.instantiateViewController(withIdentifier: reviewController) as? ReviewDriverViewController else { return }
            reviewVC.viewModel = viewModel
            navigationController?.pushViewController(reviewVC, animated: true)
            
    }
    
    
}
