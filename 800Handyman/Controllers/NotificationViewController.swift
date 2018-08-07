//
//  NotificationViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire

class NotificationViewController: UIViewController {
    
    var listOfNotifications = [NSObject]()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Notification", comment: "Notification")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.backgroundColor = UIColor.clear
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let notificationCellId = "NotificationCell"
    
    var notifications = [String]()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.notificationVC = self
        return slideMenu
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: notificationCellId)
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // API
        self.getNotifications()
    }
    private func setNavigationBar() {
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationController?.navigationBar.topItem?.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    @objc private func menuIconTapped() {
        self.menu.show()
    }
    
    private func layout() {
        setTitleLabel()
        setCollectionView()
        setupActivityIndicator()
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func alert(title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// API Calls
extension NotificationViewController {
    
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfNotifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationCellId, for: indexPath) as? NotificationCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        
        if let data = listOfNotifications as? [NotificationNSObject] {
            
            cell.mainText = "\(data[indexPath.row].title)"
            cell.date = "\(data[indexPath.row].date)"
            cell.time = "\(data[indexPath.row].time)"
            cell.notification = "\(data[indexPath.row].message)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(JobListViewController(), animated: true)
    }
    
}

extension NotificationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let contents = NSAttributedString(string: notifications[indexPath.item], attributes: [NSAttributedStringKey.font: UIFont(name: OPENSANS_REGULAR, size: 11) as Any])
        let cellRect = contents.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil)
        let height: CGFloat = cellRect.size.height + 48
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

// api calls
extension NotificationViewController {
    func getNotifications() {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/get/notifications?memberId=\(UserDefaults.standard.value(forKey: MEMBER_ID) as! Int)") else { return }
        let params = ["" : ""] as [String : Any]
        Alamofire.request(url,method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            self.activityIndicator.stopAnimating()
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let notificationList = try decoder.decode(NotificationModel.self, from: json)
                    
                    for eachNotification in notificationList.data.notifications {
                        
                        let container = NotificationNSObject(notificationId: eachNotification.notificationId, title: eachNotification.title, message: eachNotification.message, date: Helper.getDateAndTime(timeInterval: eachNotification.lastModified, dateFormat: "dd-MM-YYYY"), time: Helper.getDateAndTime(timeInterval: eachNotification.lastModified, dateFormat: "hh:mm a"))
                        self.notifications.append(eachNotification.title)
                        self.listOfNotifications.append(container)
                        self.collectionView.reloadData()
                    }
                } catch let err {
                    print(err)
                }
            }
        })
        
        if  listOfNotifications.count == 0 {
            self.alert(title: "No Notification Found", message: "")
        }
    }
}
