//
//  ThankYouViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 8/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {
    
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
        label.text = "Your Request Number: #23876"
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
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsIconTapped))
    }
    
    private func layout() {
        setThankYouLabel()
        setSubTitleLabel()
        setRequestNumberLabel()
        setContactLabel()
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
    
}
