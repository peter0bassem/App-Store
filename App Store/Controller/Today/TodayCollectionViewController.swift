//
//  TodayCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class TodayCollectionViewController: BaseListCollectionViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var startingFrame: CGRect?
    var appFullScreenController: AppFullScreenTableViewController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    static let cellSize: CGFloat = 500
    
    var items = [TodayItem]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        
        fetchData()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultiAppCollectionViewCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            if let error = error {
                print(error)
                return
            }
            topGrossingGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            if let error = error {
                print(error)
                return
            }
            gamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.activityIndicator.stopAnimating()
            
            self?.items = [
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed?.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed?.results ?? []),
                
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed?.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed?.results ?? []),
                
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: [])
            ]
            
            self?.collectionView.reloadData()
        }
    }
    
    @objc private func handleRemoveRedView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            //self.appFullScreenController.tableView.tableView.contentOffset = .zero
            self.appFullScreenController.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            
            // this frame code is bad
            //            gesture.view?.frame = self.startingFrame ?? .zero
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AppFullScreenHeaderTableViewCell else { return }
            
            cell.todayCellTopConstraint = 24
            cell.layoutIfNeeded()
            
        }) { _ in
            self.appFullScreenController.view?.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    
    @objc private func handleMultipleAppsTap(_ sender: UIGestureRecognizer) {
        let collectionView = sender.view
        
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayMultiAppCollectionViewCell {
                
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let apps = self.items[indexPath.item].apps
                
                let todayMultipleAppsCollectionViewController = TodayMultipleAppsCollectionViewController(mode: .fullscreen)
                todayMultipleAppsCollectionViewController.apps = apps
                let todayMultipleAppsCollectionNavigationController = BackEnabledNavigationController(rootViewController: todayMultipleAppsCollectionViewController)
                todayMultipleAppsCollectionNavigationController.modalPresentationStyle = .fullScreen
                present(todayMultipleAppsCollectionNavigationController, animated: true)
                return
            }
            superView = superView?.superview
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension TodayCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCollectionViewCell
        cell.item = items[indexPath.item]
        
        (cell as? TodayMultiAppCollectionViewCell)?.addTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap(_:)))
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multiple {
            let todayMultipleAppsCollectionViewController = TodayMultipleAppsCollectionViewController(mode: .fullscreen)
            todayMultipleAppsCollectionViewController.apps = items[indexPath.item].apps
            let todayMultipleAppsCollectionNavigationController = BackEnabledNavigationController(rootViewController: todayMultipleAppsCollectionViewController)
            todayMultipleAppsCollectionNavigationController.modalPresentationStyle = .fullScreen
            present(todayMultipleAppsCollectionNavigationController, animated: true)
            return
        }
        let appFullScreenController = AppFullScreenTableViewController()
        appFullScreenController.item = items[indexPath.row]
        appFullScreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        let fullscreenView = appFullScreenController.view!
        view.addSubview(fullscreenView)
        
        addChild(appFullScreenController)
        
        self.appFullScreenController = appFullScreenController
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        // auto layout constraint animations
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        self.topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        self.leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        self.widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        self.heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach { $0?.isActive = true }
        self.view.layoutIfNeeded()
        
        fullscreenView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.size.width
            self.heightConstraint?.constant = self.view.frame.size.height
            
            self.view.layoutIfNeeded()
            
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AppFullScreenHeaderTableViewCell else { return }
            
            cell.todayCellTopConstraint = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TodayCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 64), height: TodayCollectionViewController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
