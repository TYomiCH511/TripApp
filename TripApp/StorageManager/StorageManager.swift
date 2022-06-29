//
//  StorageManager.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import Foundation

    
//    Trip(date: Date(), startCity: "Минск", startStaition: "ЖД вокзал",
//         finishCity: "Новополоцк", finishStaition: "Кинотеатр Минск",
//         tripStatus: .cancel, countPasseger: 1,
//         driver: Driver(carModel: "Mercedes Sprinter",
//                        carColor: "Белый",
//                        carNumber: "8888-2",
//                        phoneNumber: "+375 29 566 47 58",
//                        raiting: "4.84",
//                        fullName: "Сидоров Алексей Петрович",
//                        photo: "avatar")),
//
//    Trip(date: Date(), startCity: "Полоцк", startStaition: "ЖД вокзал",
//         finishCity: "Минск", finishStaition: "ЭкспоБел",
//         tripStatus: .notReserved, countPasseger: 2, driver:
//            Driver(carModel: "Mercedes Sprinter",
//                   carColor: "Белый",
//                   carNumber: "8888-2",
//                   phoneNumber: "+375 29 566 47 58",
//                   raiting: "4.84",
//                   fullName: "Антонов Сергей Петрович",
//                   photo: "avatar2")),
//
//    Trip(date: Date(), startCity: "Полоцк", startStaition: "ЖД вокзал",
//         finishCity: "Минск", finishStaition: "ЭкспоБел",
//         tripStatus: .reserved, countPasseger: 1,
//         driver: Driver(carModel: "Mercedes Sprinter",
//                        carColor: "Белый",
//                        carNumber: "8888-2",
//                        phoneNumber: "+375 29 566 47 58",
//                        raiting: "4.84",
//                        fullName: "Васильев Денис Петрович",
//                        photo: "avatar")),
//
//    Trip(date: Date(), startCity: "Полоцк", startStaition: "ЖД вокзал",
//         finishCity: "Минск", finishStaition: "ЭкспоБел",
//         tripStatus: .complition, countPasseger: 3,
//         driver: Driver(carModel: "Mercedes Sprinter",
//                        carColor: "Белый",
//                        carNumber: "8888-2",
//                        phoneNumber: "+375 29 566 47 58",
//                        raiting: "4.84",
//                        fullName: "Сидорчук Павел Максимович",
//                        photo: "avatar2")),
//
//]

class CitySrore {
    
    static let shared = CitySrore()
    private init() {}
    
    private let cities: [City] = [
    City(name: "Минск",
         staition: ["ст. метро Первомайская", "ЖД Вокзал", "Площадь Я. Коласа", "Барисовский тракт", "Экспобел", "Боровая", "Силичи" ]),
    City(name: "Новополоцк",
         staition: ["Слободская", "Гайдра", "1-я палатка", "Золотая нива", "Кинотеатр Космос", "Гостиница Беларусь", "Строительная", " Молодежная", "Комсмомольская", "Музыкальная школа", "Кинотеатр Минск", "Гостиница Нафтан", "Измеритель", "Подкасельцы", "Василевцы", "8-ой микрорайон", "Полим. коттеджи", "Солнечная", "Луговая" ]),
    
    City(name: "Полоцк",
         staition: ["Развилка", "Кадетское училище", "23 гвардейцев", "Селянская", "Кульнева", "Юбилейная", "Автовокзал", "Дом быта", "Экономический колледж", "Олимпиец", "Дзюдо", "Энергосбыт", "Заполотье", "Минское шоссе"]),
    
    City(name: "Населенные пункты",
         staition: ["Бельчица", "Тросно", "Семенец", "Заозерье", "Межно", "Суя", "Плусы", "Щаты", "Гомель", "Святица", "Бикульничи", "Липовки", "Шнитки", "Сорочино", "Завечелье", "Мосар", "Завыдрино", ]),
    ]
    
    func getCities() -> [City] {
        return cities
    }
}


class TimeStore {
    
    static let shared = TimeStore()
    private init() {}
    
    private let times: [Time] = [
    Time(hour: "06", countPassager: 16),
    Time(hour: "07", countPassager: 16),
    Time(hour: "08", countPassager: 16),
    Time(hour: "09", countPassager: 1),
    Time(hour: "10", countPassager: 8),
    Time(hour: "11", countPassager: 2),
    Time(hour: "12", countPassager: 1),
    Time(hour: "13", countPassager: 0),
    Time(hour: "14", countPassager: 8),
    Time(hour: "15", countPassager: 4),
    Time(hour: "16", countPassager: 2),
    Time(hour: "17", countPassager: 0),
    Time(hour: "18", countPassager: 1),
    Time(hour: "19", countPassager: 0),
    Time(hour: "20", countPassager: 8),
    ]
    
    func getTime() -> [Time] {
        return times
    }
    
}
