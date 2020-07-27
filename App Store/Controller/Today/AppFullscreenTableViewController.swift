//
//  AppFullScreenTableViewController.swift
//  App Store
//
//  Created by Peter Bassem on 7/26/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class AppFullscreenTableViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let floatingContainerView = UIView()
    
    var dismissCloseButtonAlpha: CGFloat? {
        didSet {
            closeButton.alpha = dismissCloseButtonAlpha ?? 0.0
        }
    }
    
    var dismissHandler: (()->Void)?
    
    var item: TodayItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.clipsToBounds = true
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        setupCloseButton()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let statusBarHeight = (UIApplication.shared.windows.filter { $0.isKeyWindow } .first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero).height
        tableView.contentInset = .init(top: 0, left: 0, bottom: statusBarHeight, right: 0)
        tableView.showsVerticalScrollIndicator = false
        
        setupFloatingControls()
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
    }
    
    private func setupFloatingControls() {
        floatingContainerView.clipsToBounds = true
        floatingContainerView.layer.cornerRadius = 16
        view.addSubview(floatingContainerView)
//        let bottomPadding = (UIApplication.shared.windows.filter { $0.isKeyWindow } .first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero).height
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
        
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        
        // add subviews
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = item.image
        imageView.constrainHeight(constant: 68)
        imageView.constrainWidth(constant: 68)
        
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getButton.backgroundColor = .darkGray
        getButton.layer.cornerRadius = 16
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
                UILabel(text: "Utilizing your time", font: .systemFont(ofSize: 16)),
            ], spacing: 4),
            getButton
        ], customSpacing: 16)
        floatingContainerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
    
    @objc private func didTapCloseButton(_ sender: UIButton) {
        sender.isHidden = true
        dismissHandler?()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.floatingContainerView.transform = .init(translationX: 0, y: -90)
        })
    }
}

extension AppFullscreenTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = AppFullScreenHeaderTableViewCell()
            headerCell.item = item
            headerCell.disableCornerRadius = true
            headerCell.closeButtonPressed = { [weak self] in
                self?.dismissHandler?()
            }
            headerCell.clipsToBounds = true
            headerCell.removeTodayCellBackgroundView = true
            return headerCell
        }
        let cell = AppFullScreenDescriptionTableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayCollectionViewController.cellSize
        }
        return UITableView.automaticDimension
    }
}

//MARK: - UIScrollViewDelegate
extension AppFullscreenTableViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true //video 41 @07:00
        }
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            let translationY = -90 - (UIApplication.shared.windows.filter { $0.isKeyWindow } .first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero).height
            let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
            
            self.floatingContainerView.transform = transform
        })
    }
}
