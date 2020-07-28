//
//  ScreenshotCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit
import SDWebImage

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "ScreenshotCollectionViewCell"
    
    private lazy var imageView: UIImageView = UIImageView(cornerRadius: 12)
    
    var imageUrlString: String! {
        didSet {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: URL(string: imageUrlString))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
