
//
//  ShowServiceDetailsView.swift
//  800Handyman
//
//  Created by Creativeitem on 17/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ShowServiceDetailsView : UIViewController {
    
    var serviceDetailsObj = [NSObject]()
    var imageArray = [String]()
    var serviceRequestDetailsID : Int?
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        view.alpha = 0
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var serviceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subServiceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var optionalNote: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceTagIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "priceIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    lazy var expandButton: UIButton = {
        let button = UIButton(type: .system)
        //button.setImage(#imageLiteral(resourceName: "down_arrow"), for: .normal)
        //button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        return button
    }()
    
    lazy var editLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Edit"
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleEditButton))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = false
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
    
    var serviceDetailsListVC = ServiceDetailsListViewController()
    var completedServiceDetailsListVC = CompletedServiceDetailsListViewController()
    var pendingServiceDetailsListVC = PendingServiceDetailsListViewController()
    var reschedulePendingOrdersVC = ReschedulePendingOrdersViewController()
    var customerJobDoneVC = CustomerJobDone()
    
    let jobDetailsImageCellId = "JobDetailsImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(JobDetailsImageCell.self, forCellWithReuseIdentifier: jobDetailsImageCellId)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 140)
    }
    
    func clearCachedImages(){
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
    }
    
    func show(serviceID : Int) {
        
        getDetailsOfSelectedSubService(subServiceID: serviceID)
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
        let height = window.frame.height * 0.8
        let y = window.frame.height - height
        containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        self.setServiceUIImageView()
        self.setServiceTitleLabel()
        self.setExpandButton()
        //self.setEditLabel()
        self.setSubServiceTitleLabel()
        self.setPriceIconImageView()
        self.setPriceLabel()
        self.setOptionalNote()
        self.setCollectionView()
        self.setupActivityIndicator()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    private func  setUpScrollView() {
        containerView.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    private func setServiceUIImageView() {
        containerView.addSubview(serviceImageView)
        serviceImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        serviceImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private func setServiceTitleLabel() {
        containerView.addSubview(serviceTitleLabel)
        serviceTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        serviceTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    
    private func setExpandButton() {
        containerView.addSubview(expandButton)
        expandButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        expandButton.centerYAnchor.constraint(equalTo: serviceImageView.centerYAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setEditLabel() {
        containerView.addSubview(editLabel)
        editLabel.topAnchor.constraint(equalTo: expandButton.bottomAnchor).isActive = true
        editLabel.centerXAnchor.constraint(equalTo: expandButton.centerXAnchor).isActive = true
    }
    
    private func setSubServiceTitleLabel() {
        containerView.addSubview(subServiceTitleLabel)
        subServiceTitleLabel.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 5).isActive = true
        subServiceTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        subServiceTitleLabel.rightAnchor.constraint(equalTo: expandButton.leftAnchor, constant: -5).isActive = true
    }
    
    
    private func setPriceIconImageView() {
        containerView.addSubview(priceTagIconView)
        priceTagIconView.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        priceTagIconView.topAnchor.constraint(equalTo: subServiceTitleLabel.bottomAnchor, constant: 5).isActive = true
        priceTagIconView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        priceTagIconView.widthAnchor.constraint(equalToConstant: 12).isActive = true
    }
    private func setPriceLabel() {
        containerView.addSubview(priceTitleLabel)
        priceTitleLabel.centerYAnchor.constraint(equalTo: priceTagIconView.centerYAnchor).isActive = true
        priceTitleLabel.leftAnchor.constraint(equalTo: priceTagIconView.rightAnchor, constant: 5).isActive = true
        priceTitleLabel.rightAnchor.constraint(equalTo: expandButton.leftAnchor, constant: -5).isActive = true
    }
    
    private func setOptionalNote() {
        containerView.addSubview(optionalNote)
        optionalNote.topAnchor.constraint(equalTo: serviceImageView.bottomAnchor, constant: 16).isActive = true
        optionalNote.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        optionalNote.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
    }
    
    private func setCollectionView(){
        let rows: CGFloat = (CGFloat(self.imageArray.count)/3).rounded(.up)
        _ = (view.frame.width / 3) * (rows) - 32
        
        containerView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.optionalNote.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16).isActive = true
    }
    
    private func setupActivityIndicator(){
        containerView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    @objc private func hide() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
    @objc func handleEditButton() {
        hide()
        guard let serviceRequestDetailsID = self.serviceRequestDetailsID else { return }
        self.serviceDetailsListVC.editServiceDetails(serviceRequestDetailsID: serviceRequestDetailsID)
        self.pendingServiceDetailsListVC.editServiceDetails(serviceRequestDetailsID: serviceRequestDetailsID)
        self.reschedulePendingOrdersVC.editServiceDetails(serviceRequestDetailsID: serviceRequestDetailsID)
        self.completedServiceDetailsListVC.editServiceDetails(serviceRequestDetailsID: serviceRequestDetailsID)
        self.customerJobDoneVC.editServiceDetails(serviceRequestDetailsID: serviceRequestDetailsID)
    }
}

extension ShowServiceDetailsView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: jobDetailsImageCellId, for: indexPath) as? JobDetailsImageCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        
        cell.imageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "image_placeholder"), options: [.continueInBackground, .progressiveDownload, .lowPriority, .scaleDownLargeImages], completed: nil)
     
        return cell
    }
}

extension ShowServiceDetailsView : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 3 - 4
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}


extension ShowServiceDetailsView : UIScrollViewDelegate {
    
}
// API Functions
extension ShowServiceDetailsView {
    
    private func getDetailsOfSelectedSubService(subServiceID : Int) {
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/info?id=\(UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int)") else { return }
        //guard let url = URL(string: "\(API_URL)api/v1/member/service/request/info?id=10308") else { return }
        let params = ["" : ""] as [String : Any]
        Alamofire.request(url,method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            if !self.serviceDetailsObj.isEmpty {
                
                self.serviceDetailsObj.removeAll()
            }
            // code after a successfull reponse
            self.activityIndicator.stopAnimating()
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(subService.self, from: json)
                    
                    for eachService in serviceList.data.serviceRequest.services {
                        if eachService.serviceRequestDetailId == subServiceID {
                            
                            print("Sub Services id is: \(subServiceID), and the serviceDetailsID is: \(eachService.serviceRequestDetailId)")
                            let container = GetServicesListObject(serviceRequestDetailId: eachService.serviceRequestDetailId, serviceParentIcon: eachService.serviceParentIcon, serviceParentTitle: eachService.serviceParentTitle, serviceTitle: eachService.serviceTitle, serviceRate: eachService.serviceRate, thumbnails: eachService.thumbnails)
                            
                            self.serviceRequestDetailsID = eachService.serviceRequestDetailId
                            self.serviceTitleLabel.text = eachService.serviceParentTitle
                            self.subServiceTitleLabel.text = eachService.description
                            self.priceTitleLabel.text = eachService.serviceRate
                            self.optionalNote.text = eachService.note
                            self.serviceImageView.sd_setImage(with: URL(string: eachService.serviceParentIcon))
                            self.serviceDetailsObj.append(container)
                            self.imageArray = eachService.thumbnails
                            
                            self.collectionView.reloadData()
                            self.collectionView.collectionViewLayout.invalidateLayout()
                        }
                    }
                    self.activityIndicator.stopAnimating()
                } catch let err {
                    print(err)
                }
            }
        })
        
    }
}
