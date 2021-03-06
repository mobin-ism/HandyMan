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
import Localize_Swift
import LIHImageSlider
class HomeViewController: UIViewController {
    
    var serviceId    = [Int]()
    var servicesName = [String]()
    var servicesIcon = [String]()
    var images: [UIImage] = [#imageLiteral(resourceName: "dummy2")]
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
    var sliderVc1 : UIViewController!
    
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
        
    }
    
    func clearCachedImages(){
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkNetworkConnection()
        
        self.activityIndicator.startAnimating()
        
        if Helper.Exists(key: IS_LOGGED_IN){
            print(UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool)
        }
        else {
            print("false")
        }
        
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
            self.alert(title: "No Internet Connection".localized(), message: "Please check your internet connection!!!".localized())
        }
        
    }
    
    private func layout() {
        //setSlider()
        //setSearchBar()
        setLHIImageSlider(sliderImages: self.images)
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
    
    func setLHIImageSlider(sliderImages: [UIImage]) {
        let y : CGFloat = 0
        let sliderHeight : CGFloat!
        
        if Helper.isIphoneX {
            sliderHeight = self.view.frame.height * 0.35
        } else {
            sliderHeight = self.view.frame.height * 0.35
        }
        
        let slider1: LIHSlider = LIHSlider(images: sliderImages)
        slider1.customImageView?.contentMode = .scaleAspectFit
        self.sliderVc1  = LIHSliderViewController(slider: slider1)
        self.addChildViewController(self.sliderVc1)
        self.view.addSubview(self.sliderVc1.view)
        self.sliderVc1.didMove(toParentViewController: self)
        self.sliderVc1.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: sliderHeight)
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
        collectionView.topAnchor.constraint(equalTo: sliderVc1.view.bottomAnchor, constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
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
        if (index == 3) {
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
                Alert.logOutConfirmationAlert(on: self)
            }
            else {
                navigationController?.tabBarController?.selectedIndex = 2
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
        guard let url = URL(string: "\(API_URL)api/v1/member/services?language=\(UserDefaults.standard.value(forKey: SELECTED_LANGUAGE) as! String)") else { return }
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
                    
                    if !self.images.isEmpty {
                        self.images.removeAll()
                    }
                    for eachService in serviceList.data.services {
                        
                        self.serviceId.append(eachService.serviceId)
                        self.servicesName.append(eachService.title)
                        self.servicesIcon.append(eachService.smallIconOne)
                    }
                    
                    if serviceList.data.banners.count > 0 {
                        for imageurl in serviceList.data.banners {
                            let imageview : UIImageView = {
                                let imageview = UIImageView()
                                return imageview
                            }()

                            imageview.sd_setImage(with: URL(string: imageurl), placeholderImage: #imageLiteral(resourceName: "dummy2"), options: [.continueInBackground, .progressiveDownload], completed: nil)
                            self.images.append(imageview.image!)
                            print(imageurl)
                        }
                        print(serviceList.data.banners.count)
                    }
                    else {
                        self.images.append(#imageLiteral(resourceName: "dummy2"))
                        self.images.append(#imageLiteral(resourceName: "dummy2"))
                    }
                    
                    self.layout()
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                } catch let err {
                    print(err)
                }
            }
        })
    }
}

