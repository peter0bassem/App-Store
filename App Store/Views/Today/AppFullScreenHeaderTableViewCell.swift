//
//  AppFullScreenHeaderTableViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppFullScreenHeaderTableViewCell: UITableViewCell {
    
    let identifer = "AppFullScreenHeaderTableViewCell"
    
    private lazy var todayCell = TodayCollectionViewCell()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    var closeButtonPressed: (() -> Void)?
    var item: TodayItem! {
        didSet {
            todayCell.item = item
        }
    }
    var disableCornerRadius: Bool? {
        didSet {
            if disableCornerRadius == true {
                todayCell.layer.cornerRadius = 0
            }
        }
    }
    var todayCellTopConstraint: CGFloat? {
        didSet {
            todayCell.topConstraint.constant = todayCellTopConstraint ?? 0.0
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.fillSuperview()
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapCloseButton(_ sender: UIButton) {
        sender.isHidden = true
        closeButtonPressed?()
    }
}
