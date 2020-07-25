//
//  AppsSearchCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppsSearchCollectionViewController: UICollectionViewController {
    
    fileprivate let cellId = "id1234"
    
    private var appResults = [Result]()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchItunesApps()
    }
    
    // 2 - Extract this function `fetchItunesApps()` outside of this controller file
    
    fileprivate func fetchItunesApps() {
        Service.shared.fetchApps { [weak self] (reults, error) in
            if let error = error as? ServiceError {
                switch error {
                case .failedToFetchData(_):
                    print("Faile to fetch data:")
                case .decodeError(_):
                    print("decoding error")
                }
            }
            guard let reults = reults else { return }
            self?.appResults = reults
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegete
extension AppsSearchCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for:
            indexPath) as! SearchResultCollectionViewCell
        cell.appResult = appResults[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppsSearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 350)
    }
}
