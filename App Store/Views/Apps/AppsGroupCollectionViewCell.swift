//
//  AppsGroupCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppsGroupCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "AppsGroupCollectionViewCell"
    
    private lazy var titleLabel = UILabel(text: "App Section", font: .systemFont(ofSize: 30, weight: .bold))
    
    private lazy var horizontalViewController = AppsHorizontalCollectionViewController()
    
    var appGroup: AppGroup? {
        didSet {
            titleLabel.text = appGroup?.feed?.title ?? ""
            horizontalViewController.appGroup = appGroup
            horizontalViewController.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalViewController.view)
        horizontalViewController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
