//
//  LanguageSelectViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class LanguageSelectViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "background"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "lang_logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Select your preferred language", comment: "select preferred language")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ENGLISH", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let arabicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ARABIC", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        layout()
    }
    
    private func layout() {
        setBackgroundImageView()
        setLogoImageView()
        setTitleLabel()
        setEnglishButton()
        setArabicButton()
    }
    
    private func setBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func setLogoImageView() {
        let width = view.frame.width * 0.8
        let height = width * 0.87
        view.addSubview(logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setEnglishButton() {
        let width = view.frame.width * 0.35
        let height = width * 0.35
        view.addSubview(englishButton)
        englishButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        englishButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        englishButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        englishButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setArabicButton() {
        view.addSubview(arabicButton)
        arabicButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        arabicButton.topAnchor.constraint(equalTo: englishButton.topAnchor).isActive = true
        arabicButton.widthAnchor.constraint(equalTo: englishButton.widthAnchor).isActive = true
        arabicButton.heightAnchor.constraint(equalTo: englishButton.heightAnchor).isActive = true
    }
    
}
