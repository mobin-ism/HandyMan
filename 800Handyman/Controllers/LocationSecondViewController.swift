//
//  LocationSecondViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 9/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Localize_Swift

class LocationSecondViewController: UIViewController {
    
    var selectedAreaID : Int?
    var selectedAreaName : String?
    var addressName : String?
    var addressType : String?
    var streetBuilding : String?
    var apartmentNo : String?
    
    var markedLatitude : Double?
    var markedLongitude : Double?
    private let locationManager = CLLocationManager()
    
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
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Address".localized()
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 10)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLineOne: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        //label.text = "P Block, Emaar Business Park"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLineTwo: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
        self.setMapViewToCurrentLocation()
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
    
    func setMapViewToCurrentLocation() {
        
        guard let currentLatitude  = locationManager.location?.coordinate.latitude else { return }
        guard let currentLongitude = locationManager.location?.coordinate.longitude else { return }
        
        let currentLocation = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        mapView.animate(toLocation: currentLocation)
        mapView.animate(toZoom: 16)
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
    
    @objc private func handleLocationConfirmedButton(){
        
        let firstLocationViewController = LocationFirstViewController()
        firstLocationViewController.markedLatitude = self.markedLatitude
        firstLocationViewController.markedLongitude = self.markedLongitude
        firstLocationViewController.streetTextField.text = self.addressLineOne.text
        if let selectedAreaID = self.selectedAreaID, let selectedAreaName = self.selectedAreaName, let addressName = self.addressName, let addressType = self.addressType, let apartmentNo = self.apartmentNo {
            firstLocationViewController.selectedAreaID = selectedAreaID
            firstLocationViewController.areaNameLabel.text = selectedAreaName
            firstLocationViewController.addressNameTextField.text = addressName
            firstLocationViewController.addressTypeTextField.text = addressType
            firstLocationViewController.villaTextField.text = apartmentNo
        }
        
        self.navigationController?.pushViewController(firstLocationViewController, animated: true)
        
    }
    
    @objc private func handleBackButton(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension LocationSecondViewController : GMSMapViewDelegate {
    
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

extension LocationSecondViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        /*This If block will be executed after picking the specific point from LocationSecondViewController*/
        if let markedLatitude = self.markedLatitude, let markedLongitude = self.markedLongitude {
            let camera = GMSCameraPosition.camera(withLatitude: markedLatitude, longitude: markedLongitude, zoom: 17)
            
            let currentLocation = CLLocationCoordinate2DMake(markedLatitude, markedLongitude)
            let marker = GMSMarker(position: currentLocation)
            
            marker.icon = self.imageWithImage(image: UIImage(named: "mappin")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
            mapView.camera = camera
            marker.map = mapView
        }
        else {
            //mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 17)
            mapView.camera = camera
            
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
