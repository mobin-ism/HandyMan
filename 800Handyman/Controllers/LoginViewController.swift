//
//  LoginViewController.swift
//  800Handyman
//
//  Created by Creativeitem on 18/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift
class LoginViewController : UIViewController{
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isUserInteractionEnabled = true
        return scroll
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        //label.text = "Let Us Know Your Details".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let namelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "Name".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "Phone no.".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailAddressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "E-mail address (Optional)".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var leftHorizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightHorizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "Or".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "Have an account? Login".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "Log in".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneNumberForLoginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        //label.text = "Phone No.".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
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
        //field.placeholder = "Your Name"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var phoneNoTextField: PaddedTextField = {
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
    
    lazy var phoneNoForLoginTextField: PaddedTextField = {
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
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        //button.setTitle("SUBMIT".localized(), for: .normal)
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        //button.setTitle("LOGIN".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLoginButton(_:)), for: .touchUpInside)
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
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.loginVC = self
        return slideMenu
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
        
        self.nameTextField.delegate = self
        self.phoneNoTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneNoForLoginTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isLoggedIn()
        print("Hello")
        if (UserDefaults.standard.value(forKey: SELECTED_LANGUAGE) as! String == "ar") {
            self.namelabel.text = "الإسم"
            self.phoneNumberForLoginLabel.text = "رقم الهاتف."
            self.emailAddressLabel.text = "عنوان البريد الإلكتروني (اختياري)"
            self.submitButton.setTitle("خضع", for: .normal)
            self.haveAnAccountLabel.text = "لديك حساب؟"
            self.orLabel.text = "أو"
            self.phoneNumberLabel.text = "رقم الهاتف."
            self.loginButton.setTitle("تسجيل الدخول", for: .normal)
        }
        else {
            self.namelabel.text = "Name"
            self.phoneNumberForLoginLabel.text = "Phone No."
            self.emailAddressLabel.text = "E-mail address (Optional)"
            self.submitButton.setTitle("Submit", for: .normal)
            self.haveAnAccountLabel.text = "Have an account?"
            self.orLabel.text = "Or"
            self.phoneNumberLabel.text = "Phone No."
            self.loginButton.setTitle("Login", for: .normal)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 1000)
          //scrollView.contentSize = CGSize(width: view.frame.width, height: 1500)
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    func isLoggedIn() {
        if UserDefaults.standard.value(forKey: SHOW_THANK_YOU_MESSAGE) as! Bool == false {
            if Helper.Exists(key: IS_LOGGED_IN){
                if UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
                    self.navigationController?.pushViewController(JobListViewController(), animated: true)
                }
            }
        }
    }
    @objc private func menuIconTapped() {
        self.menu.show(fromVC: self)
    }

