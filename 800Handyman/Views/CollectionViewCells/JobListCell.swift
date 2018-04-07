//
//  JobListCell.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 8/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class JobListCell: MasterCollectionViewCell {
    
    let scheduleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let calendarIconView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "calendarIcon")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pendingIconView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "pendingIcon")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pendingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var scheduleDate: String? = "" {
        didSet {
            scheduleLabel.text = scheduleDate
        }
    }
    
    var totalAmount: String? = "" {
        didSet {
            totalAmountLabel.text = totalAmount
        }
    }
    
    var date: String? = "" {
        didSet {
            dateLabel.text = date
        }
    }
    
    var pending: String? = "" {
        didSet {
            pendingLabel.text = pending
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
        setMainImage()
        setTitleLabel()
        setScheduleDateLabel()
        setTotalAmountLabel()
        setCalendarIcon()
        setDateLabel()
        setPendingLabel()
        setPendingIcon()
    }
    
    private func setMainImage() {
        addSubview(imageView)
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = YELLOW_ACCENT
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setScheduleDateLabel() {
        addSubview(scheduleLabel)
        scheduleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        scheduleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        scheduleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
    
    private func setTotalAmountLabel() {
        addSubview(totalAmountLabel)
        totalAmountLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 4).isActive = true
        totalAmountLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        totalAmountLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
    
    private func setCalendarIcon() {
        addSubview(calendarIconView)
        calendarIconView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        calendarIconView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        calendarIconView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        calendarIconView.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    private func setDateLabel() {
        addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: calendarIconView.rightAnchor, constant: 2).isActive = true
    }
    
    private func setPendingLabel() {
        addSubview(pendingLabel)
        pendingLabel.centerYAnchor.constraint(equalTo: scheduleLabel.centerYAnchor).isActive = true
        pendingLabel.rightAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true
    }
    
    private func setPendingIcon() {
        addSubview(pendingIconView)
        pendingIconView.centerYAnchor.constraint(equalTo: scheduleLabel.centerYAnchor).isActive = true
        pendingIconView.rightAnchor.constraint(equalTo: pendingLabel.leftAnchor, constant: -4).isActive = true
        pendingIconView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        pendingIconView.heightAnchor.constraint(equalToConstant: 8 * 1.25).isActive = true
    }
    
}
