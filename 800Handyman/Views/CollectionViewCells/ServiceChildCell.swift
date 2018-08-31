//
//  ServiceChildCell.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 5/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class ServiceChildCell: MasterCollectionViewCell {
    
    let leftHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconOne: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconTwo: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serviceHourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightArrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "rightArrowSmall")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var subTitleText: String? = "" {
        didSet {
            subTitleLabel.text = subTitleText
        }
    }
    
    var priceIcon: UIImage? = nil {
        didSet {
            iconOne.image = priceIcon
        }
    }
    
    var price: String? = "" {
        didSet {
            priceLabel.text = price
        }
    }
    
    var serviceIcon: UIImage? = nil {
        didSet {
            iconTwo.image = serviceIcon
        }
    }
    
    var serviceHours: String? = "" {
        didSet {
            serviceHourLabel.text = serviceHours
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 4
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        addSubview(leftHolder)
        leftHolder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftHolder.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        leftHolder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        leftHolder.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        
        addSubview(rightHolder)
        rightHolder.topAnchor.constraint(equalTo: leftHolder.topAnchor).isActive = true
        rightHolder.leadingAnchor.constraint(equalTo: leftHolder.trailingAnchor, constant: 8).isActive = true
        rightHolder.bottomAnchor.constraint(equalTo: leftHolder.bottomAnchor).isActive = true
        rightHolder.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
        setTitleLabel()
        setSubTitleLabel()
        setIconOne()
        setPricelabel()
        setIconTwo()
        setServiceHourLabel()
        setRightArrowIcon()
    }
    
    private func setTitleLabel() {
        leftHolder.addSubview(titleLabel)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        titleLabel.numberOfLines = 0
        titleLabel.topAnchor.constraint(equalTo: leftHolder.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leftHolder.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: leftHolder.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setSubTitleLabel() {
        leftHolder.addSubview(subTitleLabel)
        subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    private func setIconOne() {
        rightHolder.addSubview(iconOne)
        iconOne.topAnchor.constraint(equalTo: rightHolder.topAnchor, constant: 8).isActive = true
        iconOne.leadingAnchor.constraint(equalTo: rightHolder.leadingAnchor, constant: 0).isActive = true
        iconOne.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconOne.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setPricelabel() {
        rightHolder.addSubview(priceLabel)
        priceLabel.centerYAnchor.constraint(equalTo: iconOne.centerYAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: iconOne.trailingAnchor, constant: 4).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: rightHolder.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setIconTwo() {
        rightHolder.addSubview(iconTwo)
        iconTwo.leadingAnchor.constraint(equalTo: iconOne.leadingAnchor).isActive = true
        iconTwo.topAnchor.constraint(equalTo: iconOne.bottomAnchor, constant: 8).isActive = true
        iconTwo.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconTwo.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setServiceHourLabel() {
        rightHolder.addSubview(serviceHourLabel)
        serviceHourLabel.centerYAnchor.constraint(equalTo: iconTwo.centerYAnchor).isActive = true
        serviceHourLabel.leadingAnchor.constraint(equalTo: iconTwo.trailingAnchor, constant: 4).isActive = true
        serviceHourLabel.trailingAnchor.constraint(equalTo: rightHolder.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setRightArrowIcon() {
        addSubview(rightArrowIcon)
        rightArrowIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightArrowIcon.leadingAnchor.constraint(equalTo: rightHolder.trailingAnchor).isActive = true
        rightArrowIcon.widthAnchor.constraint(equalToConstant: 7).isActive = true
        rightArrowIcon.heightAnchor.constraint(equalToConstant: 7 * 1.69).isActive = true
    }
    
}
