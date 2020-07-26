//
//  Reviews.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import Foundation

struct Reviews: Codable {
    let feed: ReviewFeed
}

struct ReviewFeed: Codable {
    let entry: [Entry]
}

struct Entry: Codable {
    let author: Author
    let title: Label
    let content: Label
    
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Author: Codable {
    let name: Label
    
}

struct Label: Codable {
    let label: String
}
