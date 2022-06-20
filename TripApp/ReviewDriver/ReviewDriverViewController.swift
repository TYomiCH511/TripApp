//
//  ReviewDriverViewController.swift
//  TripApp
//
//  Created by Artem on 17.06.22.
//

import UIKit

class ReviewDriverViewController: UIViewController {
    
    
    @IBOutlet weak var infoLabelConteinerView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var driverInfoConteinerView: UIView!
    @IBOutlet weak var tripDirectionLabel: UILabel!
    @IBOutlet weak var tripTimeLabel: UILabel!
    @IBOutlet weak var photoDriverImage: UIImageView!
    @IBOutlet weak var fullnameDriverLabel: UILabel!
    
    @IBOutlet weak var evaluationDriverConteinerView: UIView!
    @IBOutlet weak var reviewDriverLabel: UILabel!
    @IBOutlet var evaluationDriver: [UIImageView]!
    
    
    @IBOutlet weak var evaluationCarConteinerView: UIView!
    @IBOutlet weak var reviewCarLabel: UILabel!
    @IBOutlet var evaluationCar: [UIImageView]!
    
    
    @IBOutlet weak var leaveReviewDriverButton: UIButton!
    
    
    // MARK: - Properties
    var viewModel: ReviewDriverViewModelProtocol?
    
    // MARK: - life cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func leaveReviewDriverPressed(_ sender: UIButton) {
        viewModel?.leaveReview()
        let alert = Alert.shared.showAlertLeaveReview(vc: self)
        present(alert, animated: true)
    }
    
    private func setupUI() {
        
        view.backgroundColor = mainBackgroundColor
        infoLabelConteinerView.backgroundColor = .clear
        driverInfoConteinerView.backgroundColor = #colorLiteral(red: 0.2143622637, green: 0.2143622637, blue: 0.2143622637, alpha: 1)
        driverInfoConteinerView.layer.cornerRadius = cornerRadiusButton
        driverInfoConteinerView.addShadowOnView()
        evaluationDriverConteinerView.backgroundColor = .clear
        evaluationCarConteinerView.backgroundColor = .clear
        leaveReviewDriverButton.orangeButton(with: "Отправить", isEnable: true)
        
        informationLabel.text = "Для улучшения качества обслуживания, пожалуста, оцените работу водителя и уровень комфорта автобуса."
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
        informationLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        tripDirectionLabel.text = viewModel?.tripDirection
        tripDirectionLabel.textColor = .lightGray
        tripDirectionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        tripTimeLabel.text = viewModel?.tripTime
        tripTimeLabel.textColor = .lightGray
        tripTimeLabel.font = tripDirectionLabel.font
        
        reviewDriverLabel.text = "Ваша оценка водителю"
        reviewCarLabel.text = "Ваша оценка автобуса"
        if let photo = viewModel?.photo {
            print(photo)
            photoDriverImage.image = UIImage(named: photo)
            photoDriverImage.layer.cornerRadius = photoDriverImage.frame.width / 2
        }
        
        fullnameDriverLabel.text = viewModel?.fullName
        fullnameDriverLabel.numberOfLines = 3
        
        for (tag, star) in evaluationDriver.enumerated() {
            setupStarImageView(tag: tag, star: star)
        }
        
        for (tag, star) in evaluationCar.enumerated() {
            setupStarImageView(tag: tag, star: star)
        }
        
    }
    
    private func setupStarImageView(tag: Int, star: UIImageView) {
        star.tag = tag
        if star.image == UIImage(systemName: "star.fill") {
            star.tintColor = .systemOrange
        } else {
            star.tintColor = .lightGray
        }
        star.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapStar(sender:)))
        star.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapStar(sender: UITapGestureRecognizer) {
        
        guard let imageView = sender.view as? UIImageView else { return }
        if evaluationDriver.contains(imageView) {
            for starTag in 0...imageView.tag {
                evaluationDriver[starTag].image = UIImage(systemName: "star.fill")
                evaluationDriver[starTag].tintColor = .systemOrange
                
            }
            if imageView.tag < 4 {
                for starTag in imageView.tag + 1...evaluationDriver.count - 1 {
                    evaluationDriver[starTag].image = UIImage(systemName: "star")
                    evaluationDriver[starTag].tintColor = .lightGray
                }
            }
        } else {
            for starTag in 0...imageView.tag {
                evaluationCar[starTag].image = UIImage(systemName: "star.fill")
                evaluationCar[starTag].tintColor = .systemOrange
                
            }
            if imageView.tag < 4 {
                for starTag in imageView.tag + 1...evaluationDriver.count - 1 {
                    evaluationCar[starTag].image = UIImage(systemName: "star")
                    evaluationCar[starTag].tintColor = .lightGray
                }
            }
        }
        
        
    }
    
}

