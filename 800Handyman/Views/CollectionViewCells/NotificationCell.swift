//
//  NotificationCell.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 7/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class NotificationCell: MasterCollectionViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "calendarIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "serviceHours")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var time: String? = "" {
        didSet {
            timeLabel.text = time
        }
    }
    
    var date: String? = "" {
        didSet {
            dateLabel.text = date
        }
    }
    
    var notification: String? = "" {
        didSet {
            notificationLabel.text = notification
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        setTitleLabel()
        setTimeIcon()
        setTimeLabel()
        setDateIcon()
        setDateLabel()
        setNotificationLabel()
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setTimeIcon() {
        addSubview(timeIconView)
        timeIconView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8).isActive = true
        timeIconView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        timeIconView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        timeIconView.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    private func setTimeLabel() {
        addSubview(timeLabel)
        timeLabel.centerYAnchor.constraint(equalTo: timeIconView.centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: timeIconView.trailingAnchor, constant: 2).isActive = true
    }
    
    private func setDateIcon() {
        addSubview(dateIconView)
        dateIconView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 16).isActive = true
        dateIconView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        dateIconView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        dateIconView.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    private func setDateLabel() {
        addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: timeIconView.centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateIconView.trailingAnchor, constant: 2).isActive = true
    }
    
    private func setNotificationLabel() {
        addSubview(notificationLabel)
        notificationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        notificationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        notificationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        notificationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
}
