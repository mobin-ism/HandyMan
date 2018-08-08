//
//  Menu.swift
//  800Handyman
//
//  Created by Al Mobin on 17/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class Menu: NSObject {
    
    var vc = UIViewController()
    
    var homeController = HomeViewController()
    var notificationVC = NotificationViewController()
    var profileVC = ProfileViewController()
    var chatVC = ChatViewController()
    var customTabBar = CustomTabBarController()
    var loginVC = LoginViewController()
    var jobListVC = JobListViewController()
    var phoneCallVC = PhoneCallViewController()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:0.7)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = YELLOW_ACCENT
        view.clipsToBounds = true
        return view
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "langLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.separatorColor = UIColor.black
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let cellId = "MenuCell"
    let menuItems = ["Home", "Notification", "Service History", "Profile", "Language", "Logout"]
    let menuIcons = [#imageLiteral(resourceName: "home_slider_icon"), #imageLiteral(resourceName: "notification_slider_icon"), #imageLiteral(resourceName: "users_slider_icon"), #imageLiteral(resourceName: "phone_slider_icon"), #imageLiteral(resourceName: "chat_slider_icon")]
    
    override init() {
        super.init()
        tableView.register(MenuCell.self, forCellReuseIdentifier: cellId)
    }
    
    func show(fromVC : UIViewController) {
        setupSubViews()
    }
    
    func setupSubViews() {
        // adding the background view
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 1
            })
            // constraints
            backgroundView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            
            // adding the container view
            setupContainerView(window: window)
        }
    }
    
    func setupContainerView(window: UIWindow) {
        window.addSubview(containerView)
        let width = window.frame.width * 0.85
        containerView.frame = CGRect(x: -window.frame.width, y: 0, width: width, height: window.frame.height)
        
        setupLogoImageView()
        setupCopyrightLabels()
        setupTableView()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    func setupLogoImageView() {
        containerView.addSubview(logoImageView)
        let width = containerView.frame.width * 0.55
        
        logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: width / 1.43).isActive = true
    }
    

    func setupCopyrightLabels() {
        containerView.addSubview(copyrightLabel)
        copyrightLabel.text = "800HANDYMAN   |   2018"
        copyrightLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        copyrightLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30).isActive = true
        copyrightLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    func setupTableView() {
        containerView.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: copyrightLabel.topAnchor, constant: -20).isActive = true
        tableView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    @objc func hide() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.containerView.frame = CGRect(x: -window.frame.width, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
}

extension Menu: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MenuCell {
            //cell.icon = menuIcons[indexPath.row]
            if indexPath.row == 5 {
                if UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool == false {
                    cell.titleText = "Login"
                }else {
                    cell.titleText = menuItems[indexPath.row]
                }
            }
            else {
                cell.titleText = menuItems[indexPath.row]
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hide()
        homeController.setSelectedIndex(at: indexPath.row)
        notificationVC.setSelectedIndex(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.10
    }
    
}

