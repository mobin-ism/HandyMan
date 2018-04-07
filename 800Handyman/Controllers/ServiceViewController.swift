//
//  ServiceViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 5/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    lazy var serviceMenu: ServiceMenu = {
        let menu = ServiceMenu()
        return menu
    }()
    
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topImageHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let serviceChildCellId = "ServiceChildCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        collectionView.register(ServiceChildCell.self, forCellWithReuseIdentifier: serviceChildCellId)
        
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: serviceMenu.frame.width / 2).isActive = true
        topImageHolder.layer.cornerRadius = topImageHolder.frame.height / 2
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsIconTapped))
    }
    
    private func layout() {
        setServiceMenu()
        setVerticalLine()
        setTopImageHolder()
        setTopImageView()
        setTitleLabel()
        setCollectionView()
        
        setupPageData()
    }
    
    private func setServiceMenu() {
        view.addSubview(serviceMenu)
        serviceMenu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        serviceMenu.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        serviceMenu.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        serviceMenu.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.16).isActive = true
    }
    
    private func setVerticalLine() {
        view.addSubview(verticalLine)
        verticalLine.topAnchor.constraint(equalTo: serviceMenu.topAnchor).isActive = true
        verticalLine.bottomAnchor.constraint(equalTo: serviceMenu.bottomAnchor).isActive = true
        verticalLine.leftAnchor.constraint(equalTo: serviceMenu.rightAnchor).isActive = true
        verticalLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setTopImageHolder() {
        view.addSubview(topImageHolder)
        topImageHolder.topAnchor.constraint(equalTo: view.topAnchor, constant: 18).isActive = true
        topImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        topImageHolder.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
    }
    
    private func setTopImageView() {
        topImageHolder.addSubview(topImageView)
        topImageView.topAnchor.constraint(equalTo: topImageHolder.topAnchor).isActive = true
        topImageView.leftAnchor.constraint(equalTo: topImageHolder.leftAnchor).isActive = true
        topImageView.rightAnchor.constraint(equalTo: topImageHolder.rightAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: topImageHolder.bottomAnchor).isActive = true
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: topImageView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: serviceMenu.rightAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupPageData() {
        topImageView.image = #imageLiteral(resourceName: "dummy1")
        titleLabel.text = "Cleaner"
        collectionView.reloadData()
    }
    
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceChildCellId, for: indexPath) as? ServiceChildCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainText = "Full house cleaning"
        cell.subTitleText = "Lorem ipsum"
        cell.price = "AED 300-500"
        cell.serviceHours = "2 hr - 3 hr"
        cell.priceIcon = #imageLiteral(resourceName: "priceIcon")
        cell.serviceIcon = #imageLiteral(resourceName: "serviceHours")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = width * 0.2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
