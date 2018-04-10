//
//  TimeSelectCell.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 9/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class TimeSelectCell: MasterCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 4
        layer.borderWidth = 0
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.alpha = isSelected ? 1 : 0
            layer.borderWidth = isSelected ? 1 : 0
            layer.borderColor = isSelected ? YELLOW_ACCENT.cgColor : UIColor.clear.cgColor
        }
    }
    
    override func layout() {
        setTitleLabel()
        setImageView()
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    }
    
    private func setImageView() {
        addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "checkIcon")
        imageView.alpha = 0
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
}
