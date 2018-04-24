//
//  JobListViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 7/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire

class JobListViewController: UIViewController {
    
    var listOfJobs = [NSObject]()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Service Request List", comment: "Service Request List")
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
    
    
    
    let jobListCellId = "JobListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        collectionView.register(JobListCell.self, forCellWithReuseIdentifier: jobListCellId)
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // get the job list
        self.getJobList()
        
    }
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsIconTapped))
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
            cell.scheduleDate = "\(NSLocalizedString("Schedule date", comment: "Schedule date")): \(data[indexPath.row].createdAt)"
            cell.totalAmount = "\(NSLocalizedString("Total amount", comment: "Total amount")): \(data[indexPath.row].totalAmount)"
            cell.date = "\(data[indexPath.row].createdAt)"
            cell.pending = "\(data[indexPath.row].status)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        navigationController?.pushViewController(ProfileViewController(), animated: true)
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
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let jobList = try decoder.decode(jobListResponse.self, from: json)
                    
                    for eachJob in jobList.data.jobs {
                        
                        let serviceRequestMasterId = eachJob.serviceRequestMasterId
                        let status = eachJob.status
                        let createdAt = eachJob.createdAt
                        
                        for eachService in eachJob.services{
                            
                            let container = JobNSObject(serviceRequestMasterId: serviceRequestMasterId, serviceId: eachService.serviceId, title: eachService.title, serviceDescription: eachService.description, totalAmount: eachService.serviceRate, createdAt: createdAt, status: status, parentIcon: eachService.serviceParentIcon)
                            
                            self.listOfJobs.append(container)
                        }
                        
                    }
                    
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
}
