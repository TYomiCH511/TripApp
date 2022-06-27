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
        
        guard let _ = (scene as? UIWindowScene) else { return }
        //let window = UIWindow(windowScene: scene)
        //let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
//        if Auth.auth().currentUser != nil {
//            let tabBarController = ViewControllers.TabBarViewController.rawValue
//            guard let tabBarVC = storyBoard.instantiateViewController(withIdentifier: tabBarController) as? TabBarViewController else { return }
//            window.rootViewController = tabBarVC
//
//        } else {
            
            // let loginController = ViewControllers.LoginNavigationController.rawValue
           // let loginVC = storyBoard.instantiateViewController(withIdentifier: loginController)
           // window.rootViewController = loginVC
            //loginVcExist = true
        
        
        //window.makeKeyAndVisible()
        //self.window = window
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

