//
//  SenderMessageCell.swift
//  800Handyman
//
//  Created by Creativeitem on 24/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation
class SenderMessageCell: UICollectionViewCell {
    
    let senderTailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "sender_tail")
        return imageView
    }()
    
    let seenStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let senderMessageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = YELLOW_ACCENT
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let senderTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
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
    
    var senderText: String? = "" {
        didSet {
            senderTextLabel.text = senderText
        }
    }
    
    var timeText: String? = "" {
        didSet {
            timeLabel.text = timeText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.senderMessageContainer.layer.cornerRadius = 4
        setupSubviews()
    }
    
    private func setupSubviews() {
        setupSenderMessageContainter()
        setupSenderTextLabel()
        setupTimeLabel()
        setupSeenStatusImageView()
        setupSenderTail()
    }
    
    func setupSenderMessageContainter() {
        self.addSubview(senderMessageContainer)
        senderMessageContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        senderMessageContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        senderMessageContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        senderMessageContainer.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    private func setupSenderTextLabel() {
        senderMessageContainer.addSubview(senderTextLabel)
        senderTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        senderTextLabel.leftAnchor.constraint(equalTo: senderMessageContainer.leftAnchor, constant: 15).isActive = true
        senderTextLabel.rightAnchor.constraint(equalTo: senderMessageContainer.rightAnchor, constant: -5).isActive = true
        
    }
    
    private func setupTimeLabel() {
        self.addSubview(timeLabel)
        timeLabel.rightAnchor.constraint(equalTo: senderMessageContainer.rightAnchor, constant: -30).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: senderMessageContainer.topAnchor, constant: -5).isActive = true
    }
    
    private func setupSeenStatusImageView() {
        
        self.addSubview(seenStatusImageView)
        seenStatusImageView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
        seenStatusImageView.leftAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: 5).isActive = true
        seenStatusImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        seenStatusImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setupSenderTail(){
        self.addSubview(senderTailImageView)
        senderTailImageView.leftAnchor.constraint(equalTo: senderMessageContainer.rightAnchor).isActive = true
        senderTailImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        senderTailImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        senderTailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
