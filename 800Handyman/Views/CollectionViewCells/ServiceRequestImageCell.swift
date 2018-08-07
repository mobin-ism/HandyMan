//
//  ServiceRequestImageCell.swift
//  800Handyman
//
//  Created by Al Mobin on 17/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class ServiceRequestImageCell: MasterCollectionViewCell {
    
    lazy var serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.systemLayoutSizeFitting(CGSize(width: 200, height: 200))
        return imageView
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:0.8)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        addSubview(serviceImageView)
        serviceImageView.layer.cornerRadius = 4
        serviceImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        serviceImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        serviceImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        serviceImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(removeButton)
        removeButton.bottomAnchor.constraint(equalTo: serviceImageView.bottomAnchor).isActive = true
        removeButton.leftAnchor.constraint(equalTo: serviceImageView.leftAnchor).isActive = true
        removeButton.rightAnchor.constraint(equalTo: serviceImageView.rightAnchor).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
