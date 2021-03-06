//
//  JobListViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 7/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift
class JobListViewController: UIViewController {
    
    var listOfJobs = [NSObject]()
    var scheduleTime : String?
    var serviceRequestMasterId = [Int]()
    var orderStatus : String?
    var selectedDateAndTime : String = "--:--"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Service Request List".localized()
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
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.jobListVC = self
        return slideMenu
    }()
    
    let jobListCellId = "JobListCell"
    
    var completedServiceListVC = CompletedServiceDetailsListViewController()
    var pendingServiceListVC   = PendingServiceDetailsListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        collectionView.register(JobListCell.self, forCellWithReuseIdentifier: jobListCellId)
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isLoggedIn()
        
        if !self.serviceRequestMasterId.isEmpty {
            self.serviceRequestMasterId.removeAll()
        }
        print("Member id is: \(UserDefaults.standard.value(forKey: MEMBER_ID) as! Int)")
        // get the job list
        self.getJobList()
        
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(fromVC: self)
    }
    
    func isLoggedIn() {
        if Helper.Exists(key: IS_LOGGED_IN){
            if UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool == false {
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
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
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func alert(title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setSelectedIndex(at index: Int) {
        if (index == 3) {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
        else if(index == 4) {
            // Modal for changing the Language view
            DispatchQueue.main.async {
                self.present(LanguageSelectViewController(), animated: true, completion: {
                    self.navigationController?.pushViewController(LoginViewController(), animated: false)
                })
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

extension JobListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfJobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: jobListCellId, for: indexPath) as? JobListCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        
        if let data = listOfJobs as? [JobNSObject] {
            
            cell.mainText = "\(data[indexPath.row].title)"
            cell.imageView.sd_setImage(with: URL(string: data[indexPath.row].parentIcon))
            cell.scheduleDate = "\(NSLocalizedString("Schedule date", comment: "Schedule date")): \(data[indexPath.row].scheduleTime)"
            cell.totalAmount = "\(NSLocalizedString("Total amount", comment: "Total amount")): \(data[indexPath.row].totalAmount)"
            cell.date = "\(data[indexPath.row].createdAt)"
            cell.pending = "\(data[indexPath.row].status)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let data = listOfJobs as? [JobNSObject] {
        
         UserDefaults.standard.set(data[indexPath.row].serviceRequestMasterId, forKey: SERVICE_REQUEST_MASTER_ID)
         self.getOrderStatusAndRedirect(serviceRequestMasterID: data[indexPath.row].serviceRequestMasterId)
        }
    }
    
}

extension JobListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = width * 0.3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

// API Functionalities
extension JobListViewController {
    
    private func getJobList() {
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/history?id=\(UserDefaults.standard.value(forKey: MEMBER_ID) as! Int)") else { return }
        let params = ["" : ""] as [String : Any]
        Alamofire.request(url,method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            if !self.listOfJobs.isEmpty {
                self.listOfJobs.removeAll()
            }
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let jobList = try decoder.decode(jobListResponse.self, from: json)
                    
                    for eachJob in jobList.data.jobs {
                        self.scheduleTime = "--:--:--"
                        let serviceRequestMasterId = eachJob.serviceRequestMasterId
                        
                        let status = eachJob.status
                        let createdAt = eachJob.createdAt
                        
                        if eachJob.timeslot != nil {
                            
                            if let scheduleTime = eachJob.timeslot?.date {
                                
                                self.scheduleTime = Helper.getDateAndTime(timeInterval: scheduleTime, dateFormat: "MMM dd YYYY")
                            }
                        }
                        for eachService in eachJob.services{
                            
                            let date = Helper.getDateAndTime(timeInterval: createdAt, dateFormat: "MMM dd YYYY")
                            
                            let container = JobNSObject(serviceRequestMasterId: serviceRequestMasterId, serviceId: eachService.serviceId, title: eachService.title, serviceDescription: eachService.description, totalAmount: eachService.serviceRate, createdAt: date, status: status, parentIcon: eachService.serviceParentIcon, scheduleTime: self.scheduleTime!)
                            
                            self.listOfJobs.append(container)
                        }
                        
                    }
                    
                    self.listOfJobs.reverse()
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                } catch let err {
                    print(err)
                }
            }
            // code after a successfull reponse
            //print(response)
            self.activityIndicator.stopAnimating()
        })
    }
    
    
    func getOrderStatusAndRedirect(serviceRequestMasterID : Int) {
        print("WTF: \(serviceRequestMasterID)")
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/info?id=\(serviceRequestMasterID)") else { return }
        let params = ["" : ""] as [String : Any]
        Alamofire.request(url,method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            // code after a successfull reponse
            print(response)
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(subService.self, from: json)
                    // find the order status
                    self.orderStatus = serviceList.data.serviceRequest.status.lowercased()
                    let date = Helper.getDateAndTime(timeInterval: serviceList.data.serviceRequest.timeslot.date, dateFormat: "dd-MM-YYYY")
                    let time = serviceList.data.serviceRequest.timeslot.time
                    self.selectedDateAndTime = "\(date) | \(time)"
                    
                    guard let orderStatus = self.orderStatus else { return }
                    
                    
                    if  orderStatus == "submitted" || orderStatus == "pending" {
                        self.pendingServiceListVC.selectedDateAndTime = self.selectedDateAndTime
                        self.pendingServiceListVC.serviceRequestMasterID = serviceRequestMasterID
                        sleep(2)
                        self.navigationController?.pushViewController(self.pendingServiceListVC, animated: true)
                        
                        /*self.completedServiceListVC.selectedDateAndTime = self.selectedDateAndTime
                        self.completedServiceListVC.serviceRequestMasterID = serviceRequestMasterID
                        self.navigationController?.pushViewController(self.completedServiceListVC, animated: true)*/
                    }
                    else if orderStatus == "completed" {
                        self.completedServiceListVC.selectedDateAndTime = self.selectedDateAndTime
                        self.completedServiceListVC.serviceRequestMasterID = serviceRequestMasterID
                        sleep(2)
                        self.navigationController?.pushViewController(self.completedServiceListVC, animated: true)
                    }
                    else if orderStatus == "canceled" {
                        self.alert(title: "Oops..", message: "Sorry, Canceled service request can not be opened")
                    }
                } catch let err {
                    print(err)
                }
            }
            self.activityIndicator.stopAnimating()
            
        })

    }
}
