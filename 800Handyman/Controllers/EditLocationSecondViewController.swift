//
//  EditLocationSecondViewController.swift
//  800Handyman
//
//  Created by Al Mobin on 3/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Localize_Swift

class EditLocationSecondViewController: UIViewController {
    
    var selectedDateAndTime : String?
    var selectedAreaID : Int?
    var selectedAreaName : String?
    var addressName : String?
    var addressType : String?
    var streetBuilding : String?
    var apartmentNo : String?
    var markedLatitude : Double?
    var markedLongitude : Double?
    
    lazy var mapView: GMSMapView = {
        let view = GMSMapView()
        view.isMyLocationEnabled = true
        view.settings.myLocationButton = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var locationConfirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOCATION CONFIRMED".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLocationConfirmedButton), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BACK".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    let addressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Address".localized()
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 10)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLineOne: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "P Block, Emaar Business Park"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLineTwo: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "341 Jake Island Suite 419"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mapPinImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "mappin"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        layout()
        
        self.mapView.delegate = self
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    private func layout() {
        setLocationConfirmButton()
        setBackButton()
        setAddressView()
        setMapView()
        setAddressLabel()
        setAddressLineOne()
        setAddressLineTwo()
        setMapPinImageView()
    }
    
    private func setMapPinImageView() {
        mapView.addSubview(mapPinImageView)
        mapPinImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        mapPinImageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -25).isActive = true
        mapPinImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mapPinImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setLocationConfirmButton() {
        view.addSubview(locationConfirmButton)
        locationConfirmButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4).isActive = true
        locationConfirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        locationConfirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        locationConfirmButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setBackButton() {
        view.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 4).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backButton.bottomAnchor.constraint(equalTo: locationConfirmButton.bottomAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: locationConfirmButton.topAnchor).isActive = true
    }
    
    private func setAddressView() {
        view.addSubview(addressView)
        addressView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addressView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addressView.bottomAnchor.constraint(equalTo: locationConfirmButton.topAnchor, constant: -16).isActive = true
        addressView.heightAnchor.constraint(equalToConstant: 48 * 2).isActive = true
    }
    
    private func setMapView() {
        view.addSubview(mapView)
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: addressView.topAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    private func setAddressLabel() {
        addressView.addSubview(addressLabel)
        addressLabel.leadingAnchor.constraint(equalTo: addressView.leadingAnchor, constant: 16).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: -16).isActive = true
        addressLabel.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 20).isActive = true
    }
    
    private func setAddressLineOne() {
        addressView.addSubview(addressLineOne)
        addressLineOne.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor).isActive = true
        addressLineOne.trailingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: -16).isActive = true
        addressLineOne.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    private func setAddressLineTwo() {
        addressView.addSubview(addressLineTwo)
        addressLineTwo.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor).isActive = true
        addressLineTwo.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: -16).isActive = true
        addressLineTwo.topAnchor.constraint(equalTo: addressLineOne.bottomAnchor, constant: 2).isActive = true
    }
    
    @objc private func handleLocationConfirmedButton(){
        
        let editFirstLocationViewController = EditLocationFirstViewController()
        editFirstLocationViewController.markedLatitude = self.markedLatitude
        editFirstLocationViewController.markedLongitude = self.markedLongitude
        editFirstLocationViewController.selectedDateAndTime = self.selectedDateAndTime
        editFirstLocationViewController.streetTextField.text = self.addressLineOne.text
        if let selectedAreaID = self.selectedAreaID, let selectedAreaName = self.selectedAreaName, let addressName = self.addressName, let addressType = self.addressType, let apartmentNo = self.apartmentNo {
            editFirstLocationViewController.selectedAreaID = selectedAreaID
            editFirstLocationViewController.areaNameLabel.text = selectedAreaName
            editFirstLocationViewController.addressNameTextField.text = addressName
            editFirstLocationViewController.addressTypeTextField.text = addressType
            editFirstLocationViewController.villaTextField.text = apartmentNo
        }
        self.navigationController?.pushViewController(editFirstLocationViewController, animated: true)
    }
    
    @objc private func handleBackButton(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension EditLocationSecondViewController : GMSMapViewDelegate {
    
    // MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let bottomPoint: CGPoint = CGPoint(x: mapPinImageView.center.x, y: mapPinImageView.center.y + mapPinImageView.frame.height / 2)
        let coordinate = mapView.projection.coordinate(for: bottomPoint)
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            guard let response = response else { return }
            guard let address = response.firstResult() else { return }
            guard let lines = address.lines, let country = address.country else { return }
            var formattedAddress: String = ""
            for line in lines {
                if line != "" {
                    formattedAddress = "\(formattedAddress) \(line),"
                }
            }
            formattedAddress.removeLast()
            self.addressLineOne.text = formattedAddress
            self.addressLineTwo.text = country
            
            self.markedLatitude = coordinate.latitude
            self.markedLongitude = coordinate.longitude
        }
        
    }
}

