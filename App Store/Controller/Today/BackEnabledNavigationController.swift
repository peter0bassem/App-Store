//
//  BackEnabledNavigationController.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
}

extension BackEnabledNavigationController: UIGestureRecognizerDelegate {
 
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
