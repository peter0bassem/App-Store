//
//  AppsCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppsPageCollectionViewController: BaseListCollectionViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private var socialApps = [SocialApp]()
    private var groups = [AppGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: AppsGroupCollectionViewCell.identifer)
        collectionView.register(AppsPageHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsPageHeaderCollectionReusableView.identifier)
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        
        fetchData()
    }
    
    private func fetchData() {
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            dispatchGroup.leave()
            if let error = error {
                switch error {
                case .failedToFetchData(error: let error):
                    print("Failed to fetch data:", error)
                case .decodeError(error: let error):
                    print("Failed to decode data:", error)
                }
            }
            group1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            dispatchGroup.leave()
            if let error = error {
                switch error {
                case .failedToFetchData(error: let error):
                    print("Failed to fetch data:", error)
                case .decodeError(error: let error):
                    print("Failed to decode data:", error)
                }
            }
            group2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree { (appGroup, error) in
            dispatchGroup.leave()
            if let error = error {
                switch error {
                case .failedToFetchData(error: let error):
                    print("Failed to fetch data:", error)
                case .decodeError(error: let error):
                    print("Failed to decode data:", error)
                }
            }
            group3 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { [weak self] (socialApps, error) in
            dispatchGroup.leave()
            if let error = error {
                switch error {
                case .failedToFetchData(error: let error):
                    print("Failed to fetch data:", error)
                case .decodeError(error: let error):
                    print("Failed to decode data:", error)
                }
            }
            self?.socialApps = socialApps ?? []
            DispatchQueue.main.async {
            }
        }
        
        //completion
        dispatchGroup.notify(queue: .main) { [weak self] in
            if let group = group1 {
                self?.groups.append(group)
            }
            if let group = group2 {
                self?.groups.append(group)
            }
            if let group = group3 {
                self?.groups.append(group)
            }
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension AppsPageCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsPageHeaderCollectionReusableView.identifier, for: indexPath) as! AppsPageHeaderCollectionReusableView
        header.socialApps = socialApps
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCollectionViewCell.identifer, for: indexPath) as! AppsGroupCollectionViewCell
        cell.appGroup = groups[indexPath.item]
        cell.didSelection = { [weak self] feedResult in
            let appDetailsCollectionViewController = AppDetailsCollectionViewController(appId: feedResult.id ?? "")
            appDetailsCollectionViewController.title = feedResult.name ?? ""
            self?.navigationController?.pushViewController(appDetailsCollectionViewController, animated: true)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppsPageCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
