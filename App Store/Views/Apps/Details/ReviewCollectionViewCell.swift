//
//  ReviewCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ReviewCollectionViewCell"
    
    private lazy var titleLabel: UILabel = UILabel(text: "Review title", font: .boldSystemFont(ofSize: 18))
    private lazy var authorLabel: UILabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    private lazy var starsStackView: UIStackView = {
        var arrangedViews = [UIView]()
        (0..<5).forEach { _ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedViews.append(imageView)
        }
        arrangedViews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedViews)
        return stackView
    }()
    
    private lazy var bodyLabel: UILabel = UILabel(text: "Review body \nReview body \nReview body", font: .systemFont(ofSize: 18), numberOfLines: 6)
    
    var entry: Entry! {
        didSet {
            titleLabel.text = entry.title.label
            authorLabel.text = entry.author.name.label
            for (index, view) in starsStackView.arrangedSubviews.enumerated() {
                if  let ratingInt = Int(entry.rating.label) {
                    view.alpha = index >= ratingInt ? 0 : 1
                }
            }
            bodyLabel.text = entry.content.label
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        titleLabel.textColor = .black
        authorLabel.textColor = .lightGray
        bodyLabel.textColor = .black
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel, authorLabel
            ], customSpacing: 8),
            starsStackView,
            bodyLabel
        ], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
