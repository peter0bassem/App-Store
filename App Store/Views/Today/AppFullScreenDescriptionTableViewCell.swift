//
//  AppFullScreenDescriptionTableViewCell.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppFullScreenDescriptionTableViewCell: UITableViewCell {

    static let identifier = "AppFullScreenDescriptionTableViewCell"
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
