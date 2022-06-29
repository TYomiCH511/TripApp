//
//  UserNotification.swift
//  TripApp
//
//  Created by Artem on 29.06.22.
//

import Foundation
import UserNotifications

class UserNotification: NSObject, UNUserNotificationCenterDelegate {
    
    let notification = UNUserNotificationCenter.current()
    
    func requestAutorization() {
        notification.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            guard granted else { return }
            self.getNotificationSetting()
        }
    }
    
    private func getNotificationSetting() {
        notification.getNotificationSettings { settings in
            print(settings)
        }
    }
    
    func createNotification(withTitle title: String, body: String, identifier: String, dateTrip: Date) {
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.subtitle = "subtitle"
        content.body = body
        content.sound = .default
        content.badge = 1
        
        let date = CustomDate.shared.dateReservedTripNotification(dateTrip: dateTrip)
        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        print(trigger.description)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notification.add(request) { error in
            guard error != nil else { return }
            print(error!.localizedDescription)
        }
    }
    
    func removeNotification(identifire: String) {
        notification.removePendingNotificationRequests(withIdentifiers: [identifire])
    }
    
}
