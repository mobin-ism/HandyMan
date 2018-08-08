//
//  PhoneCallViewController.swift
//  800Handyman
//
//  Created by Creativeitem on 7/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
class PhoneCallViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "profileBg")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "phone-call")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.phoneCallVC = self
        return slideMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.call()
    }
    func setNavigationBar() {
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationController?.navigationBar.topItem?.titleView = imageView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(fromVC: self)
    }
    
    func layout() {
        setBackgroundImage()
        setPhoneImage()
    }
    
    private func setBackgroundImage() {
        view.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setPhoneImage() {
        view.addSubview(phoneImageView)
        phoneImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        phoneImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        phoneImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        phoneImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func call() {
        let phoneNumber = PHONE_NUMBER
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
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
