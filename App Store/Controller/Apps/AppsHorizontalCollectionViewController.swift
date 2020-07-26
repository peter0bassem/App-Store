//
//  AppsHorizontalCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppsHorizontalCollectionViewController: HorizontalSnappingCollectionViewController {

    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    var appGroup: AppGroup?
    
    var selectedIndex: Int!
    var didSelectHandler: ((GamesResults) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCollectionViewCell.self, forCellWithReuseIdentifier: AppRowCollectionViewCell.identifer)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension AppsHorizontalCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed?.results?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCollectionViewCell.identifer, for: indexPath) as! AppRowCollectionViewCell
        cell.result = appGroup?.feed?.results?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let containerView = view.superview as? AppsGroupCollectionViewCell {
            containerView.selectedIndex = indexPath.item
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppsHorizontalCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.size.height - (2 * topBottomPadding) - (2 * lineSpacing)) / 3
        return CGSize(width: (collectionView.frame.size.width - 48), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: 12, right: 0)
    }
}
