//
//  LocationSecondViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 9/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationSecondViewController: UIViewController {
    
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
        button.setTitle("LOCATION CONFIRMED", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BACK", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
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
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Address"
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 10)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLineOne: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "P Block, Emaar Business Park"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLineTwo: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "341 Jake Island Suite 419"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        layout()
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func layout() {
        setLocationConfirmButton()
        setBackButton()
        setAddressView()
        setMapView()
        setAddressLabel()
        setAddressLineOne()
        setAddressLineTwo()
    }
    
    private func setLocationConfirmButton() {
        view.addSubview(locationConfirmButton)
        locationConfirmButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -4).isActive = true
        locationConfirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        locationConfirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        locationConfirmButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setBackButton() {
        view.addSubview(backButton)
        backButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 4).isActive = true
        backButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        backButton.bottomAnchor.constraint(equalTo: locationConfirmButton.bottomAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: locationConfirmButton.topAnchor).isActive = true
    }
    
    private func setAddressView() {
        view.addSubview(addressView)
        addressView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        addressView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        addressView.bottomAnchor.constraint(equalTo: locationConfirmButton.topAnchor, constant: -16).isActive = true
        addressView.heightAnchor.constraint(equalToConstant: 48 * 2).isActive = true
    }
    
    private func setMapView() {
        view.addSubview(mapView)
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: addressView.topAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    private func setAddressLabel() {
        addressView.addSubview(addressLabel)
        addressLabel.leftAnchor.constraint(equalTo: addressView.leftAnchor, constant: 16).isActive = true
        addressLabel.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 20).isActive = true
    }
    
    private func setAddressLineOne() {
        addressView.addSubview(addressLineOne)
        addressLineOne.leftAnchor.constraint(equalTo: addressLabel.leftAnchor).isActive = true
        addressLineOne.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    private func setAddressLineTwo() {
        addressView.addSubview(addressLineTwo)
        addressLineTwo.leftAnchor.constraint(equalTo: addressLabel.leftAnchor).isActive = true
        addressLineTwo.topAnchor.constraint(equalTo: addressLineOne.bottomAnchor, constant: 2).isActive = true
    }
    
}
