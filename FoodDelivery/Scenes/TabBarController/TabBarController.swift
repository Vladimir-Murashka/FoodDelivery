//
//  TabBarController.swift
//  FoodDelivery
//
//  Created by Swift Learning on 17.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
}

private extension TabBarController {
    func setupTabBarController() {
        let menuViewController = MenuViewController()
        let contactViewController = ContactViewController()
        let profileViewController = ProfileViewController()
        let orderViewController = OrderViewController()
        
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        let contactNavigationController = UINavigationController(rootViewController: contactViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        let orderNavigationController = UINavigationController(rootViewController: orderViewController)
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13, weight: .regular)],
            for: .normal
        )
        
        menuNavigationController.tabBarItem.title = "Меню"
        menuNavigationController.tabBarItem.image = UIImage(named: "Menu")

        contactNavigationController.tabBarItem.title = "Контакты"
        contactNavigationController.tabBarItem.image = UIImage(named: "Contact")

        profileNavigationController.tabBarItem.title = "Профиль"
        profileNavigationController.tabBarItem.image = UIImage(named: "Profile")

        orderNavigationController.tabBarItem.title = "Корзина"
        orderNavigationController.tabBarItem.image = UIImage(named: "Order")
        
        tabBar.tintColor = UIColor(named: "TabBarTintColor")
        tabBar.backgroundColor = UIColor(named: "TabBarBackgroundColor")
        tabBar.unselectedItemTintColor = UIColor(named: "unselectedItemTintColor")
        
        viewControllers = [
            menuNavigationController,
            contactNavigationController,
            profileNavigationController,
            orderNavigationController
        ]
    }
}
