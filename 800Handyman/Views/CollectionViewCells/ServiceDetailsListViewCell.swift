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
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subServiceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
        imageView.contentMode = .scaleAspectFill
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
        setPriceIconImageView()
        setPriceLabel()
        
    }
    
    private func setServiceUIImageView() {
        self.addSubview(serviceImageView)
        serviceImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        serviceImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private func setServiceTitleLabel() {
        
        self.addSubview(serviceTitleLabel)
        serviceTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        serviceTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    private func setSubServiceTitleLabel() {
        
        self.addSubview(subServiceTitleLabel)
        subServiceTitleLabel.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 5).isActive = true
        subServiceTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    private func setExpandButton() {
        self.addSubview(expandButton)
        expandButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        expandButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func setPriceIconImageView() {
        self.addSubview(priceTagIconView)
        priceTagIconView.topAnchor.constraint(equalTo: subServiceTitleLabel.bottomAnchor, constant: 5).isActive = true
        priceTagIconView.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        priceTagIconView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        priceTagIconView.widthAnchor.constraint(equalToConstant: 12).isActive = true
    }
    private func setPriceLabel() {
        self.addSubview(priceTitleLabel)
        priceTitleLabel.centerYAnchor.constraint(equalTo: priceTagIconView.centerYAnchor).isActive = true
        priceTitleLabel.leftAnchor.constraint(equalTo: priceTagIconView.rightAnchor, constant: 5).isActive = true
    }
    
}
