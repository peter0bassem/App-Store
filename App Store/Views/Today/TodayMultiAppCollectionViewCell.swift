//
//  TodayMultiAppTableViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class TodayMultiAppCollectionViewCell: BaseTodayCollectionViewCell {
    
    static let identifier = "TodayMultiAppCollectionViewCell"
    
    private lazy var categoryLabel: UILabel = UILabel(text: "LIFE HACK", font: .systemFont(ofSize: 20, weight: .bold))
    private lazy var titleLabel: UILabel = UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 32, weight: .bold), numberOfLines: 2)
    private lazy var multipleAppsCollectionViewController = TodayMultipleAppsCollectionViewController(mode: .small)
    
    override var item: TodayItem! {
        didSet {
            categoryLabel.text = item.category
            titleLabel.text = item.title
            multipleAppsCollectionViewController.apps = item.apps
            multipleAppsCollectionViewController.collectionView.reloadData()
        }
    }
    var addTapGesture: UITapGestureRecognizer? {
        didSet {
            guard let addTapGesture = addTapGesture else { return }
            multipleAppsCollectionViewController.collectionView.addGestureRecognizer(addTapGesture)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppsCollectionViewController.view
        ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
