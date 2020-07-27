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
    
    private lazy var blurVisualEffectView: UIVisualEffectView = {
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        return blurVisualEffectView
    }()
    
    var startingFrame: CGRect?
    var appFullscreenController: AppFullscreenTableViewController!
    
    var anchoredConstraints: AnchoredConstraints?
    
    static let cellSize: CGFloat = 500
    
    var items = [TodayItem]()
    
    private var appFullscreenBeginOffset: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        blurVisualEffectView.alpha = 0
        
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
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed?.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed?.results ?? []),
                
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed?.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed?.results ?? []),
                
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: [])
            ]
            
            self?.collectionView.reloadData()
        }
    }
    
    private func showDailyListFullscreen(_ indexPath: IndexPath) {
        let todayMultipleAppsCollectionViewController = TodayMultipleAppsCollectionViewController(mode: .fullscreen)
        todayMultipleAppsCollectionViewController.apps = items[indexPath.item].apps
        let todayMultipleAppsCollectionNavigationController = BackEnabledNavigationController(rootViewController: todayMultipleAppsCollectionViewController)
        todayMultipleAppsCollectionNavigationController.modalPresentationStyle = .fullScreen
        present(todayMultipleAppsCollectionNavigationController, animated: true)
    }
    
    private func setupAppFullscreenController(_ indexPath: IndexPath) {
        let appFullscreenController = AppFullscreenTableViewController()
        appFullscreenController.item = items[indexPath.row]
        appFullscreenController.dismissHandler = {
            self.handleAppFullscreenDismissal()
        }
        appFullscreenController.view.layer.cornerRadius = 16
        self.appFullscreenController = appFullscreenController
        
        // #1 setup our pan gesture
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag(_:)))
        gesture.delegate = self
        appFullscreenController.view.addGestureRecognizer(gesture)
        
        // #2 add a blur effect
        
        
        // #3 not to interfere with our UITableView scrolling
    }
    
    private func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
    }
    
    private func setupAppFullscreenStartingPosition(_ indexPath: IndexPath) {
        let fullscreenView = appFullscreenController.view!
        view.addSubview(fullscreenView)
        
        addChild(appFullscreenController)
        
        self.collectionView.isUserInteractionEnabled = false
        
       setupStartingCellFrame(indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        
        // auto layout constraint animations
        self.anchoredConstraints = fullscreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()
    }
    
    private func beginAnimationAppFullscreen() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.blurVisualEffectView.alpha = 1
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.size.width
            self.anchoredConstraints?.height?.constant = self.view.frame.size.height
            
            self.view.layoutIfNeeded()
            
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AppFullScreenHeaderTableViewCell else { return }
            
            cell.todayCellTopConstraint = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    private func showSingleAppFullscreen(_ indexPath: IndexPath) {
        // #1 setup single app fullscreen
        setupAppFullscreenController(indexPath)
        
        // #2 setup fullscreen in its starting position
        setupAppFullscreenStartingPosition(indexPath)
        
        // #3 begin the fullscreen animation
        beginAnimationAppFullscreen()
        
    }
    
    @objc private func handleAppFullscreenDismissal() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.blurVisualEffectView.alpha = 0
            self.appFullscreenController.view.transform = .identity
            
            //self.appFullScreenController.tableView.tableView.contentOffset = .zero
            self.appFullscreenController.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = startingFrame.width
            self.anchoredConstraints?.height?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AppFullScreenHeaderTableViewCell else { return }
//            cell.dismissCloseButtonAlpha = 0
            self.appFullscreenController.dismissCloseButtonAlpha = 0
            cell.todayCellTopConstraint = 24
            cell.layoutIfNeeded()
            
        }) { _ in
            self.appFullscreenController.view?.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
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
    
    @objc private func handleDrag(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            appFullscreenBeginOffset = appFullscreenController.tableView.contentOffset.y
        }
        if appFullscreenController.tableView.contentOffset.y > 0 {
            return
        }
        let translationY = sender.translation(in: appFullscreenController.view).y
//        print(translationY)
        if sender.state == .changed {
            if translationY > 0 {
                let trueOffset = translationY - appFullscreenBeginOffset
                var scale = 1 - trueOffset / 1000
//                print(trueOffset, scale)
                scale = min(1, scale)
                scale = max(0.5, scale)
                
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                self.appFullscreenController.view.transform = transform
            }
            
        } else if sender.state == .ended {
            if translationY > 0 {
                handleAppFullscreenDismissal()
            }
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
        switch items[indexPath.item].cellType {
        case .single:
            showSingleAppFullscreen(indexPath)
        case .multiple:
            showDailyListFullscreen(indexPath)
        }
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

//MARK: - UIGestureRecognizerDelegate
extension TodayCollectionViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
