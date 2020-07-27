//
//  MusicLoadingFooterCollectionReusableView.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class MusicLoadingFooterCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "MusicLoadingFooterCollectionReusableView"
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private lazy var loadingMoreLabel: UILabel = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadingMoreLabel.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubviews: [
            activityIndicatorView,
            loadingMoreLabel
        ], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
