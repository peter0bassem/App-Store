//
//  TodayItem.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    let apps: [GamesResults]
    
    enum CellType: String {
        case single, multiple
    }
}
