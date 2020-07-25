//
//  BaseTabBarViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .white
        redViewController.navigationItem.title = "Apps"

        let redNavigationController = UINavigationController(rootViewController: redViewController)
        redNavigationController.tabBarItem.title = "Apps"
        redNavigationController.tabBarItem.image = #imageLiteral(resourceName: "apps")
        redNavigationController.navigationBar.prefersLargeTitles = true
        
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .white
        blueViewController.navigationItem.title = "Search"
        
        let blueNavigationController = UINavigationController(rootViewController: blueViewController)
        blueNavigationController.tabBarItem.title = "Search"
        blueNavigationController.tabBarItem.image = #imageLiteral(resourceName: "search")
        blueNavigationController.navigationBar.prefersLargeTitles = true
        
//        tabBar.tintColor = .yellow // changs image and title color
//        tabBar.barTintColor = .green // changes tabar background color
        
        viewControllers = [
            redNavigationController,
            blueNavigationController
        ]
    }
}
