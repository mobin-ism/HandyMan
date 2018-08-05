//
//  HorizontalCollectionViewCell.swift
//  800Handyman
//
//  Created by Al Mobin on 5/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
class HorizontalCollectionViewCell: UICollectionViewCell {
    
    var AEDLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.text = "AED"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    var priceText: String? = "" {
        didSet {
            priceLabel.text = priceText
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layout()
    }
    
    override var isSelected: Bool {
        didSet {
            /*layer.borderWidth = isSelected ? 2 : 0
            layer.borderColor = isSelected ? YELLOW_ACCENT.cgColor : UIColor.clear.cgColor*/
            
            self.backgroundColor = isSelected ? YELLOW_ACCENT : UIColor.white
            self.AEDLabel.textColor = isSelected ? UIColor.white : UIColor.black
            self.priceLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func layout() {
        setAEDLabel()
        setPriceLabel()
    }
    
    func setAEDLabel() {
        self.addSubview(AEDLabel)
        AEDLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        AEDLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
    }
    func setPriceLabel() {
        self.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: AEDLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
}

