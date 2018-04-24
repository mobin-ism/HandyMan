//
//  MessageCell.swift
//  800Handyman
//
//  Created by Creativeitem on 23/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
class ReceiverMessageCell: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let seenStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let receiverTailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 10
        imageView.image = #imageLiteral(resourceName: "receiver_tail")
        return imageView
    }()
    
    let receiverMessageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let receiverTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .right
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.4
        label.textColor = .black
        return label
    }()
    
    var receiverText: String? = "" {
        didSet {
            receiverTextLabel.text = receiverText
        }
    }
    
    var timeText: String? = "" {
        didSet {
            timeLabel.text = timeText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.receiverMessageContainer.layer.cornerRadius = 4
        setupSubviews()
    }
    
    private func setupSubviews() {
        setupImageView()
        setupReceiverMessageContainter()
        setupReceiverTextLabel()
        setupTimeLabel()
        setupSeenStatusImageView()
        setupReceiverTail()
    }
    
    private func setupImageView() {
        self.addSubview(profileImageView)
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupReceiverMessageContainter() {
        self.addSubview(receiverMessageContainer)
        receiverMessageContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        receiverMessageContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        receiverMessageContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        receiverMessageContainer.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    private func setupReceiverTextLabel() {
        receiverMessageContainer.addSubview(receiverTextLabel)
        receiverTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        receiverTextLabel.leftAnchor.constraint(equalTo: receiverMessageContainer.leftAnchor, constant: 5).isActive = true
        receiverTextLabel.rightAnchor.constraint(equalTo: receiverMessageContainer.rightAnchor, constant: -5).isActive = true
    }
    
    private func setupTimeLabel() {
        self.addSubview(timeLabel)
        timeLabel.rightAnchor.constraint(equalTo: receiverMessageContainer.rightAnchor, constant: -30).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: receiverMessageContainer.topAnchor, constant: -5).isActive = true
        
    }
    
    private func setupSeenStatusImageView() {
        
        self.addSubview(seenStatusImageView)
        seenStatusImageView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
        seenStatusImageView.leftAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: 5).isActive = true
        seenStatusImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        seenStatusImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupReceiverTail(){
        self.addSubview(receiverTailImageView)
        receiverTailImageView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        receiverTailImageView.rightAnchor.constraint(equalTo: receiverMessageContainer.leftAnchor).isActive = true
        receiverTailImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        receiverTailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

