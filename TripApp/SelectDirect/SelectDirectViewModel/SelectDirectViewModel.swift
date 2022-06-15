//
//  SelectDirectViewModel.swift
//  TripApp
//
//  Created by Artem on 14.06.22.
//

import Foundation

protocol SelectDirectViewModelProtocol {
    var trip: Trip? { get set }
    init(trip: Trip?)
    func viewModelDataTripCell(at indexPath: IndexPath) -> DataTripViewModelProtocol
    func viewModelCity() -> SelectCityViewModel
}


class SelectDirectViewModel: SelectDirectViewModelProtocol {
    var trip: Trip?
    let cities = CitySrore.shared.getCities()
    required init(trip: Trip?) {
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
    
    func viewModelCity() -> SelectCityViewModel {
        
        return SelectCityViewModel(cities: cities)
    }
}
