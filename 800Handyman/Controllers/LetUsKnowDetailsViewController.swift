//
//  LetUsKnowDetailsViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 9/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Localize_Swift

class LetUsKnowDetailsViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Let Us Know Your Details".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Name".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabelOne: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Phone no".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabelTwo: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Phone no".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "E-mail address (Optional)".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        //field.placeholder = "Your name"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var phoneTextFieldOne: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        //field.placeholder = "Your phone no."
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var phoneTextFieldTwo: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        //field.placeholder = "Your phone no."
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var emailTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        //field.placeholder = "Your e-mail address"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Or".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftHorizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightHorizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.text = "Have an account?".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Log in".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.isUserInteractionEnabled = true
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        layout()
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        /*navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)*/
 
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: nil, action: nil)
    }
    
    private func layout() {
        setTitleLabel()
        setNameLabel()
        setNameTextField()
        setPhoneOneLabel()
        setPhoneOneTextField()
        setEmailLabel()
        setEmailTextField()
        setSubmitButton()
        setOrLabel()
        setLeftHorizontalLine()
        setRightHorizontalLine()
        setHaveAccountLabel()
        setLoginLabel()
        setPhoneLabelTwo()
        setPhoneTextFieldTwo()
        setLoginButton()
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    }
    
    private func setNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setPhoneOneLabel() {
        view.addSubview(phoneLabelOne)
        phoneLabelOne.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8).isActive = true
        phoneLabelOne.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
    }
    
    private func setPhoneOneTextField() {
        view.addSubview(phoneTextFieldOne)
        phoneTextFieldOne.topAnchor.constraint(equalTo: phoneLabelOne.bottomAnchor, constant: 8).isActive = true
        phoneTextFieldOne.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        phoneTextFieldOne.rightAnchor.constraint(equalTo: nameTextField.rightAnchor).isActive = true
        phoneTextFieldOne.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
    }
    
    private func setEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: phoneTextFieldOne.bottomAnchor, constant: 8).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
    }
    
    private func setEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: nameTextField.rightAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
    }
    
    private func setSubmitButton() {
        view.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        submitButton.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        submitButton.rightAnchor.constraint(equalTo: nameTextField.rightAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setOrLabel() {
        view.addSubview(orLabel)
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setLeftHorizontalLine() {
        view.addSubview(leftHorizontalLine)
        leftHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        leftHorizontalLine.rightAnchor.constraint(equalTo: orLabel.leftAnchor, constant: -16).isActive = true
        leftHorizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        leftHorizontalLine.widthAnchor.constraint(equalTo: submitButton.widthAnchor, multiplier: 0.35).isActive = true
    }
    
    private func setRightHorizontalLine() {
        view.addSubview(rightHorizontalLine)
        rightHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        rightHorizontalLine.leftAnchor.constraint(equalTo: orLabel.rightAnchor, constant: 16).isActive = true
        rightHorizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        rightHorizontalLine.widthAnchor.constraint(equalTo: submitButton.widthAnchor, multiplier: 0.35).isActive = true
    }
    
    private func setHaveAccountLabel() {
        view.addSubview(haveAccountLabel)
        haveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20).isActive = true
        haveAccountLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setLoginLabel() {
        view.addSubview(loginLabel)
        loginLabel.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: haveAccountLabel.rightAnchor, constant: 4).isActive = true
    }
    
    private func setPhoneLabelTwo() {
        view.addSubview(phoneLabelTwo)
        phoneLabelTwo.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        phoneLabelTwo.topAnchor.constraint(equalTo: haveAccountLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setPhoneTextFieldTwo() {
        view.addSubview(phoneTextFieldTwo)
        phoneTextFieldTwo.topAnchor.constraint(equalTo: phoneLabelTwo.bottomAnchor, constant: 8).isActive = true
        phoneTextFieldTwo.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        phoneTextFieldTwo.rightAnchor.constraint(equalTo: nameTextField.rightAnchor).isActive = true
        phoneTextFieldTwo.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
    }
    
    private func setLoginButton() {
        view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: phoneTextFieldTwo.bottomAnchor, constant: 8).isActive = true
        loginButton.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        loginButton.rightAnchor.constraint(equalTo: nameTextField.rightAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
