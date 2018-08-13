//
//  LanguageSelectViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift

class LanguageSelectViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "background"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "langLogo"))
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
        button.addTarget(self, action: #selector(englishButtonTapped(_:)), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(arabicButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        setupActivityIndicator()
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
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func englishButtonTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set("en", forKey: SELECTED_LANGUAGE)
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        self.registerDeviceToken()
        Localize.setCurrentLanguage("en")
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func arabicButtonTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set("ar", forKey: SELECTED_LANGUAGE)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        self.registerDeviceToken()
        Localize.setCurrentLanguage("ar")
        dismiss(animated: true, completion: nil)
    }
    
    func registerDeviceToken(){
        print(UserDefaults.standard.value(forKey: DEVICE_ID) as! String)
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/device/register") else { return }
        let params = ["DeviceId": UserDefaults.standard.value(forKey: DEVICE_ID) as! String] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type": "application/x-www-form-urlencoded", "Authorization" : AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            print(response)
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let deviceResponse = try decoder.decode(DeviceResponse.self, from: json)
                    
                    UserDefaults.standard.set(deviceResponse.data.member.memberId, forKey: MEMBER_ID)
                    self.activityIndicator.stopAnimating()
                } catch let err {
                    print(err)
                }
            }

            self.activityIndicator.stopAnimating()
        })
    }
    
}
