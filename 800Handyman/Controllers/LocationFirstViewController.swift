//
//  LocationFirstViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 9/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import Localize_Swift

class LocationFirstViewController: UIViewController{
    
    var areaNSObject = [AreaNSObject]()
    var selectedAreaID : Int?
    
    var markedLatitude : Double?
    var markedLongitude : Double?
    
    var latitude: Double? = 0.0 {
        didSet {
            self.markedLatitude = latitude!
        }
    }
    
    var longitude: Double? = 0.0 {
        didSet {
            self.markedLongitude = longitude!
        }
    }
    
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
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Area".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Address Name (Optional)".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Address Type".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let streetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Street / Building".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let villaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Apartment no / Villa no".localized()
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
        label.text = "Select An Area".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
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
        //field.placeholder = "Facilisis"
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
        //field.placeholder = "Apartment"
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
        //field.placeholder = "Maecenas"
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
        //field.placeholder = "45, LPT"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
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
    
    lazy var areaSelector: Selector = {
        
        let selector = Selector()
        selector.locationVC = self
        return selector
    }()
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        layout()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        self.mapView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.touchTapped(_:)))
        
        // set map view to current location
        self.setMapViewToCurrentLocation()
        
        self.areaHolder.addGestureRecognizer(tap)
        self.downArrowIcon.addGestureRecognizer(tap)
        self.areaNameLabel.addGestureRecognizer(tap)
        
        self.addressNameTextField.delegate = self
        self.addressTypeTextField.delegate = self
        self.streetTextField.delegate = self
        self.villaTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 500)
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
        
        let position = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        let marker = GMSMarker(position: position)
        marker.icon = self.imageWithImage(image: UIImage(named: "mappin")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
        //marker.map = mapView
    }
    
    private func layout() {
        setMapView()
        setScrollView()
        setAreaLabel()
        setAreaHolder()
        setDownArrowIcon()
        setAreaNameLabel()
        setAddressNameLabel()
        setAddressNameTextField()
        setAddressTypeLabel()
        setAddressTypeTextField()
        setStreetLabel()
        setStreetTextField()
        setVillaLabel()
        setVillaTextField()
        setNextButton()
        
        setupActivityIndicator()
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
    
    private func setDownArrowIcon() {
        areaHolder.addSubview(downArrowIcon)
        downArrowIcon.centerYAnchor.constraint(equalTo: areaHolder.centerYAnchor).isActive = true
        downArrowIcon.rightAnchor.constraint(equalTo: areaHolder.rightAnchor, constant: -16).isActive = true
        downArrowIcon.widthAnchor.constraint(equalToConstant: 11).isActive = true
        downArrowIcon.heightAnchor.constraint(equalToConstant: 11 * 0.6).isActive = true
    }
    
    private func setAreaNameLabel() {
        areaHolder.addSubview(areaNameLabel)
        areaNameLabel.centerYAnchor.constraint(equalTo: areaHolder.centerYAnchor).isActive = true
        areaNameLabel.leftAnchor.constraint(equalTo: areaHolder.leftAnchor, constant: 16).isActive = true
        areaNameLabel.rightAnchor.constraint(equalTo: downArrowIcon.leftAnchor).isActive = true
        areaNameLabel.heightAnchor.constraint(equalTo: areaHolder.heightAnchor).isActive = true
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
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func changeSelectorTitle(withString title: String) {
        self.areaNameLabel.text = title
    }
    
    
    @objc func touchTapped(_ sender: UITapGestureRecognizer) {
        
        self.getAreaList()
    }
    
    //if user is logged in check
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    @objc func handleNextButton() {
        
        self.addAddressOfServiceRequest()
        let timeSlotObj = SelectDateTimeViewController()
        self.navigationController?.pushViewController(timeSlotObj, animated: true)
        
    }
    
    var secondLocationVC = LocationSecondViewController()
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
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
        guard let location = locations.last else { return }
        
        /*This If block will be executed after picking the specific point from LocationSecondViewController*/
        if let markedLatitude = self.markedLatitude, let markedLongitude = self.markedLongitude {
            let camera = GMSCameraPosition.camera(withLatitude: markedLatitude, longitude: markedLongitude, zoom: 16)
            
            let currentLocation = CLLocationCoordinate2DMake(markedLatitude, markedLongitude)
            let marker = GMSMarker(position: currentLocation)
            
            marker.icon = self.imageWithImage(image: UIImage(named: "mappin")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
            mapView.camera = camera
            marker.map = mapView
        }
        else {
            //mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 16)
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


extension LocationFirstViewController : GMSMapViewDelegate {
    
    // MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        if let selectedAreaID = self.selectedAreaID, let selectedAreaName = self.areaNameLabel.text, let addressName = self.addressNameTextField.text, let addressType = self.addressTypeTextField.text, let streetBuilding = self.streetTextField.text, let apartmentNo = self.villaTextField.text {
            
            self.secondLocationVC.selectedAreaID = selectedAreaID
            self.secondLocationVC.selectedAreaName = selectedAreaName
            self.secondLocationVC.addressName = addressName
            self.secondLocationVC.addressType = addressType
            self.secondLocationVC.streetBuilding = streetBuilding
            self.secondLocationVC.apartmentNo = apartmentNo
        }
        
        self.navigationController?.pushViewController(secondLocationVC, animated: true)
    }
    
}

// API Functions
extension LocationFirstViewController {
    
    func showEmptyAlert(){
        let alert = UIAlertController(title: "Ooops!!".localized(), message: "Fields can not be empty".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForEmptyCoordinate(){
        let alert = UIAlertController(title: "Ooops!!".localized(), message: "You have to pick a specific address from the map".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // get the area list for the selector
    func getAreaList(){
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/general/get/areas") else { return }
        Alamofire.request(url,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            if !self.areaNSObject.isEmpty {
                self.areaNSObject.removeAll()
            }
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let areaList = try decoder.decode(AddressResponse.self, from: json)
                    
                    for eachArea in areaList.data.areas{
                        
                        let areaID   = eachArea.areaId
                        let areaName = eachArea.name
                        
                        let areaObj = AreaNSObject(areaId: areaID, areaName: areaName)
                        self.areaNSObject.append(areaObj)
                    }
                    
                    // show selector
                    self.areaSelector.show(withData: self.areaNSObject)
                    self.activityIndicator.stopAnimating()
                    
                    
                } catch let err {
                    print(err)
                }
            }
        })
    }
    
    // posting an address for service request
    func addAddressOfServiceRequest() {
        
        guard let selectedAreaID = self.selectedAreaID else {
            self.showEmptyAlert()
            return
        }
        guard let markedLatitude  = self.markedLatitude else { return }
        guard let markedLongitude = self.markedLongitude else { return }
        guard let areaName        = self.areaNameLabel.text else { return }
        guard let addressName     = self.addressNameTextField.text else { return }
        guard let addressType     = self.addressTypeTextField.text else { return }
        guard let street          = self.streetTextField.text else { return }
        guard let apartmentNo     = self.villaTextField.text else { return }
        
        /*guard let markedLatitude = self.markedLatitude, let markedLongitude = self.markedLongitude else {
            
            self.showAlertForEmptyCoordinate()
            return
        }*/
        
        if selectedAreaID == 0 || addressType == "" || street == "" || apartmentNo == "" {
            
            self.showEmptyAlert()
            return
        }
        
        print("Master Service Id is: \(UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int)") 
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/area/update") else { return }
        let params = ["ServiceRequestMasterId": UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int,
                      "MemberId" : UserDefaults.standard.value(forKey: MEMBER_ID) as! Int,
                      "AddressName" : addressName,
                      "AddressType" : addressType,
                      "Street" : street,
                      "ApartmentNo" : apartmentNo,
                      "Location" : areaName,
                      "AreaId" : selectedAreaID,
                      "Latitude" : markedLatitude,
                      "Longitude" : markedLongitude
                      ] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type": "application/x-www-form-urlencoded", "Authorization" : AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            print(response)
            print(params)
            
            self.activityIndicator.stopAnimating()
        })
        
    }
}

extension LocationFirstViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.addressNameTextField {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
        else if textField == self.addressTypeTextField {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 120), animated: true)
        }
        else {
            
          scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

