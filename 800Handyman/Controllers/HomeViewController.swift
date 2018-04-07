//
//  HomeViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var slider: Slider = {
        let slider = Slider()
        return slider
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundImage = UIImage()
        search.backgroundColor = UIColor.white
        search.placeholder = NSLocalizedString("Search for a service", comment: "Search for a service")
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.lightGray.cgColor
        search.clipsToBounds = true
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
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
    
    let serviceCellId = "ServiceCell"
    var sliderImages = [SliderImages]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        
        setNavigationBar()
        
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: serviceCellId)
        
        for _ in 1...5 {
            let image = SliderImages(image: "dummy2")
            sliderImages.append(image)
        }
        slider.dataSource = sliderImages
        
        layout()
        
        DispatchQueue.main.async {
            self.present(LanguageSelectViewController(), animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchBar.layer.cornerRadius = searchBar.frame.height * 0.5
        for view in searchBar.subviews {
            for subview in view.subviews {
                if subview.isKind(of: UITextField.self) {
                    let textField: UITextField = subview as! UITextField
                    textField.backgroundColor = UIColor.white
                    textField.font = UIFont(name: OPENSANS_REGULAR, size: 14)
                }
            }
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationController?.navigationBar.topItem?.titleView = imageView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsIconTapped))
    }
    
    private func layout() {
        setSlider()
        setSearchBar()
        setCollectionView()
    }
    
    private func setSlider() {
        view.addSubview(slider)
        slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if Helper.isIphoneX {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        } else {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
    }
    
    private func setSearchBar() {
        view.addSubview(searchBar)
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        searchBar.heightAnchor.constraint(equalTo: slider.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func menuIconTapped() {
        
    }
    
    @objc private func settingsIconTapped() {
        
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceCellId, for: indexPath) as? ServiceCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainImage = #imageLiteral(resourceName: "dummy1")
        cell.mainText = "Cleaning"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ServiceViewController(), animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 3 - 16
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

