//
//  MusicCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

// 1. Implement Cell
// 2. Implement footer for loader view

class MusicCollectionViewController: BaseListCollectionViewController {
    
    private let searchTerm: String = "taylor"
    var results = [Results]()
    var isPaginating = false
    var isDonePaginating = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: TrackCollectionViewCell.identifier)
        collectionView.register(MusicLoadingFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MusicLoadingFooterCollectionReusableView.identifier)
        collectionView.showsVerticalScrollIndicator = false
        
        fetchData()
    }
    
    private func fetchData() {
        let urlString = "http://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        Service.shared.fetchGenericJSONData(urlString: urlString) { [weak self] (searchResults: SearchResult?, error: Service.ServiceError?) in
            if let error = error {
                print(error)
                return
            }
            guard let results = searchResults?.results else { return }
            self?.results = results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension MusicCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MusicLoadingFooterCollectionReusableView.identifier, for: indexPath) as! MusicLoadingFooterCollectionReusableView
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: collectionView.frame.size.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionViewCell.identifier, for: indexPath) as! TrackCollectionViewCell
        cell.track = results[indexPath.item]
        
        // initiate pagination
        if indexPath.item == (results.count - 1) && !isPaginating {
            print("Fetch more data")
            isPaginating = true
            let urlString = "http://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            Service.shared.fetchGenericJSONData(urlString: urlString) { [weak self] (searchResults: SearchResult?, error: Service.ServiceError?) in
                if let error = error {
                    print(error)
                    return
                }
                
                if searchResults?.results?.count == 0 {
                    self?.isDonePaginating = true
                }
                
                sleep(2)
                
                guard let results = searchResults?.results else { return }
                self?.results += results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                self?.isPaginating = false
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MusicCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width), height: 100)
    }
}