    private func layout() {
        setScrollView()
        setupPageTitleLable()
        setupNameLabel()
        setupNameTextField()
        setupPhoneNoLabel()
        setupPhoneNoTextField()
        setupEmailLabel()
        setupEmailTextField()
        setupSubmitButton()
        setupOrLabel()
        setupLeftHorizontalLine()
        setupRightHorizontalLine()
        setupHaveAnAccountLabel()
        //setupLoginLabel()
        setupPhoneNumberForLoginLabel()
        setupPhoneNoForLoginTextField()
        setupLoginButton()
        setupActivityIndicator()
        
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupPageTitleLable(){
        scrollView.addSubview(pageTitle)
        pageTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        pageTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
    }
    
    private func setupNameLabel(){
        
        scrollView.addSubview(namelabel)
        namelabel.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 25).isActive = true
        namelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        namelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupNameTextField(){
        
        scrollView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: 10).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: namelabel.trailingAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupPhoneNoLabel(){
        
        scrollView.addSubview(phoneNumberLabel)
        phoneNumberLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        phoneNumberLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        phoneNumberLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
    }
    
    private func setupPhoneNoTextField(){
        
        scrollView.addSubview(phoneNoTextField)
        phoneNoTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10).isActive = true
        phoneNoTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        phoneNoTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        phoneNoTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupEmailLabel(){
        
        scrollView.addSubview(emailAddressLabel)
        emailAddressLabel.topAnchor.constraint(equalTo: phoneNoTextField.bottomAnchor, constant: 10).isActive = true
        emailAddressLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        emailAddressLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
    }
    
    private func setupEmailTextField(){
        
        scrollView.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupSubmitButton(){
        
        scrollView.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupPhoneNumberForLoginLabel(){
        scrollView.addSubview(phoneNumberForLoginLabel)
        phoneNumberForLoginLabel.topAnchor.constraint(equalTo: haveAnAccountLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberForLoginLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        phoneNumberForLoginLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
    }
    private func setupPhoneNoForLoginTextField(){
        
        scrollView.addSubview(phoneNoForLoginTextField)
        phoneNoForLoginTextField.topAnchor.constraint(equalTo: phoneNumberForLoginLabel.bottomAnchor, constant: 10).isActive = true
        phoneNoForLoginTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        phoneNoForLoginTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        phoneNoForLoginTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupLoginButton(){
        
        scrollView.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: phoneNoForLoginTextField.bottomAnchor, constant: 10).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupOrLabel(){
        
        scrollView.addSubview(orLabel)
        orLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        orLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 25).isActive = true
    }
    
    private func setupLeftHorizontalLine(){
        
        scrollView.addSubview(leftHorizontalLine)
        leftHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        leftHorizontalLine.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        leftHorizontalLine.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -10).isActive = true
        leftHorizontalLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setupRightHorizontalLine(){
        
        scrollView.addSubview(rightHorizontalLine)
        rightHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        rightHorizontalLine.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 10).isActive = true
        rightHorizontalLine.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        rightHorizontalLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setupHaveAnAccountLabel(){
        
        scrollView.addSubview(haveAnAccountLabel)
        haveAnAccountLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 10).isActive = true
        haveAnAccountLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -5).isActive = true
    }
    
    private func setupLoginLabel(){
        
        scrollView.addSubview(loginLabel)
        loginLabel.centerYAnchor.constraint(equalTo: haveAnAccountLabel.centerYAnchor).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 5).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func handleLoginButton(_ sender: UIButton){
        
        self.getTokenID()
    }
    
    @objc private func handleSubmitButton(_ sender: UIButton){
        
        self.doRegisterUser()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func loginFieldEmptyAlert(){
        
        let alert = UIAlertController(title: "Ooops!!".localized(), message: "Phone number field can not be empty".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func registrationFieldsEmptyAlert(){
        
        let alert = UIAlertController(title: "Ooops!!".localized(), message: "Registration fields can not be empty".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func invalidEmailAlert(){
        
        let alert = UIAlertController(title: "Invalid Email Address".localized(), message: "Please provide a valid email address".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loginFailed(){
        
        let alert = UIAlertController(title: "Ooops!!".localized(), message: "Login Failed".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try Again".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func registrationFailedAlert(){
        
        let alert = UIAlertController(title: "Ooops!!".localized(), message: "Registration failed".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try Again".localized(), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func registrationSuccessfullyDoneAlert(tokenID : String, phoneNumber: String) {
        
        let alert = UIAlertController(title: "Congratulations!!!".localized(), message: "Registration Successfully Done".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close".localized(), style: .default, handler: { action in
            //run your function here
            self.doLoginWithToken(tokenID: tokenID, phoneNumber: phoneNumber)
            self.makeFormEmpty()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeFormEmpty() {
        
        self.nameTextField.text            = ""
        self.phoneNoTextField.text         = ""
        self.emailTextField.text           = ""
        self.phoneNoForLoginTextField.text = ""
    }
    
    func setSelectedIndex(at index: Int) {
        if (index == 3) {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
        else if(index == 4) {
            // Modal for changing the Language view
            DispatchQueue.main.async {
                self.present(LanguageSelectViewController(), animated: true, completion: nil)
            }
        }
        else if(index == 5) {
            if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
                Alert.logOutConfirmationAlert(on: self)
            }
            else {
                navigationController?.tabBarController?.selectedIndex = 2
            }
        }
        else {
            navigationController?.tabBarController?.selectedIndex = index
            //CustomTabBarController().selectedIndex = index
        }
    }
}

extension LoginViewController: UIScrollViewDelegate {
    
}

// API Functions
extension LoginViewController {
    
    private func getTokenID(){
        
        guard let phoneNumber = self.phoneNoForLoginTextField.text else {
            
            self.loginFieldEmptyAlert()
            return
        }
        if phoneNumber == "" {
            
            self.loginFieldEmptyAlert()
            return
        }
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/login") else { return }
        let params = ["PhoneNumber" : phoneNumber] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            //print(response)
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    
                    let tokenValidity = try decoder.decode(TokenValidity.self, from: json)
                    
                    if tokenValidity.isSuccess {
                        let tokenResponse = try decoder.decode(TokenReponse.self, from: json)
                        self.doLoginWithToken(tokenID: tokenResponse.data.token, phoneNumber: phoneNumber)
                    }
                    else {
                        self.loginFailed()
                        self.activityIndicator.stopAnimating()
                    }
                    
                    return

                } catch let err {
                    print(err)
                }
            }
            
            // code after a successfull reponse
            
        })
    }
    
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
                            self.loginFailed()
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
    
    
    // Register user
    func doRegisterUser() {
        
        guard let name = self.nameTextField.text, let phoneNumber = self.phoneNoTextField.text, let email = self.emailTextField.text else { return }
        
        if name == "" || phoneNumber == "" || email == "" {
            
            self.registrationFieldsEmptyAlert()
            return
        }
        else {
            let validity = self.checkEmailValidation(email: email)
            if  !validity {
                self.invalidEmailAlert()
                return
            }
        }
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/register") else { return }
        let params = ["MemberId"    : UserDefaults.standard.value(forKey: MEMBER_ID) as! Int,
                      "PhoneNumber" : phoneNumber,
                      "Email"       : email,
                      "Name"        : name] as [String : Any]
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
                    
                    let registrationResponse = try decoder.decode(RegistrationValidity.self, from: json)
                    
                    if  registrationResponse.isSuccess {
                        
                        self.registrationSuccessfullyDoneAlert(tokenID: registrationResponse.data.token, phoneNumber: phoneNumber)
                    }
                    else{
                        self.registrationFailedAlert()
                    }
                    
                } catch let err{
                    
                    print(err)
                }
            }
            
            // code after a successfull reponse
            self.activityIndicator.stopAnimating()
        })
    }
    
    func checkEmailValidation(email: String) -> Bool{
        // alternative: not case sensitive
        if  email.lowercased().range(of:"@") != nil && email.lowercased().range(of:".com") != nil {
            return true
        }
        else {
            return false
        }
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.phoneNoForLoginTextField {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
