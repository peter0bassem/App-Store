//
//  AppRowCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit
import SDWebImage

class AppRowCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "AppRowCollectionViewCell"
    
    private lazy var imageView: UIImageView = UIImageView(cornerRadius: 8)
    private lazy var nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    private lazy var companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    private lazy var getButton: UIButton = UIButton(title: "GET")
    
    var result: GamesResults! {
        didSet {
            imageView.sd_setImage(with: URL(string: result.artworkUrl100 ?? ""))
            nameLabel.text = result.name ?? ""
            companyLabel.text = result.artistName ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .purple
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        companyLabel.textColor = .lightGray
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32 / 2
        getButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 0.95)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        stackView.alignment = .center
        stackView.spacing = 16
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
