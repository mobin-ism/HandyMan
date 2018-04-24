//
//  ServiceMenuCell.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 5/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class ServiceMenuCell: MasterCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
        layout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
