//
//  AppDelegate.swift
//  TripApp
//
//  Created by Artem on 8.06.22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UserStore.shared.firstStartApp()
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

    
    func applicationWillTerminate(_ application: UIApplication) {
        if isChangePassword {
            AuthManager.shared.singout()
        }
    }

}

