//
//  AppsHeaderCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit
import SDWebImage

class AppsHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AppsHeaderCollectionViewCell"
    
    private lazy var companyLabel: UILabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    private lazy var titleLabel: UILabel = UILabel(text: "Keeping up with firends is faster than ever", font: .systemFont(ofSize: 24))
    private lazy var imageView: UIImageView = UIImageView(cornerRadius: 8)
    
    var socialApp: SocialApp! {
        didSet {
            companyLabel.text = socialApp.name ?? ""
            titleLabel.text = socialApp.tagline ?? ""
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: URL(string: socialApp.imageUrl ?? ""))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        
//        imageView.image = #imageLiteral(resourceName: "holiday")
        
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
