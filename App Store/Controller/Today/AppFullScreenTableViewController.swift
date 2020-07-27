//
//  AppFullScreenTableViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppFullScreenTableViewController: UITableViewController {
    
    var dismissHandler: (()->Void)?
    
    var item: TodayItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let statusBarHeight = (UIApplication.shared.windows.filter { $0.isKeyWindow } .first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero).height
        tableView.contentInset = .init(top: 0, left: 0, bottom: statusBarHeight, right: 0)
        tableView.showsVerticalScrollIndicator = false
    }
}

extension AppFullScreenTableViewController {
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = TodayCollectionViewCell()
//        return headerView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 450
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = AppFullScreenHeaderTableViewCell()
            headerCell.item = item
            headerCell.disableCornerRadius = true
            headerCell.closeButtonPressed = { [weak self] in
                self?.dismissHandler?()
            }
            return headerCell
        }
        let cell = AppFullScreenDescriptionTableViewCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayCollectionViewController.cellSize
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
