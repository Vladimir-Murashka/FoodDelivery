//
//  SceneDelegate.swift
//  FoodDelivery
//
//  Created by Swift Learning on 17.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupRootViewController(windowScene: windowScene)
    }
    
    func setupRootViewController(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let viewController = TabBarController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

