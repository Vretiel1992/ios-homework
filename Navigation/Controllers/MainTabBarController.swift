//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Антон Денисюк on 20.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        setupTabBar()
    }
    
    private func setupTabBar() {
        let feedViewController = createNavController(vc: FeedViewController(), itemName: "Лента", itemImage: "house")
        
        let profileViewController = createNavController(vc: ProfileViewController(), itemName: "Профиль", itemImage: "person.circle")
        profileViewController.navigationBar.prefersLargeTitles = false
        
        viewControllers = [feedViewController, profileViewController]
    }
    
    private func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = item
        return navController
    }
}

