//
//  LocationFirstViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 9/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationFirstViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.keyboardDismissMode = .interactive
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var mapView: GMSMapView = {
        let view = GMSMapView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Area"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Address Name (Optional)"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Address Type"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let streetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Street / Building"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let villaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Apartment no / Villa no"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var areaHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let areaNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Mirdif"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var downArrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "downArrowIcon")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var addressNameTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        field.placeholder = "Facilisis"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var addressTypeTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        field.placeholder = "Apartment"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var streetTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        field.placeholder = "Maecenas"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var villaTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        field.placeholder = "45, LPT"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        layout()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 500)
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
        setMapView()
        setScrollView()
        setAreaLabel()
        setAreaHolder()
        setAreaNameLabel()
        setDownArrowIcon()
        setAddressNameLabel()
        setAddressNameTextField()
        setAddressTypeLabel()
        setAddressTypeTextField()
        setStreetLabel()
        setStreetTextField()
        setVillaLabel()
        setVillaTextField()
        setNextButton()
    }
    
    private func setMapView() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        if Helper.isIphoneX {
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        } else {
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        }
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setAreaLabel() {
        scrollView.addSubview(areaLabel)
        areaLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        areaLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
    }
    
    private func setAreaHolder() {
        scrollView.addSubview(areaHolder)
        areaHolder.leftAnchor.constraint(equalTo: areaLabel.leftAnchor).isActive = true
        areaHolder.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 8).isActive = true
        areaHolder.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        areaHolder.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setAreaNameLabel() {
        areaHolder.addSubview(areaNameLabel)
        areaNameLabel.centerYAnchor.constraint(equalTo: areaHolder.centerYAnchor).isActive = true
        areaNameLabel.leftAnchor.constraint(equalTo: areaHolder.leftAnchor, constant: 16).isActive = true
    }
    
    private func setDownArrowIcon() {
        areaHolder.addSubview(downArrowIcon)
        downArrowIcon.centerYAnchor.constraint(equalTo: areaHolder.centerYAnchor).isActive = true
        downArrowIcon.rightAnchor.constraint(equalTo: areaHolder.rightAnchor, constant: -16).isActive = true
        downArrowIcon.widthAnchor.constraint(equalToConstant: 11).isActive = true
        downArrowIcon.heightAnchor.constraint(equalToConstant: 11 * 0.6).isActive = true
    }
    
    private func setAddressNameLabel() {
        scrollView.addSubview(addressNameLabel)
        addressNameLabel.topAnchor.constraint(equalTo: areaHolder.bottomAnchor, constant: 8).isActive = true
        addressNameLabel.leftAnchor.constraint(equalTo: areaLabel.leftAnchor).isActive = true
    }
    
    private func setAddressNameTextField() {
        scrollView.addSubview(addressNameTextField)
        addressNameTextField.topAnchor.constraint(equalTo: addressNameLabel.bottomAnchor, constant: 8).isActive = true
        addressNameTextField.leftAnchor.constraint(equalTo: areaHolder.leftAnchor).isActive = true
        addressNameTextField.rightAnchor.constraint(equalTo: areaHolder.rightAnchor).isActive = true
        addressNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setAddressTypeLabel() {
        scrollView.addSubview(addressTypeLabel)
        addressTypeLabel.topAnchor.constraint(equalTo: addressNameTextField.bottomAnchor, constant: 8).isActive = true
        addressTypeLabel.leftAnchor.constraint(equalTo: areaLabel.leftAnchor).isActive = true
    }
    
    private func setAddressTypeTextField() {
        scrollView.addSubview(addressTypeTextField)
        addressTypeTextField.topAnchor.constraint(equalTo: addressTypeLabel.bottomAnchor, constant: 8).isActive = true
        addressTypeTextField.leftAnchor.constraint(equalTo: areaHolder.leftAnchor).isActive = true
        addressTypeTextField.rightAnchor.constraint(equalTo: areaHolder.rightAnchor).isActive = true
        addressTypeTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setStreetLabel() {
        scrollView.addSubview(streetLabel)
        streetLabel.topAnchor.constraint(equalTo: addressTypeTextField.bottomAnchor, constant: 8).isActive = true
        streetLabel.leftAnchor.constraint(equalTo: areaLabel.leftAnchor).isActive = true
    }
    
    private func setStreetTextField() {
        scrollView.addSubview(streetTextField)
        streetTextField.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 8).isActive = true
        streetTextField.leftAnchor.constraint(equalTo: areaHolder.leftAnchor).isActive = true
        streetTextField.rightAnchor.constraint(equalTo: areaHolder.rightAnchor).isActive = true
        streetTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setVillaLabel() {
        scrollView.addSubview(villaLabel)
        villaLabel.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 8).isActive = true
        villaLabel.leftAnchor.constraint(equalTo: areaLabel.leftAnchor).isActive = true
    }
    
    private func setVillaTextField() {
        scrollView.addSubview(villaTextField)
        villaTextField.topAnchor.constraint(equalTo: villaLabel.bottomAnchor, constant: 8).isActive = true
        villaTextField.leftAnchor.constraint(equalTo: areaHolder.leftAnchor).isActive = true
        villaTextField.rightAnchor.constraint(equalTo: areaHolder.rightAnchor).isActive = true
        villaTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setNextButton() {
        scrollView.addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: villaTextField.bottomAnchor, constant: 16).isActive = true
        nextButton.leftAnchor.constraint(equalTo: villaTextField.leftAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: villaTextField.rightAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
}

extension LocationFirstViewController: UIScrollViewDelegate {
    
}

extension LocationFirstViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
    
}
