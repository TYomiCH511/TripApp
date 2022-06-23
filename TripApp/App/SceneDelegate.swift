//
//  SceneDelegate.swift
//  TripApp
//
//  Created by Artem on 8.06.22.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        if Auth.auth().currentUser != nil {
            guard let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabBar") as? TabBarViewController else { return }
            window.rootViewController = tabBarVC
            
        } else {
            
            guard let loginVC = storyBoard.instantiateViewController(withIdentifier: "login") as? LoginViewController else { return }
            window.rootViewController = loginVC
        }
        
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

