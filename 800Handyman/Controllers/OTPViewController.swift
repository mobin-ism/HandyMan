//
//  OTPViewController.swift
//  800Handyman
//
//  Created by Creativeitem on 30/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift
class OTPViewController : UIViewController{
    
    var tokenID : String?
    var phoneNumber: String?
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isUserInteractionEnabled = true
        return scroll
    }()
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Please enter your security number".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var securityNumberTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor(red:0.99, green:0.85, blue:0.21, alpha:1.0).cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSubmitButton(_:)), for: .touchUpInside)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
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
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        layout()
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.securityNumberTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 140)
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    @objc private func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func layout() {
        setScrollView()
        setupSubmitButton()
        setupSecurityNumberTextField()
        setupTitleLabel()
        setupActivityIndicator()
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel(){
        scrollView.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: securityNumberTextField.topAnchor, constant: -10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupSecurityNumberTextField(){
        scrollView.addSubview(securityNumberTextField)
        securityNumberTextField.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -10).isActive = true
        securityNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        securityNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        securityNumberTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupSubmitButton(){
        scrollView.addSubview(submitButton)
        submitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func handleLoginButton(_ sender: UIButton){
        
        
    }
    
    @objc private func handleSubmitButton(_ sender: UIButton){
        guard let tokenID = self.tokenID else { return }
        guard let securityNumber = self.securityNumberTextField.text else { return }
        guard let phoneNumber = self.phoneNumber else { return }
        if tokenID == securityNumber {
            self.doLoginWithToken(tokenID: securityNumber, phoneNumber: phoneNumber)
        }else {
            self.invalidSecurityAlert()
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func invalidSecurityAlert(){
        
        let alert = UIAlertController(title: "Invalid security number".localized(), message: "Please provide a security number".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeFormEmpty() {
        
        self.securityNumberTextField.text = ""
    }
}

extension OTPViewController: UIScrollViewDelegate {
    
}

extension OTPViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

// API Functions
extension OTPViewController {
    private func doLoginWithToken(tokenID : String, phoneNumber: String) {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/token/submit") else { return }
        let params = ["PhoneNumber" : phoneNumber,
                      "SecurityKey" : tokenID] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
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
                    
                    let loginResponse = try decoder.decode(LoginResponse.self, from: json)
                    
                    if  loginResponse.isSuccess {
                        
                        UserDefaults.standard.set(true, forKey: IS_LOGGED_IN)
                        UserDefaults.standard.set(loginResponse.data.member.memberId, forKey: MEMBER_ID)
                        if UserDefaults.standard.value(forKey: SHOW_THANK_YOU_MESSAGE) as! Bool {
                            let thankYouOBJ = ThankYouViewController()
                            thankYouOBJ.serviceRequestMasterID = UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as? Int
                            self.navigationController?.pushViewController(thankYouOBJ, animated: true)
                        }
                        else {
                            self.navigationController?.pushViewController(JobListViewController(), animated: true)
                        }
                    }
                    else{
                        self.invalidSecurityAlert()
                    }
                    
                } catch let err{
                    
                    print(err)
                }
            }
            // code after a successfull reponse
            self.activityIndicator.stopAnimating()
            
            self.makeFormEmpty()
        })
    }
}


