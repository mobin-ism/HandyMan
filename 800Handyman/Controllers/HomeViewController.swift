//
//  HomeViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class HomeViewController: UIViewController {
    
    var serviceId    = [Int]()
    var servicesName = [String]()
    var servicesIcon = [String]()
    
    lazy var slider: Slider = {
        let slider = Slider()
        return slider
    }()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.homeController = self
        return slideMenu
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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let serviceCellId = "ServiceCell"
    var sliderImages = [SliderImages]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        
        // Adding the language English As Default
        UserDefaults.standard.set("en", forKey: SELECTED_LANGUAGE)
        
        setNavigationBar()
        
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: serviceCellId)
        
        for _ in 1...5 {
            let image = SliderImages(image: "dummy2")
            sliderImages.append(image)
        }
        slider.dataSource = sliderImages
        
        self.clearCachedImages()
        layout()
    }
    
    func clearCachedImages(){
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.checkNetworkConnection()
        
        // API Call
        self.getServicesJSON()
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
    }
    
    func alert(title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkNetworkConnection() {
        if Reachability.isConnectedToNetwork() {
            print("")
        }
        else {
            self.alert(title: "No Internet Connection", message: "Please check your internet connection!!!")
        }
        
    }
    
    private func layout() {
        setSlider()
        //setSearchBar()
        setCollectionView()
        setupActivityIndicator()
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
        collectionView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(fromVC: self)
    }
    
    func setSelectedIndex(at index: Int) {
        if (index == 2) {
            if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
                print(UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool)
                self.navigationController?.pushViewController(JobListViewController(), animated: true)
            }
            else {
                print(UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool)
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
        else if (index == 3) {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
        else if(index == 4) {
            // Modal for changing the Language view
            DispatchQueue.main.async {
                self.present(LanguageSelectViewController(), animated: true, completion: nil)
            }
        }
        else if(index == 5) {
            if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
                UserDefaults.standard.set(false, forKey: IS_LOGGED_IN)
            }
            else {
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
        else {
            navigationController?.tabBarController?.selectedIndex = index
            //CustomTabBarController().selectedIndex = index
        }
    }
    
    @objc private func settingsIconTapped() {
        
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.servicesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceCellId, for: indexPath) as? ServiceCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        //cell.mainImage = #imageLiteral(resourceName: "dummy1")
        cell.imageView.sd_setImage(with: URL(string: self.servicesIcon[indexPath.row]))
        cell.mainText = self.servicesName[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let serviceVC = ServiceViewController()
        serviceVC.keyValue = indexPath.row
        serviceVC.selectedServiceId = self.serviceId[indexPath.row]
        serviceVC.serviceId = self.serviceId
        serviceVC.servicesName = self.servicesName
        serviceVC.servicesIcon = self.servicesIcon
        
        navigationController?.pushViewController(serviceVC, animated: true)
        //navigationController?.pushViewController(SelectDateTimeViewController(), animated: true)
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

// API Functions
extension HomeViewController {
    
    func getServicesJSON() {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/services/\(UserDefaults.standard.value(forKey: SELECTED_LANGUAGE) as! String)") else { return }
        Alamofire.request(url,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(DataResponse.self, from: json)
                    
                    if !self.serviceId.isEmpty {
                        self.serviceId.removeAll()
                    }
                    
                    if !self.servicesName.isEmpty {
                        self.servicesName.removeAll()
                    }
                    
                    if !self.servicesIcon.isEmpty {
                        self.servicesIcon.removeAll()
                    }
                    
                    for eachService in serviceList.data.services {
                        
                        self.serviceId.append(eachService.serviceId)
                        self.servicesName.append(eachService.title)
                        self.servicesIcon.append(eachService.smallIconOne)
                    }
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                } catch let err {
                    print(err)
                }
            }
        })
    }
}

