//
//  JobDetailsImageCell.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 10/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class JobDetailsImageCell: MasterCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        addSubview(imageView)
        imageView.layer.cornerRadius = 4
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
