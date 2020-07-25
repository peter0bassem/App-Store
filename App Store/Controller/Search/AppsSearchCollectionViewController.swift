//
//  AppsSearchCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppsSearchCollectionViewController: BaseListCollectionViewController {
    
    private var appResults = [Results]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search item above"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        setupSearchBar()
        //        fetchItunesApps(searchItem: "Twitter")
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        searchController.searchBar.tintColor = view.tintColor
        searchController.obscuresBackgroundDuringPresentation  = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func fetchItunesApps(searchItem: String) {
        Service.shared.fetchApps(searchItem: searchItem) { [weak self] (searchResults, serviceError) in
            if let serviceError = serviceError {
                switch serviceError {
                case .failedToFetchData(let error):
                    print("Failed to fetch data:", error)
                case .decodeError(let error):
                    print("decoding error:", error)
                }
            }
            guard let results = searchResults?.results, !results.isEmpty else {
                DispatchQueue.main.async {
                    self?.enterSearchTermLabel.text = "No Results avalilable."
                }
                return
            }
            self?.appResults = results
            DispatchQueue.main.async {
                self?.enterSearchTermLabel.text = nil
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for:
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

//MARK: - UISearchBarDelegate
extension AppsSearchCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] (_) in
            self?.searchController.searchBar.endEditing(true)
            self?.fetchItunesApps(searchItem: searchText)
        }
    }
}
