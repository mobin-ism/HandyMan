//
//  ServiceDetailsListViewCell.swift
//  800Handyman
//
//  Created by Creativeitem on 9/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
class ServiceDetailsListViewCell: UICollectionViewCell {
    
    let serviceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subServiceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceTagIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "priceIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var expandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "down_arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove".localized(), for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var service: String? = "" {
        didSet {
            serviceTitleLabel.text = service
        }
    }
    
    var subService : String = "" {
        didSet {
            subServiceTitleLabel.text = subService
        }
    }
    
    var price : String = "" {
        didSet {
            priceTitleLabel.text = price
        }
    }
    
    var serviceListVC = ServiceDetailsListViewController()
    var completedServiceListVC = CompletedServiceDetailsListViewController()
    var pendingServiceListVC   = PendingServiceDetailsListViewController()
    var reschedulePendingOrdersVC = ReschedulePendingOrdersViewController()
    var customerJobDoneVC = CustomerJobDone()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 4
        
        self.serviceImageView.layer.cornerRadius = serviceImageView.frame.height / 2
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        setServiceUIImageView()
        setServiceTitleLabel()
        setSubServiceTitleLabel()
        setExpandButton()
        setERemoveButton()
        setPriceIconImageView()
        setPriceLabel()
    }
    
    private func setServiceUIImageView() {
        self.addSubview(serviceImageView)
        serviceImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        serviceImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private func setServiceTitleLabel() {
        
        self.addSubview(serviceTitleLabel)
        serviceTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        serviceTitleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 10).isActive = true
        serviceTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70).isActive = true
    }
    private func setSubServiceTitleLabel() {
        
        self.addSubview(subServiceTitleLabel)
        subServiceTitleLabel.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 5).isActive = true
        subServiceTitleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 10).isActive = true
        subServiceTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70).isActive = true
    }
    private func setExpandButton() {
        self.addSubview(expandButton)
        expandButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        expandButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setERemoveButton() {
        self.addSubview(removeButton)
        removeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        removeButton.topAnchor.constraint(equalTo: expandButton.bottomAnchor).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func setPriceIconImageView() {
        self.addSubview(priceTagIconView)
        priceTagIconView.topAnchor.constraint(equalTo: subServiceTitleLabel.bottomAnchor, constant: 5).isActive = true
        priceTagIconView.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 10).isActive = true
        priceTagIconView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        priceTagIconView.widthAnchor.constraint(equalToConstant: 12).isActive = true
    }
    private func setPriceLabel() {
        self.addSubview(priceTitleLabel)
        priceTitleLabel.centerYAnchor.constraint(equalTo: priceTagIconView.centerYAnchor).isActive = true
        priceTitleLabel.leadingAnchor.constraint(equalTo: priceTagIconView.trailingAnchor, constant: 5).isActive = true
        priceTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
    }
    
}
