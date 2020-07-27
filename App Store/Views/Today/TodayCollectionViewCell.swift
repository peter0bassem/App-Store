//
//  TodayCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class TodayCollectionViewCell: BaseTodayCollectionViewCell {
    
    static let identifier = "TodayCollectionViewCell"
    
    private lazy var categoryLabel: UILabel = UILabel(text: "LIFE HACK", font: .systemFont(ofSize: 20, weight: .bold))
    private lazy var titleLabel: UILabel = UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 28, weight: .bold))
    private lazy var imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    private lazy var descriptionLabel: UILabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    override var item: TodayItem! {
        didSet {
            categoryLabel.text = item.category
            titleLabel.text = item.title
            imageView.image = item.image
            descriptionLabel.text = item.description
            
            backgroundColor = item.backgroundColor
            backgroundView?.backgroundColor = item.backgroundColor
        }
    }
    var topConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            imageContainerView,
            descriptionLabel
        ], spacing: 8)
        addSubview(stackView)
        
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint?.isActive = true
        
//        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
