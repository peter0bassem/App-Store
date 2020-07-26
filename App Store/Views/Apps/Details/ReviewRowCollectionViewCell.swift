//
//  ReviewRowCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class ReviewRowCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ReviewRowCollectionViewCell"
    
    private lazy var reviewsLabel: UILabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    private lazy var reviewsCollectionViewController = ReviewsCollectionViewController()
    
    var reviews: Reviews! {
        didSet {
            reviewsCollectionViewController.reviews = reviews
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewsLabel)
        addSubview(reviewsCollectionViewController.view)

        reviewsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        reviewsCollectionViewController.view.anchor(top: reviewsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
