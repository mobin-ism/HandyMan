//
//  ThankYouViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 8/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire

class ThankYouViewController: UIViewController {
    
    var serviceRequestMasterID : Int?
    
    let thankYouLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Thank You"
        label.font = UIFont(name: OPENSANS_BOLD, size: 22)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "for placing service request"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reqNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contactLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Someone from our team will contact you soon"
        label.font = UIFont(name: OPENSANS_LIGHTITALIC, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // disabling the thank you message by default
        UserDefaults.standard.set(false, forKey: SHOW_THANK_YOU_MESSAGE)
        self.submitServiceOrder()
        guard let serviceRequestMasterID = self.serviceRequestMasterID else { return }
        print("From Thank You VC Session: \(UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int)")
        print("From Thank You VC Params: \(serviceRequestMasterID)")
        self.reqNumberLabel.text = "Your Request Number: #\(serviceRequestMasterID)"
        layout()
    }
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsIconTapped))
    }
    
    private func layout() {
        setThankYouLabel()
        setSubTitleLabel()
        setRequestNumberLabel()
        setContactLabel()
        setupActivityIndicator()
    }
    
    private func setThankYouLabel() {
        view.addSubview(thankYouLabel)
        thankYouLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thankYouLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        thankYouLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setSubTitleLabel() {
        view.addSubview(subTitleLabel)
        subTitleLabel.centerXAnchor.constraint(equalTo: thankYouLabel.centerXAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: thankYouLabel.bottomAnchor).isActive = true
        subTitleLabel.widthAnchor.constraint(equalTo: thankYouLabel.widthAnchor).isActive = true
    }
    
    private func setRequestNumberLabel() {
        view.addSubview(reqNumberLabel)
        reqNumberLabel.centerXAnchor.constraint(equalTo: thankYouLabel.centerXAnchor).isActive = true
        reqNumberLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 32).isActive = true
        reqNumberLabel.widthAnchor.constraint(equalTo: thankYouLabel.widthAnchor).isActive = true
    }
    
    private func setContactLabel() {
        view.addSubview(contactLabel)
        contactLabel.centerXAnchor.constraint(equalTo: thankYouLabel.centerXAnchor).isActive = true
        contactLabel.topAnchor.constraint(equalTo: reqNumberLabel.bottomAnchor).isActive = true
        contactLabel.widthAnchor.constraint(equalTo: thankYouLabel.widthAnchor).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

// API CALLS
extension ThankYouViewController {
    func submitServiceOrder() {
        self.activityIndicator.startAnimating()
        let params = ["PaymentType" : "Cash_On_Delivery",
                      "ServiceRequestMasterId" : UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int] as [String : Any]
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/submit/complete") else { return }
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
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
