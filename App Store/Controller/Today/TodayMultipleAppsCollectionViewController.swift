//
//  TodayMultipleAppsCollectionViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class TodayMultipleAppsCollectionViewController: BaseListCollectionViewController {

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private let spacing: CGFloat = 16
    
    var apps = [GamesResults]()
    
    enum Mode {
        case small, fullscreen
    }
    
    private let mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if mode == .fullscreen {
            setupCloseButton()
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            collectionView.isScrollEnabled = false
        }
        
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCollectionViewCell.self, forCellWithReuseIdentifier: MultipleAppCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }
    
    @objc private func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension TodayMultipleAppsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return apps.count
        }
        return min(4, apps.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleAppCollectionViewCell.identifier, for: indexPath) as! MultipleAppCollectionViewCell
        cell.result = apps[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = apps[indexPath.item].id ?? ""
        let appDetailsCollectionViewController = AppDetailsCollectionViewController(appId: appId)
        navigationController?.pushViewController(appDetailsCollectionViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TodayMultipleAppsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 3 * spacing: becase there are 3 spacings between 4 cells
        // / 4: because there are 4 cells
//        let height: CGFloat = (collectionView.frame.size.height - (3 * spacing)) / 4
        let height: CGFloat = 68
        if mode == .fullscreen {
            return CGSize(width: (collectionView.frame.size.width - 48), height: height)
        }
        return CGSize(width: (collectionView.frame.size.width), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
    }
}
