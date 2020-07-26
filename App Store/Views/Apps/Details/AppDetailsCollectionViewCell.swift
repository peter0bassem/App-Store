//
//  AppDetailsCollectionViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AppDetailsCollectionViewCell"
    
    private lazy var appIconImageView: UIImageView = UIImageView(cornerRadius: 16)
    private lazy var nameLabel: UILabel = UILabel(text: "App name", font: .systemFont(ofSize: 24, weight: .bold), numberOfLines: 2)
    private lazy var priceButton: UIButton = UIButton(title: "$4.99")
    private lazy var whatsNewLabel: UILabel = UILabel(text: "What's new", font: .systemFont(ofSize: 20, weight: .bold))
    private lazy var releaseNotesLabel: UILabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    var app: Results! {
        didSet {
            guard let app = app else { return }
            appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100 ?? ""))
            nameLabel.text = app.trackName ?? ""
            priceButton.setTitle(app.formattedPrice ?? "", for: .normal)
            releaseNotesLabel.text = app.releaseNotes ?? ""
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.backgroundColor = .red
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        priceButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 0.937254902, alpha: 1)
        priceButton.constrainHeight(constant: 32)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.constrainWidth(constant: 80)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [
                    nameLabel,
                    UIStackView(arrangedSubviews: [
                        priceButton,
                        UIView()]),
                    UIView()
                ], spacing: 12)
            ], customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
