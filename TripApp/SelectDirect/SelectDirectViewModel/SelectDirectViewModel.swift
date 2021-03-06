//
//  SelectDirectViewModel.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import Foundation
import FirebaseAuth

protocol EditTripDoneProtocol: AnyObject {
    func updateTrip(trip: Trip)
}

protocol SelectDirectViewModelProtocol {
    var trip: Trip? { get set }
    var countPassager: Int { get set }
    var typeSelectDirection: TypeSelectDirection { get }
    var editDelegate: EditTripDoneProtocol? { get set }
    func viewModelDataTripCell(at indexPath: IndexPath) -> DataTripViewModelProtocol
    func viewModelFromCity() -> SelectCityViewModel
    func viewModelWhereCity() -> SelectCityViewModel
    func viewModelOrderDone() -> OrderDoneViewModelProtocol?
    func orderTrip(complition: @escaping () -> ())
}


class SelectDirectViewModel: SelectDirectViewModelProtocol {
    
    var trip: Trip?
    let userId = Auth.auth().currentUser?.uid
    let localNotification = UserNotification()
    var countPassager: Int = 0
    var typeSelectDirection: TypeSelectDirection
    weak var editDelegate: EditTripDoneProtocol?
    var cities = CitySrore.shared.getCities()
    required init(trip: Trip?, typeSelectDirection: TypeSelectDirection) {
        self.typeSelectDirection = typeSelectDirection
        self.trip = trip
    }
    
    func viewModelDataTripCell(at indexPath: IndexPath) -> DataTripViewModelProtocol {
        
        switch indexPath.row {
        case 0:
            return  DataTripViewModel(mainText: trip?.startCity ?? "Откуда",
                                      secondaryText: trip?.startStaition ?? "",
                                      imageName: "arrow.down.left")
            
        case 1:
            return  DataTripViewModel(mainText: trip?.finishCity ?? "Куда",
                                      secondaryText: trip?.finishStaition ?? "",
                                      imageName: "arrow.up.right")
            
        case 2:
            
            if let date = trip?.date {
                return  DataTripViewModel(mainText: CustomDate.shared.showDate(from: date),
                                          secondaryText: CustomDate.shared.showTime(from: date),
                                          imageName: "clock")
                
            } else {
                return  DataTripViewModel(mainText: "Время", secondaryText: "",
                                          imageName: "clock")
            }
            
        case 3:
            return  DataTripViewModel(mainText: trip?.countPasseger?.description ?? "Количество мест",
                                      secondaryText: "",
                                      imageName: "person")
            
        default:
            break
        }
        
        return  DataTripViewModel(mainText: "",
                                  secondaryText: "",
                                  imageName: "person")
    }
    
    func viewModelFromCity() -> SelectCityViewModel {
        return SelectCityViewModel(cities: cities)
    }
    
    func viewModelWhereCity() -> SelectCityViewModel {
        if trip?.startCity == "Минск" {
            var sortedCity = cities
            sortedCity.remove(at: 0)
            return SelectCityViewModel(cities: sortedCity)
        } else {
            var sortedCity: [City] = []
            sortedCity.append(cities[0])
            return SelectCityViewModel(cities: sortedCity)
        }
        
        
        
    }
    
    func orderTrip(complition: @escaping () -> ()) {
        
        guard let trip = trip else { return }
        
        switch typeSelectDirection {
        
        case .edit:
            editDelegate?.updateTrip(trip: trip)
            print("edit done")
            
        default:
            guard let userId = userId else { return }
            //Create order trip in dataBase
            TripsManager.shared.setTrip(withUserId: userId, trip: trip) {
            complition()
                guard let date = trip.date else { return }
                //show only greater 2 days
                print(CustomDate.shared.showDate(from: date))
                print(CustomDate.shared.showDate(from: Date(timeIntervalSinceNow: 75000)))
                if CustomDate.shared.compare(firstDate: date, secondDate: Date(timeIntervalSinceNow: 75000)) {
                    self.localNotification.createNotification(
                        withTitle: "Подтверждение",
                        body: "Вы можете подтвердить вашу поездку",
                        identifier: trip.id,
                        dateTrip: date)
                    print("set notification")
                } else {
                    print("don't set notification")
                }
            
                
            }
        }
    }
    
    func viewModelOrderDone() -> OrderDoneViewModelProtocol? {
        
        guard let trip = trip else { return nil }
        
        return OrderDoneViewModel(trip: trip)
    }
}
