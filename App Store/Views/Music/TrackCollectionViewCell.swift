//
//  TrackCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TrackCollectionViewCell"
    
    private lazy var imageView: UIImageView = UIImageView(cornerRadius: 16)
    private lazy var nameLabel: UILabel = UILabel(text: "Track name", font: .boldSystemFont(ofSize: 18))
    private lazy var subtitleLabel: UILabel = UILabel(text: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    var track: Results! {
        didSet {
            imageView.sd_setImage(with: URL(string: track.artworkUrl100 ?? ""))
            nameLabel.text = track.trackName ?? ""
            subtitleLabel.text = "\(track.artistName ?? "") • \(track.collectionName ?? "")"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constrainWidth(constant: 80)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel,
                subtitleLabel
            ], spacing: 4)
        ], customSpacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
