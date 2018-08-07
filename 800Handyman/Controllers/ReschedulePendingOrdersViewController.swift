//
//  ReschedulePendingOrdersViewController.swift
//  800Handyman
//
//  Created by Al Mobin on 3/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire

class ReschedulePendingOrdersViewController : UIViewController {
    
    var selectedDateAndTime : String = "--:--"
    
    var orderStatus : String?
    
    var listOfServices = [NSObject]()
    var selectedItem : Int?
    var serviceRequestMasterID : Int?
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Service Details", comment: "Service Details")
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
        return collection
    }()
    
    let locationTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Location", comment: "Location")
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let streetLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let apartmentLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationEditButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLocationEditButton), for: .touchUpInside)
        return button
    }()
    
    let dateAndTimeTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Date and Time", comment: "Date and Time")
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateAndTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTimeEditButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleDateTimeEditButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let paymentTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Your payment method", comment: "Your payment method")
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let masterCardLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        button.addTarget(self, action: #selector(paymentButtonTapped(sender:)), for: .touchUpInside)
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
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Different Credit Card", comment: "Different Credit Card")
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visaCardLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Card On Delivery", comment: "Card On Delivery")
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cashOnDeliveryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Cash On Delivery", comment: "Cash On Delivery")
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("You won't need to pay at this moment. Our technician will verify the spot and inform you the real cost ", comment: "You won't need to pay at this moment. Our technician will verify the spot and inform you the real cost")
        label.font = UIFont(name: OPENSANS_LIGHTITALIC, size : 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var payNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY NOW", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePayNow), for: .touchUpInside)
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
        showServiceDetailsListObj.reschedulePendingOrdersVC = self
        return showServiceDetailsListObj
    }()
    
    lazy var serviceListCell: ServiceDetailsListViewCell = {
        
        let serviceListObj = ServiceDetailsListViewCell()
        serviceListObj.reschedulePendingOrdersVC = self
        return serviceListObj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BACKGROUND_COLOR
        self.setNavigationBar()
        self.collectionView.register(ServiceDetailsListViewCell.self, forCellWithReuseIdentifier: cellID)
        
    
        // get services list
        self.getServicesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let serviceRequestMasterID = self.serviceRequestMasterID else { return }
        print("Master Service Request ID is: \(serviceRequestMasterID)")
        
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
        
        /*navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftArrowIcon")
         navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftArrowIcon")
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)*/
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
        
    }
    
    private func layout() {
        print("From Lyout \(self.listOfServices.count)")
        setupScrollView()
        setupTitleLabel()
        setupCollecetionView()
        setupLocationTitleLabel()
        //setupLocationEditButton()
        setupAreaNameLabel()
        setupAddressLabel()
        setupStreetLabel()
        setupApartmentLabel()
        setupDateAndTimeTitleLabel()
        //setupDateAndTimeEditButton()
        setupDateAndTimeLabel()
        setupPaymentMethodsLabel()
        /*setupMasterCardButton()
        setupMasterCardImageView()
        setupMasterCardTitleLabel()
        setupDifferentCardButton()
        setupDifferentCardImageView()
        setupDifferentCardTitleLabel()
        setupVisaCardButton()
        setupVisaCardImageView()
        setupVisaCardTitleLabel()*/
        setupCashOnDeliveryButton()
        setupCashOnDeliveryTitleLabel()
        //setupNoteLabel()
        setupPayNowButtonButton()
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
        let collectionViewHeight : CGFloat = CGFloat((self.listOfServices.count * 90) + (self.listOfServices.count * 8))
        scrollView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight).isActive = true
    }
    
    private func setupLocationTitleLabel() {
        scrollView.addSubview(locationTitleLabel)
        locationTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30).isActive = true
        locationTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupLocationEditButton() {
        scrollView.addSubview(locationEditButton)
        locationEditButton.centerYAnchor.constraint(equalTo: locationTitleLabel.centerYAnchor).isActive = true
        locationEditButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupAreaNameLabel() {
        scrollView.addSubview(areaNameLabel)
        areaNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        areaNameLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 8).isActive = true
        areaNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupAddressLabel() {
        scrollView.addSubview(addressLabel)
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        addressLabel.topAnchor.constraint(equalTo: areaNameLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupStreetLabel() {
        scrollView.addSubview(streetLabel)
        streetLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        streetLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
        streetLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupApartmentLabel() {
        scrollView.addSubview(apartmentLabel)
        apartmentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        apartmentLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 5).isActive = true
        apartmentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupDateAndTimeTitleLabel() {
        scrollView.addSubview(dateAndTimeTitleLabel)
        dateAndTimeTitleLabel.topAnchor.constraint(equalTo: apartmentLabel.bottomAnchor, constant: 16).isActive = true
        dateAndTimeTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupDateAndTimeEditButton() {
        scrollView.addSubview(dateTimeEditButton)
        dateTimeEditButton.centerYAnchor.constraint(equalTo: dateAndTimeTitleLabel.centerYAnchor).isActive = true
        dateTimeEditButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupDateAndTimeLabel() {
        scrollView.addSubview(dateAndTimeLabel)
        dateAndTimeLabel.topAnchor.constraint(equalTo: dateAndTimeTitleLabel.bottomAnchor, constant: 8).isActive = true
        dateAndTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupPaymentMethodsLabel() {
        scrollView.addSubview(paymentTitleLabel)
        paymentTitleLabel.topAnchor.constraint(equalTo: dateAndTimeLabel.bottomAnchor, constant: 16).isActive = true
        paymentTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupMasterCardButton() {
        scrollView.addSubview(masterCardRadioButton)
        masterCardRadioButton.topAnchor.constraint(equalTo: paymentTitleLabel.bottomAnchor, constant: 16).isActive = true
        masterCardRadioButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
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
        differentCardRadioButton.topAnchor.constraint(equalTo: masterCardRadioButton.bottomAnchor, constant: 8).isActive = true
        differentCardRadioButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        differentCardRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        differentCardRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupDifferentCardImageView() {
        scrollView.addSubview(differentCreditCardImageView)
        differentCreditCardImageView.centerYAnchor.constraint(equalTo: differentCardRadioButton.centerYAnchor).isActive = true
        differentCreditCardImageView.leftAnchor.constraint(equalTo: differentCardRadioButton.rightAnchor, constant: 5).isActive = true
        differentCreditCardImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        differentCreditCardImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupDifferentCardTitleLabel() {
        scrollView.addSubview(differentCreditCardLabel)
        differentCreditCardLabel.centerYAnchor.constraint(equalTo: differentCardRadioButton.centerYAnchor).isActive = true
        differentCreditCardLabel.leftAnchor.constraint(equalTo: differentCreditCardImageView.rightAnchor, constant: 5).isActive = true
    }
    
    private func setupVisaCardButton() {
        scrollView.addSubview(visaCardRadioButton)
        visaCardRadioButton.topAnchor.constraint(equalTo: differentCardRadioButton.bottomAnchor, constant: 8).isActive = true
        visaCardRadioButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
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
        cashOnDelivertRadioButton.topAnchor.constraint(equalTo: paymentTitleLabel.bottomAnchor, constant: 16).isActive = true
        cashOnDelivertRadioButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        cashOnDelivertRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cashOnDelivertRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupCashOnDeliveryTitleLabel() {
        scrollView.addSubview(cashOnDeliveryLabel)
        cashOnDeliveryLabel.centerYAnchor.constraint(equalTo: cashOnDelivertRadioButton.centerYAnchor).isActive = true
        cashOnDeliveryLabel.leftAnchor.constraint(equalTo: cashOnDelivertRadioButton.rightAnchor, constant: 5).isActive = true
    }
    
    private func setupNoteLabel() {
        scrollView.addSubview(noteLabel)
        noteLabel.topAnchor.constraint(equalTo: cashOnDelivertRadioButton.bottomAnchor, constant: 32).isActive = true
        noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noteLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        noteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setupPayNowButtonButton() {
        scrollView.addSubview(payNowButton)
        payNowButton.topAnchor.constraint(equalTo: cashOnDelivertRadioButton.bottomAnchor, constant: 32).isActive = true
        payNowButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        payNowButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        payNowButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        }
        else{
            self.cashOnDelivertRadioButton.setTitleColor(UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0), for: .normal)
        }
    }
    
    var thankYouOBJ = ThankYouViewController()
    @objc private func handlePayNow() {
        
        UserDefaults.standard.set(true, forKey: SHOW_THANK_YOU_MESSAGE)
        
        if (UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool) {
            thankYouOBJ.serviceRequestMasterID = UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as? Int
            self.navigationController?.pushViewController(thankYouOBJ, animated: true)
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
}

extension ReschedulePendingOrdersViewController : UIScrollViewDelegate {
    
}

extension ReschedulePendingOrdersViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension ReschedulePendingOrdersViewController: UICollectionViewDelegateFlowLayout {
    
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
extension ReschedulePendingOrdersViewController {
    
    private func getServicesList() {
        self.activityIndicator.startAnimating()
        guard let serviceRequestMasterID = self.serviceRequestMasterID else { return }
        
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
                    
                    // find the order status
                    self.orderStatus = serviceList.data.serviceRequest.status
                    
                    self.areaNameLabel.text = "Area Name: \(serviceList.data.serviceRequest.location.areaName)"
                    self.addressLabel.text = "Address Name: \(serviceList.data.serviceRequest.location.addressName)"
                    self.streetLabel.text = "Street Name: \(serviceList.data.serviceRequest.location.street)"
                    self.apartmentLabel.text = "Apartment No.: \(serviceList.data.serviceRequest.location.apartmentNo)"
                    self.dateAndTimeLabel.text = self.selectedDateAndTime
                } catch let err {
                    print(err)
                }
            }
            
            self.layout()
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.view.layoutIfNeeded()
            self.activityIndicator.stopAnimating()
            
            print("From API: \(self.listOfServices.count)")
        })
    }
}
