//
//  ServiceDetailsListViewController.swift
//  800Handyman
//
//  Created by Creativeitem on 9/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift

class ServiceDetailsListViewController : UIViewController {
    
    var selectedDateAndTime : String = "--:--"
    
    var listOfServices = [NSObject]()
    var selectedItem : Int?
    
    let gifArrow : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.loadGif(name: "scroll-down")
        imageView.alpha = 0
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Service Details".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size : 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
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
        collection.showsVerticalScrollIndicator = true
        return collection
    }()
    
    let locationTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Location".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let streetLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let apartmentLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let locationEditButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit".localized(), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleLocationEditButton), for: .touchUpInside)
        button.titleLabel?.textAlignment = .natural
        return button
    }()
    
    let dateAndTimeTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Date and Time".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateAndTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTimeEditButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit".localized(), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleDateTimeEditButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .natural
        return button
    }()
    
    let paymentTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Your payment method".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let masterCardLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = NSLocalizedString("xxx-6039", comment: "xxx-6039")
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let masterCardRadioButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("◉", comment: "Edit"), for: .normal)
        button.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.addTarget(self, action: #selector(paymentButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    let differentCardRadioButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("◉", comment: "Edit"), for: .normal)
        button.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        //button.addTarget(self, action: #selector(paymentButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    let visaCardRadioButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("◉", comment: "Edit"), for: .normal)
        button.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 3
        button.addTarget(self, action: #selector(paymentButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    let cashOnDelivertRadioButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("◉", comment: "Edit"), for: .normal)
        //button.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        button.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 4
        button.addTarget(self, action: #selector(paymentButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    let masterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "master-card")
        return imageView
    }()
    
    let differentCreditCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "credit-card")
        return imageView
    }()
    
    let visaCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "visa-card")
        return imageView
    }()
    
    let differentCreditCardLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Card".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visaCardLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Card On Delivery".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cashOnDeliveryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Cash On Delivery".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "You won't need to pay at this moment. Our technician will verify the spot and inform you the real cost ".localized()
        label.font = UIFont(name: OPENSANS_LIGHTITALIC, size : 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var requestServiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("REQUEST SERVICE".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRequestService), for: .touchUpInside)
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
    
    let cellID = "ServiceDetailsListViewCell"
    
    lazy var showServiceDetailsList: ShowServiceDetailsView = {
        
        let showServiceDetailsListObj = ShowServiceDetailsView()
        showServiceDetailsListObj.serviceDetailsListVC = self
        return showServiceDetailsListObj
    }()
    
    lazy var serviceListCell: ServiceDetailsListViewCell = {
        
        let serviceListObj = ServiceDetailsListViewCell()
        serviceListObj.serviceListVC = self
        return serviceListObj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BACKGROUND_COLOR
        self.setNavigationBar()
        self.collectionView.register(ServiceDetailsListViewCell.self, forCellWithReuseIdentifier: cellID)
        print("Master Service Request ID is: \(UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int)")
        
        self.layout()
        // get services list
        self.getServicesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // get services list
        self.getServicesList()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
        
    }
    
    private func layout() {
        setupScrollView()
        setupTitleLabel()
        setupCollecetionView()
        setBottomIndicatorArrow()
        setupLocationTitleLabel()
        setupLocationEditButton()
        setupAreaNameLabel()
        setupAddressLabel()
        setupStreetLabel()
        setupApartmentLabel()
        setupDateAndTimeTitleLabel()
        setupDateAndTimeEditButton()
        setupDateAndTimeLabel()
        setupPaymentMethodsLabel()
        /*setupMasterCardButton()
         setupMasterCardImageView()
         setupMasterCardTitleLabel()*/
        setupDifferentCardButton()
        setupDifferentCardImageView()
        setupDifferentCardTitleLabel()
        /*setupVisaCardButton()
         setupVisaCardImageView()
         setupVisaCardTitleLabel()*/
        setupCashOnDeliveryButton()
        setupCashOnDeliveryTitleLabel()
        setupNoteLabel()
        setupRequestServiceButton()
        setupActivityIndicator()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    private func setupCollecetionView() {
        let _ : CGFloat = CGFloat((self.listOfServices.count * 90) + (self.listOfServices.count * 8))
        scrollView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 195).isActive = true
    }
    
    private func setBottomIndicatorArrow() {
        scrollView.addSubview(gifArrow)
        gifArrow.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -10).isActive = true
        gifArrow.leadingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -20).isActive = true
        gifArrow.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gifArrow.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupLocationTitleLabel() {
        scrollView.addSubview(locationTitleLabel)
        locationTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30).isActive = true
        locationTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        locationTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
    }
    
    private func setupLocationEditButton() {
        scrollView.addSubview(locationEditButton)
        locationEditButton.centerYAnchor.constraint(equalTo: locationTitleLabel.centerYAnchor).isActive = true
        locationEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        locationEditButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupAreaNameLabel() {
        scrollView.addSubview(areaNameLabel)
        areaNameLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 8).isActive = true
        areaNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        areaNameLabel.trailingAnchor.constraint(equalTo: locationEditButton.leadingAnchor, constant: -5).isActive = true
    }
    
    private func setupAddressLabel() {
        scrollView.addSubview(addressLabel)
        addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        addressLabel.topAnchor.constraint(equalTo: areaNameLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: locationEditButton.leadingAnchor, constant: -5).isActive = true
    }
    
    private func setupStreetLabel() {
        scrollView.addSubview(streetLabel)
        streetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        streetLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
        streetLabel.trailingAnchor.constraint(equalTo: locationEditButton.leadingAnchor, constant: -5).isActive = true
    }
    
    private func setupApartmentLabel() {
        scrollView.addSubview(apartmentLabel)
        apartmentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        apartmentLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 5).isActive = true
        apartmentLabel.trailingAnchor.constraint(equalTo: locationEditButton.leadingAnchor, constant: -5).isActive = true
    }
    
    private func setupDateAndTimeTitleLabel() {
        scrollView.addSubview(dateAndTimeTitleLabel)
        dateAndTimeTitleLabel.topAnchor.constraint(equalTo: apartmentLabel.bottomAnchor, constant: 16).isActive = true
        dateAndTimeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dateAndTimeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupDateAndTimeEditButton() {
        scrollView.addSubview(dateTimeEditButton)
        dateTimeEditButton.centerYAnchor.constraint(equalTo: dateAndTimeTitleLabel.centerYAnchor).isActive = true
        dateTimeEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        dateTimeEditButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupDateAndTimeLabel() {
        scrollView.addSubview(dateAndTimeLabel)
        dateAndTimeLabel.topAnchor.constraint(equalTo: dateAndTimeTitleLabel.bottomAnchor, constant: 8).isActive = true
        dateAndTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dateAndTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupPaymentMethodsLabel() {
        scrollView.addSubview(paymentTitleLabel)
        paymentTitleLabel.topAnchor.constraint(equalTo: dateAndTimeLabel.bottomAnchor, constant: 16).isActive = true
        paymentTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        paymentTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupMasterCardButton() {
        scrollView.addSubview(masterCardRadioButton)
        masterCardRadioButton.topAnchor.constraint(equalTo: paymentTitleLabel.bottomAnchor, constant: 16).isActive = true
        masterCardRadioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        masterCardRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        masterCardRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupMasterCardImageView() {
        scrollView.addSubview(masterImageView)
        masterImageView.centerYAnchor.constraint(equalTo: masterCardRadioButton.centerYAnchor).isActive = true
        masterImageView.leftAnchor.constraint(equalTo: masterCardRadioButton.rightAnchor, constant: 5).isActive = true
        masterImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        masterImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupMasterCardTitleLabel() {
        scrollView.addSubview(masterCardLabel)
        masterCardLabel.centerYAnchor.constraint(equalTo: masterCardRadioButton.centerYAnchor).isActive = true
        masterCardLabel.leftAnchor.constraint(equalTo: masterImageView.rightAnchor, constant: 5).isActive = true
    }
    
    private func setupDifferentCardButton() {
        scrollView.addSubview(differentCardRadioButton)
        differentCardRadioButton.topAnchor.constraint(equalTo: paymentTitleLabel.bottomAnchor, constant: 16).isActive = true
        differentCardRadioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        differentCardRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        differentCardRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupDifferentCardImageView() {
        scrollView.addSubview(differentCreditCardImageView)
        differentCreditCardImageView.centerYAnchor.constraint(equalTo: differentCardRadioButton.centerYAnchor).isActive = true
        differentCreditCardImageView.leadingAnchor.constraint(equalTo: differentCardRadioButton.trailingAnchor, constant: 5).isActive = true
        differentCreditCardImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        differentCreditCardImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupDifferentCardTitleLabel() {
        scrollView.addSubview(differentCreditCardLabel)
        differentCreditCardLabel.centerYAnchor.constraint(equalTo: differentCardRadioButton.centerYAnchor).isActive = true
        differentCreditCardLabel.leadingAnchor.constraint(equalTo: differentCreditCardImageView.trailingAnchor, constant: 5).isActive = true
        differentCreditCardLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupVisaCardButton() {
        scrollView.addSubview(visaCardRadioButton)
        visaCardRadioButton.topAnchor.constraint(equalTo: differentCardRadioButton.bottomAnchor, constant: 8).isActive = true
        visaCardRadioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        visaCardRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        visaCardRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupVisaCardImageView() {
        scrollView.addSubview(visaCardImageView)
        visaCardImageView.centerYAnchor.constraint(equalTo: visaCardRadioButton.centerYAnchor).isActive = true
        visaCardImageView.leftAnchor.constraint(equalTo: visaCardRadioButton.rightAnchor, constant: 5).isActive = true
        visaCardImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        visaCardImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupVisaCardTitleLabel() {
        scrollView.addSubview(visaCardLabel)
        visaCardLabel.centerYAnchor.constraint(equalTo: visaCardRadioButton.centerYAnchor).isActive = true
        visaCardLabel.leftAnchor.constraint(equalTo: visaCardImageView.rightAnchor, constant: 5).isActive = true
    }
    
    private func setupCashOnDeliveryButton() {
        scrollView.addSubview(cashOnDelivertRadioButton)
        cashOnDelivertRadioButton.topAnchor.constraint(equalTo: differentCardRadioButton.bottomAnchor, constant: 8).isActive = true
        cashOnDelivertRadioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cashOnDelivertRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cashOnDelivertRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupCashOnDeliveryTitleLabel() {
        scrollView.addSubview(cashOnDeliveryLabel)
        cashOnDeliveryLabel.centerYAnchor.constraint(equalTo: cashOnDelivertRadioButton.centerYAnchor).isActive = true
        cashOnDeliveryLabel.leadingAnchor.constraint(equalTo: cashOnDelivertRadioButton.trailingAnchor, constant: 5).isActive = true
        cashOnDeliveryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupNoteLabel() {
        scrollView.addSubview(noteLabel)
        noteLabel.topAnchor.constraint(equalTo: cashOnDelivertRadioButton.bottomAnchor, constant: 32).isActive = true
        noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupRequestServiceButton() {
        scrollView.addSubview(requestServiceButton)
        requestServiceButton.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 32).isActive = true
        requestServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        requestServiceButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        requestServiceButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    @objc private func paymentButtonTapped(sender: UIButton) {
        self.masterCardRadioButton.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        self.differentCardRadioButton.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        self.visaCardRadioButton.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        self.cashOnDelivertRadioButton.setTitleColor(UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0), for: .normal)
        
        if sender.tag == 1 { // master card
            self.masterCardRadioButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
        }
        else if sender.tag == 2 {
            self.differentCardRadioButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
        }
        else if sender.tag == 3 {
            self.visaCardRadioButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
        }
        else if sender.tag == 4 {
            self.cashOnDelivertRadioButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
        }else{
            self.cashOnDelivertRadioButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
        }
    }
    
    let thankYouOBJ = ThankYouViewController()
    @objc private func handleRequestService() {
        UserDefaults.standard.set(true, forKey: SHOW_THANK_YOU_MESSAGE)
        
        if Helper.Exists(key: IS_LOGGED_IN){
            if (UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool) {
                thankYouOBJ.serviceRequestMasterID = UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as? Int
                self.navigationController?.pushViewController(thankYouOBJ, animated: true)
            }
            else {
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
        else {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDateTimeEditButton() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is SelectDateTimeViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    let editLocationFirstVC = EditLocationFirstViewController()
    
    @objc func handleLocationEditButton() {
        
        print("Pre edit controller \(self.selectedDateAndTime)")
        editLocationFirstVC.selectedDateAndTime = self.selectedDateAndTime
        self.navigationController?.pushViewController(editLocationFirstVC, animated: true)
    }
    
    var editServiceRequestDetailsOBJ = EditServiceDetailsViewController()
    func editServiceDetails(serviceRequestDetailsID : Int) {
        editServiceRequestDetailsOBJ.serviceRequestDetailsID = serviceRequestDetailsID
        self.navigationController?.pushViewController(editServiceRequestDetailsOBJ, animated: true)
    }
    
    @objc func handleRemoveButton(_ sender : UIButton) {
        let refreshAlert = UIAlertController(title: "Are You Sure?".localized(), message: "It will remove the Service Request Detail.".localized(), preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes".localized(), style: .destructive, handler: { (action: UIAlertAction!) in
            self.removeServiceRequestDetails(serviceRequestDetailId: sender.tag)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel".localized(), style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}

extension ServiceDetailsListViewController : UIScrollViewDelegate {
    
}

extension ServiceDetailsListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ServiceDetailsListViewCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        if let selectedItem = self.selectedItem {
            if selectedItem == indexPath.item {
                cell.layer.borderColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0).cgColor
                cell.serviceImageView.layer.borderColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0).cgColor
            }
            else {
                cell.layer.borderColor = UIColor.gray.cgColor
                cell.serviceImageView.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        
        if let data = listOfServices as? [GetServicesListObject] {
            cell.service = "\(data[indexPath.row].serviceParentTitle)"
            cell.subService = "\(data[indexPath.row].serviceTitle)"
            cell.price = "\(data[indexPath.row].serviceRate)"
            cell.serviceImageView.sd_setImage(with: URL(string: data[indexPath.row].serviceParentIcon))
            
            cell.expandButton.tag = data[indexPath.row].serviceRequestDetailId
            cell.expandButton.addTarget(self, action: #selector(handleExpandButton(_:)), for: .touchUpInside)
            cell.removeButton.tag =  data[indexPath.row].serviceRequestDetailId
            cell.removeButton.addTarget(self, action: #selector(handleRemoveButton(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        self.selectedItem = indexPath.item
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    
    @objc func handleExpandButton(_ sender : UIButton) {
        showServiceDetailsList.show(serviceID : sender.tag)
    }
}

extension ServiceDetailsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 90
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

// API Functions
extension ServiceDetailsListViewController {
    
    private func getServicesList() {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/info?id=\(UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int)") else { return }
        //guard let url = URL(string: "\(API_URL)api/v1/member/service/request/info?id=20456") else { return }
        let params = ["" : ""] as [String : Any]
        Alamofire.request(url,method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            // code after a successfull reponse
            self.activityIndicator.stopAnimating()
            
            if !self.listOfServices.isEmpty {
                
                self.listOfServices.removeAll()
            }
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(subService.self, from: json)
                    
                    for eachService in serviceList.data.serviceRequest.services {
                        
                        let container = GetServicesListObject(serviceRequestDetailId: eachService.serviceRequestDetailId, serviceParentIcon: eachService.serviceParentIcon, serviceParentTitle: eachService.serviceParentTitle, serviceTitle: eachService.serviceTitle, serviceRate: eachService.serviceRate, thumbnails: eachService.thumbnails)
                        
                        self.listOfServices.append(container)
                    }
                    self.areaNameLabel.text = "Area Name:".localized() + "\(serviceList.data.serviceRequest.location.areaName)"
                    self.addressLabel.text = "Address Name:".localized() + "\(serviceList.data.serviceRequest.location.addressName)"
                    self.streetLabel.text = "Street Name:".localized() + "\(serviceList.data.serviceRequest.location.street)"
                    self.apartmentLabel.text = "Apartment No.:".localized() + "\(serviceList.data.serviceRequest.location.apartmentNo)"
                    self.dateAndTimeLabel.text = self.selectedDateAndTime
                    print(serviceList.data.serviceRequest.location.areaName)
                    print(serviceList.data.serviceRequest.location.addressName)
                    print(serviceList.data.serviceRequest.location.street)
                    print(serviceList.data.serviceRequest.location.apartmentNo)
                } catch let err {
                    print(err)
                }
            }
            
            if  self.listOfServices.count > 2 {
                self.gifArrow.alpha = 1
            }
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.view.layoutIfNeeded()
            self.activityIndicator.stopAnimating()
            
            print("From API: \(self.listOfServices.count)")
        })
    }
    
    func removeServiceRequestDetails(serviceRequestDetailId : Int) {
        self.activityIndicator.startAnimating()
        print(UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int)
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/details/remove") else { return }
        let params = ["ServiceRequestDetailId" : serviceRequestDetailId] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                
                self.activityIndicator.stopAnimating()
                return
            }
            self.getServicesList()
            self.activityIndicator.stopAnimating()
        })
    }
}

