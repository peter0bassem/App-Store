//
//  AppsCompositionalView.swift
//  App Store
//
//  Created by Peter Bassem on 7/27/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import SwiftUI

class CompositionalController: UICollectionViewController {
    
    private var socialApps = [SocialApp]()
    var games: AppGroup?
    var topGrossingApps: AppGroup?
    var freeApps: AppGroup?
    
    init() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                return CompositionalController.topSection()
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                ]
                
                return section
            }
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class CompositionalHeader: UICollectionReusableView {
        
        static let identifier = "CompositionalHeader"
        
        private lazy var label = UILabel(text: "Editor's Choice Games", font: .boldSystemFont(ofSize: 32))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(label)
            label.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CompositionalHeader.identifier)
        collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: AppsHeaderCollectionViewCell.identifier)
        collectionView.register(AppRowCollectionViewCell.self, forCellWithReuseIdentifier: AppRowCollectionViewCell.identifer)
        
        fetchAppsDispatchGroup()
    }
    
    static func topSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(300)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 16
        return section
    }
    
    func fetchAppsDispatchGroup() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            self.games = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, err) in
            self.topGrossingApps = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json") { (appGroup, err) in
            self.freeApps = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, err) in
            dispatchGroup.leave()
            self.socialApps = apps ?? []
        }
        
        // completion
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CompositionalHeader.identifier, for: indexPath) as! CompositionalHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return socialApps.count
        case 1: return games?.feed?.results?.count ?? 0
        case 2: return topGrossingApps?.feed?.results?.count ?? 0
        case 3: return freeApps?.feed?.results?.count ?? 0
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderCollectionViewCell.identifier, for: indexPath) as! AppsHeaderCollectionViewCell
            cell.socialApp = socialApps[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCollectionViewCell.identifer, for: indexPath) as! AppRowCollectionViewCell
            if indexPath.section == 1 {
                cell.result = games?.feed?.results?[indexPath.item]
            } else if indexPath.section == 2 {
                cell.result = topGrossingApps?.feed?.results?[indexPath.item]
            } else if indexPath.section == 3 {
                cell.result = freeApps?.feed?.results?[indexPath.item]
                
            }
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var appId: String!
        if indexPath.section == 0 {
            appId = socialApps[indexPath.item].id ?? ""
        } else if indexPath.section == 1 {
            appId = games?.feed?.results?[indexPath.item].id ?? ""
        } else if indexPath.section == 2 {
            appId = topGrossingApps?.feed?.results?[indexPath.item].id ?? ""
        } else if indexPath.section == 3 {
            appId = freeApps?.feed?.results?[indexPath.item].id ?? ""
        }
        let detailController = AppDetailsCollectionViewController(appId: appId)
        navigationController?.pushViewController(detailController, animated: true)
    }
}

struct AppsView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CompositionalController()
        
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct AppsCompositionalView: View {
    var body: some View {
        Text("MODIFYING")
    }
}

struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .edgesIgnoringSafeArea(.all)
    }
}
