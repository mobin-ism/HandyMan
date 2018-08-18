//
//  ProfileInfoCell.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 8/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class ProfileInfoCell: MasterCollectionViewCell {
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 10)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var info: String? = "" {
        didSet {
            infoLabel.text = info
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
        setInfoLabel()
        setMainLabel()
        setImage()
    }
    
    private func setInfoLabel() {
        addSubview(infoLabel)
        infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    }
    
    private func setMainLabel() {
        addSubview(titleLabel)
        titleLabel.textAlignment = .natural
        titleLabel.font = UIFont(name: OPENSANS_SEMIBOLD, size: 20)
        titleLabel.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setImage() {
        addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "rightArrowSmall")
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 7).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 7 * 1.69).isActive = true
    }
    
}
