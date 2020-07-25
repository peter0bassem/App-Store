//
//  AppsPageHeaderCollectionReusableView.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppsPageHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "AppsPageHeaderCollectionReusableView"
    
    private lazy var appHeaderHorizontalCollectionViewController = AppsHeaderHorizontalCollectionViewController()
    
    var socialApps: [SocialApp]? {
        didSet {
            appHeaderHorizontalCollectionViewController.socialApps = socialApps ?? []
            appHeaderHorizontalCollectionViewController.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appHeaderHorizontalCollectionViewController.view)
        appHeaderHorizontalCollectionViewController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
