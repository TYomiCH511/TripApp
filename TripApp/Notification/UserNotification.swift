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
    
    func createNotification(withTitle title: String, body: String, identifier: String) {
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.subtitle = "subtitle"
        content.body = body
        content.sound = .default
        content.badge = 1
        //let date = Date(timeIntervalSinceNow: -)
        //let trigerreDate = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: <#T##Date#>)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        
        
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
