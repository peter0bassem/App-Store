//
//  BaseTabBarViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    
    /*
     3 - maybe introduce AppSearchController
     */

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewControllers = [
            
            createNavigationController(viewController: AppsSearchCollectionViewController(), title: "Search", imageName: "search"),
            createNavigationController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavigationController(viewController: UIViewController(), title: "Apps", imageName: "apps")
        ]
    }
    
    fileprivate func createNavigationController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        viewController.title = title
        viewController.view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: imageName)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
