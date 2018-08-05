//
//  CompletedServicesListViewController.swift
//  800Handyman
//
//  Created by Al Mobin on 3/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire

class CompletedServiceDetailsListViewController : UIViewController {
    
    var selectedDateAndTime : String = "--:--"
    
    var listOfServices = [NSObject]()
    var selectedItem : Int?
    var serviceRequestMasterID : Int?
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Customer Job Done", comment: "Customer Job Done")
        label.font = UIFont(name: OPENSANS_REGULAR, size : 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let requestIDTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Request ID", comment: "Request ID")
        label.font = UIFont(name: OPENSANS_BOLD, size : 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let requestIDLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderStatusTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Status: ", comment: "Status: ")
        label.font = UIFont(name: OPENSANS_BOLD, size : 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderStatusLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Completed"
        return label
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.backgroundColor = UIColor.clear
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let totalPriceTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Total Price", comment: "Total Price")
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalPriceLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AED 0000"
        return label
    }()
    
    let locationTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Location", comment: "Location")
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let streetLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let apartmentLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateAndTimeTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Date and Time", comment: "Date and Time")
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateAndTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var orderAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Order Again", for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleOrderAgainButton), for: .touchUpInside)
        return button
    }()
    
    lazy var rateItButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rate It", for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRateItButton), for: .touchUpInside)
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let cellID = "ServiceDetailsListViewCell"
    
    lazy var showServiceDetailsList: ShowServiceDetailsView = {
        
        let showServiceDetailsListObj = ShowServiceDetailsView()
        showServiceDetailsListObj.completedServiceDetailsListVC = self
        return showServiceDetailsListObj
    }()
    
    lazy var serviceListCell: ServiceDetailsListViewCell = {
        
        let serviceListObj = ServiceDetailsListViewCell()
        serviceListObj.completedServiceListVC = self
        return serviceListObj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BACKGROUND_COLOR
        self.setNavigationBar()
        self.collectionView.register(ServiceDetailsListViewCell.self, forCellWithReuseIdentifier: cellID)
    
        // get services list
        self.getServicesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // get services list
        self.getServicesList()
        
        guard let serviceRequestMasterID = self.serviceRequestMasterID else { return }
        self.requestIDLabel.text = "#\(serviceRequestMasterID)"
        print("Master Service Request ID is: \(serviceRequestMasterID)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 140)
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        /*navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftArrowIcon")
         navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftArrowIcon")
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)*/
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
        
    }
    
    private func layout() {
        setupScrollView()
        setupTitleLabel()
        setupRequestIDTitleLabel()
        setupRequestIDLabel()
        setupOrderStatusLabel()
        setupOrderStatusTitleLabel()
        setupCollecetionView()
        setupTotalPriceTitleLabel()
        setupTotalPriceLabel()
        setupLocationTitleLabel()
        setupAreaNameLabel()
        setupAddressLabel()
        setupStreetLabel()
        setupApartmentLabel()
        setupDateAndTimeTitleLabel()
        setupDateAndTimeLabel()
        setupOrderAgainButton()
        setupRateItButton()
        setupActivityIndicator()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    private func setupRequestIDTitleLabel() {
        scrollView.addSubview(requestIDTitleLabel)
        requestIDTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        requestIDTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupRequestIDLabel() {
        scrollView.addSubview(requestIDLabel)
        requestIDLabel.centerYAnchor.constraint(equalTo: requestIDTitleLabel.centerYAnchor).isActive = true
        requestIDLabel.leftAnchor.constraint(equalTo: requestIDTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    private func setupOrderStatusLabel() {
        scrollView.addSubview(orderStatusLabel)
        orderStatusLabel.centerYAnchor.constraint(equalTo: requestIDTitleLabel.centerYAnchor).isActive = true
        orderStatusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupOrderStatusTitleLabel() {
        scrollView.addSubview(orderStatusTitleLabel)
        orderStatusTitleLabel.centerYAnchor.constraint(equalTo: requestIDTitleLabel.centerYAnchor).isActive = true
        orderStatusTitleLabel.rightAnchor.constraint(equalTo: orderStatusLabel.leftAnchor, constant: -5).isActive = true
    }
    
    private func setupCollecetionView() {
        let collectionViewHeight : CGFloat = CGFloat((self.listOfServices.count * 90) + (self.listOfServices.count * 8))
        scrollView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: orderStatusTitleLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight).isActive = true
    }
    
    private func setupTotalPriceTitleLabel() {
        scrollView.addSubview(totalPriceTitleLabel)
        totalPriceTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30).isActive = true
        totalPriceTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupTotalPriceLabel() {
        scrollView.addSubview(totalPriceLabel)
        totalPriceLabel.centerYAnchor.constraint(equalTo: totalPriceTitleLabel.centerYAnchor).isActive = true
        totalPriceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupLocationTitleLabel() {
        scrollView.addSubview(locationTitleLabel)
        locationTitleLabel.topAnchor.constraint(equalTo: totalPriceTitleLabel.bottomAnchor, constant: 16).isActive = true
        locationTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupAreaNameLabel() {
        scrollView.addSubview(areaNameLabel)
        areaNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        areaNameLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    private func setupAddressLabel() {
        scrollView.addSubview(addressLabel)
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        addressLabel.topAnchor.constraint(equalTo: areaNameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    private func setupStreetLabel() {
        scrollView.addSubview(streetLabel)
        streetLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        streetLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    private func setupApartmentLabel() {
        scrollView.addSubview(apartmentLabel)
        apartmentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        apartmentLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    private func setupDateAndTimeTitleLabel() {
        scrollView.addSubview(dateAndTimeTitleLabel)
        dateAndTimeTitleLabel.topAnchor.constraint(equalTo: apartmentLabel.bottomAnchor, constant: 16).isActive = true
        dateAndTimeTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupDateAndTimeLabel() {
        scrollView.addSubview(dateAndTimeLabel)
        dateAndTimeLabel.topAnchor.constraint(equalTo: dateAndTimeTitleLabel.bottomAnchor, constant: 8).isActive = true
        dateAndTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    
    private func setupOrderAgainButton() {
        scrollView.addSubview(orderAgainButton)
        orderAgainButton.topAnchor.constraint(equalTo: dateAndTimeLabel.bottomAnchor, constant: 32).isActive = true
        orderAgainButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        orderAgainButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 - 16).isActive = true
        orderAgainButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupRateItButton() {
        scrollView.addSubview(rateItButton)
        rateItButton.centerYAnchor.constraint(equalTo: orderAgainButton.centerYAnchor).isActive = true
        rateItButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        rateItButton.leftAnchor.constraint(equalTo: orderAgainButton.rightAnchor, constant: 16).isActive = true
        rateItButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    var thankYouOBJ = ThankYouViewController()
    @objc private func handleOrderAgainButton() {
        UserDefaults.standard.set(true, forKey: SHOW_THANK_YOU_MESSAGE)
        
        if (UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool) {
            thankYouOBJ.serviceRequestMasterID = UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as? Int
            self.navigationController?.pushViewController(thankYouOBJ, animated: true)
        }
        else {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    var customerJobDoneVC = CustomerJobDone()
    @objc private func handleRateItButton() {
        self.customerJobDoneVC.serviceRequestMasterID = self.serviceRequestMasterID
        self.customerJobDoneVC.selectedDateAndTime = self.selectedDateAndTime
        self.navigationController?.pushViewController(customerJobDoneVC, animated: true)
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDateTimeEditButton() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is SelectDateTimeViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    let editLocationFirstVC = EditLocationFirstViewController()
    
    @objc func handleLocationEditButton() {
        
        print("Pre edit controller \(self.selectedDateAndTime)")
        editLocationFirstVC.selectedDateAndTime = self.selectedDateAndTime
        self.navigationController?.pushViewController(editLocationFirstVC, animated: true)
    }
    
    var editServiceRequestDetailsOBJ = EditServiceDetailsViewController()
    func editServiceDetails(serviceRequestDetailsID : Int) {
        editServiceRequestDetailsOBJ.serviceRequestDetailsID = serviceRequestDetailsID
        self.navigationController?.pushViewController(editServiceRequestDetailsOBJ, animated: true)
    }
}

extension CompletedServiceDetailsListViewController : UIScrollViewDelegate {
    
}

extension CompletedServiceDetailsListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ServiceDetailsListViewCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        if let selectedItem = self.selectedItem {
            if selectedItem == indexPath.item {
                cell.layer.borderColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0).cgColor
                cell.serviceImageView.layer.borderColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0).cgColor
            }
            else {
                cell.layer.borderColor = UIColor.gray.cgColor
                cell.serviceImageView.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        
        if let data = listOfServices as? [GetServicesListObject] {
            cell.service = "\(data[indexPath.row].serviceParentTitle)"
            cell.subService = "\(data[indexPath.row].serviceTitle)"
            cell.price = "\(data[indexPath.row].serviceRate)"
            cell.serviceImageView.sd_setImage(with: URL(string: data[indexPath.row].serviceParentIcon))
            
            cell.expandButton.tag = data[indexPath.row].serviceRequestDetailId
            cell.expandButton.addTarget(self, action: #selector(handleExpandButton(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        self.selectedItem = indexPath.item
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    
    @objc func handleExpandButton(_ sender : UIButton) {
        showServiceDetailsList.show(serviceID : sender.tag)
    }
}

extension CompletedServiceDetailsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 90
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
extension CompletedServiceDetailsListViewController {
    
    private func getServicesList() {
        self.activityIndicator.startAnimating()
        guard let serviceRequestMasterID = self.serviceRequestMasterID else { return }
        
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/info?id=\(serviceRequestMasterID)") else { return }
        
        let params = ["" : ""] as [String : Any]
        Alamofire.request(url,method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            // code after a successfull reponse
            self.activityIndicator.stopAnimating()
            
            if !self.listOfServices.isEmpty {
                
                self.listOfServices.removeAll()
            }
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(subService.self, from: json)
                    
                    for eachService in serviceList.data.serviceRequest.services {
                        
                        let container = GetServicesListObject(serviceRequestDetailId: eachService.serviceRequestDetailId, serviceParentIcon: eachService.serviceParentIcon, serviceParentTitle: eachService.serviceParentTitle, serviceTitle: eachService.serviceTitle, serviceRate: eachService.serviceRate, thumbnails: eachService.thumbnails)
                        
                        self.listOfServices.append(container)
                    }
                    self.areaNameLabel.text = "Area Name: \(serviceList.data.serviceRequest.location.areaName)"
                    self.addressLabel.text = "Address Name: \(serviceList.data.serviceRequest.location.addressName)"
                    self.streetLabel.text = "Street Name: \(serviceList.data.serviceRequest.location.street)"
                    self.apartmentLabel.text = "Apartment No.: \(serviceList.data.serviceRequest.location.apartmentNo)"
                    self.dateAndTimeLabel.text = self.selectedDateAndTime
                } catch let err {
                    print(err)
                }
            }
            
            self.layout()
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.view.layoutIfNeeded()
            self.activityIndicator.stopAnimating()
            
            print("From API: \(self.listOfServices.count)")
        })
    }
}
