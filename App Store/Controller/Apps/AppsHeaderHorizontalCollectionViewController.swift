//
//  AppsHeaderHorizontalCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalCollectionViewController: HorizontalSnappingCollectionViewController {
    
    var socialApps = [SocialApp]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: AppsHeaderCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension AppsHeaderHorizontalCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderCollectionViewCell.identifier, for: indexPath) as! AppsHeaderCollectionViewCell
        cell.socialApp = socialApps[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppsHeaderHorizontalCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 48), height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
