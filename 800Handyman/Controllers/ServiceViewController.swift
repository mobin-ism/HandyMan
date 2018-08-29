//
//  ServiceViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 5/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift
class ServiceViewController: UIViewController {
    
    // this data will come from HomeViewController
    
    var keyValue : Int!
    var selectedServiceId : Int!
    var selectedLanguage : String?
    var serviceId    = [Int]()
    var servicesName = [String]()
    var servicesIcon = [String]()
    
    // will be assigened with api call
    var subServicesId = [Int]()
    var subServicesTitle = [String]()
    var subServicesSubTitle = [String]()
    var subServicesRate = [String]()
    var subServicesRequiredHours = [String]()
    
    lazy var serviceMenu: ServiceMenu = {
        let menu = ServiceMenu()
        menu.serviceVC     = self
        menu.servicesIcons = self.servicesIcon
        menu.servicesId    = self.serviceId
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
        imageView.contentMode = .scaleAspectFit
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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let serviceChildCellId = "ServiceChildCell"
    
    var selectedRow: Int? = 0 {
        didSet {
            self.getSubServices(selectedServiceId: self.serviceId[selectedRow!])
            self.titleLabel.text = self.servicesName[selectedRow!]
            self.topImageView.sd_setImage(with: URL(string: self.servicesIcon[selectedRow!]))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        collectionView.register(ServiceChildCell.self, forCellWithReuseIdentifier: serviceChildCellId)
        layout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // API Calls
        self.getSubServices(selectedServiceId: self.selectedServiceId)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Helper.selectedLanguage == "en" {
         topImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: serviceMenu.frame.width / 2).isActive = true
        }
        else if Helper.selectedLanguage == "ar" {
            topImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -(serviceMenu.frame.width / 2)).isActive = true
        }
        topImageHolder.layer.cornerRadius = topImageHolder.frame.height / 2
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    private func layout() {
        setServiceMenu()
        setVerticalLine()
        setTopImageHolder()
        setTopImageView()
        setTitleLabel()
        setCollectionView()
        setupActivityIndicator()
        
        setupPageData()
    }
    
    private func setServiceMenu() {
        view.addSubview(serviceMenu)
        serviceMenu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        serviceMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        serviceMenu.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        serviceMenu.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.16).isActive = true
        
    }
    
    private func setVerticalLine() {
        view.addSubview(verticalLine)
        verticalLine.topAnchor.constraint(equalTo: serviceMenu.topAnchor).isActive = true
        verticalLine.bottomAnchor.constraint(equalTo: serviceMenu.bottomAnchor).isActive = true
        verticalLine.leadingAnchor.constraint(equalTo: serviceMenu.trailingAnchor).isActive = true
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
        topImageView.leadingAnchor.constraint(equalTo: topImageHolder.leadingAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: topImageHolder.trailingAnchor).isActive = true
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
        collectionView.leadingAnchor.constraint(equalTo: serviceMenu.trailingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    
    private func setupPageData() {

        topImageView.sd_setImage(with: URL(string: self.servicesIcon[self.keyValue]))
        titleLabel.text = self.servicesName[self.keyValue]
        collectionView.reloadData()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subServicesTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceChildCellId, for: indexPath) as? ServiceChildCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainText = self.subServicesTitle[indexPath.row]
        cell.subTitleText = self.subServicesSubTitle[indexPath.row]
        cell.price = self.subServicesRate[indexPath.row]
        cell.serviceHours = self.subServicesRequiredHours[indexPath.row]
        cell.priceIcon = #imageLiteral(resourceName: "priceIcon")
        cell.serviceIcon = #imageLiteral(resourceName: "serviceHours")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let serviceDetailsVC = ServiceDetailsViewController()
        serviceDetailsVC.jobTitleLabel.text = self.servicesName[self.keyValue]
        serviceDetailsVC.jobSubTitleLabel.text = self.subServicesTitle[indexPath.row]
        serviceDetailsVC.priceLabel.text = self.subServicesRate[indexPath.row]
        serviceDetailsVC.selectedServiceId = self.selectedServiceId
        serviceDetailsVC.selectedSubServiceId = self.subServicesId[indexPath.row]
        self.navigationController?.pushViewController(serviceDetailsVC, animated: true)
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

// API Functions
extension ServiceViewController {
    
    func getSubServices( selectedServiceId : Int ) {
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
                    
                    if !self.subServicesId.isEmpty {
                        self.subServicesId.removeAll()
                    }
                    
                    if !self.subServicesTitle.isEmpty {
                        self.subServicesTitle.removeAll()
                    }
                    
                    if !self.subServicesSubTitle.isEmpty {
                        self.subServicesSubTitle.removeAll()
                    }
                    
                    if !self.subServicesRate.isEmpty {
                        self.subServicesRate.removeAll()
                    }
                    
                    if !self.subServicesRequiredHours.isEmpty {
                        self.subServicesRequiredHours.removeAll()
                    }
                    
                    for service in serviceList.data.services {
                        if  service.serviceId == selectedServiceId {
                            for subService in service.child {
                                self.subServicesId.append(subService.serviceId)
                                self.subServicesTitle.append(subService.title)
                                if let subTitle = subService.subTitle {
                                    self.subServicesSubTitle.append(subTitle)
                                }
                                else {
                                    self.subServicesSubTitle.append("")
                                }
                                self.subServicesRate.append(subService.serviceRate)
                                if let eachServiceRate = subService.requiredHours {
                                    self.subServicesRequiredHours.append(eachServiceRate)
                                }
                                else {
                                    self.subServicesRequiredHours.append("")
                                }
                            }
                        }
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
