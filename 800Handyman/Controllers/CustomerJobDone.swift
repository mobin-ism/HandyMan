//
//  CustomerJobDone.swift
//  800Handyman
//
//  Created by Creativeitem on 8/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Alamofire
import HCSStarRatingView
import Localize_Swift

class CustomerJobDone : UIViewController {
    
    var selectedDateAndTime : String = "--:--"
    var tips = 0
    var orderStatus : String?
    
    var listOfServices = [NSObject]()
    var selectedItem : Int?
    var serviceRequestMasterID : Int?
    let tipsArray = [5, 10, 15, 20, 25, 30, 35, 40]
    
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
        return collection
    }()
    
    lazy var horizontalCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.alwaysBounceHorizontal = true
        collection.showsHorizontalScrollIndicator = false
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
        label.text = "Address".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let streetLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let apartmentLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationEditButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit".localized(), for: .normal)
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
        label.text = "Date and Time".localized()
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
    
    let jobIDTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Job ID".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobIDLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskCompletedTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Task Completed".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskCompletedLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var horizontalLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5)
        return view
    }()
    
    let rateOurServiceTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Rate Our Service".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerView : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var starRatingView : HCSStarRatingView = {
        var view = HCSStarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.maximumValue = 5
        view.minimumValue = 1
        view.value = 1
        view.tintColor = YELLOW_ACCENT
        view.allowsHalfStars = true
        view.isUserInteractionEnabled = true
        view.isEnabled = true
        view.alpha = 1
        view.backgroundColor = .clear
        return view
    }()
    
    let noteTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Note".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteTextView : UITextView = {
       var textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.clipsToBounds = true
        textview.backgroundColor = UIColor.white
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor.white.cgColor
        textview.layer.cornerRadius = 4
        textview.isEditable = true
        return textview
    }()
    
    let tipsLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Do You Like To Pay Tips".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size : 17)
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
        return button
    }()
    
    lazy var payNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RATE NOW".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePayNow), for: .touchUpInside)
        return button
    }()
    
    
    let paymentTitleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Your payment method".localized()
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
        label.text = "Different Credit Card".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visaCardLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Card On Delivery".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cashOnDeliveryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Cash On Delivery".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size : 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "You won't need to pay at this moment. Our technician will verify the spot and inform you the real cost ".localized()
        label.font = UIFont(name: OPENSANS_LIGHTITALIC, size : 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
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
    let horizontalCellID = "HorizontalCell"
    lazy var showServiceDetailsList: ShowServiceDetailsView = {
        
        let showServiceDetailsListObj = ShowServiceDetailsView()
        showServiceDetailsListObj.customerJobDoneVC = self
        return showServiceDetailsListObj
    }()
    
    lazy var serviceListCell: ServiceDetailsListViewCell = {
        
        let serviceListObj = ServiceDetailsListViewCell()
        serviceListObj.customerJobDoneVC = self
        return serviceListObj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BACKGROUND_COLOR
        self.setNavigationBar()
        self.collectionView.register(ServiceDetailsListViewCell.self, forCellWithReuseIdentifier: cellID)
        horizontalCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: horizontalCellID)
        
        // get services list
        self.getServicesList()
        self.noteTextView.delegate = self
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
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 340)
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
        setupAreaNameLabel()
        setupDateAndTimeTitleLabel()
        setupDateAndTimeLabel()
        setupJobIDTitleLabel()
        setupJobIDLabel()
        setupTaskCompletedTitleLabel()
        setupTaskCompletedLabel()
        setupHorizontalLine()
        setupRateUsTitleLabel()
        setupContainerView()
        setupStarReviewView()
        setupNoteLabel()
        setupNoteTextView()
        setupTipsLabel()
        setupHorizontalCollectionView()
        setupPayNowButtonButton()
        setupActivityIndicator()
        
        view.layoutIfNeeded()
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
        locationTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
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
    }
    
    private func setupDateAndTimeTitleLabel() {
        scrollView.addSubview(dateAndTimeTitleLabel)
        dateAndTimeTitleLabel.topAnchor.constraint(equalTo: areaNameLabel.bottomAnchor, constant: 16).isActive = true
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
    
    private func setupJobIDTitleLabel() {
        scrollView.addSubview(jobIDTitleLabel)
        jobIDTitleLabel.topAnchor.constraint(equalTo: dateAndTimeLabel.bottomAnchor, constant: 16).isActive = true
        jobIDTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupJobIDLabel() {
        scrollView.addSubview(jobIDLabel)
        jobIDLabel.topAnchor.constraint(equalTo: jobIDTitleLabel.bottomAnchor, constant: 8).isActive = true
        jobIDLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupTaskCompletedTitleLabel() {
        scrollView.addSubview(taskCompletedTitleLabel)
        taskCompletedTitleLabel.topAnchor.constraint(equalTo: jobIDLabel.bottomAnchor, constant: 16).isActive = true
        taskCompletedTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupTaskCompletedLabel() {
        scrollView.addSubview(taskCompletedLabel)
        taskCompletedLabel.topAnchor.constraint(equalTo: taskCompletedTitleLabel.bottomAnchor, constant: 8).isActive = true
        taskCompletedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupHorizontalLine() {
        scrollView.addSubview(horizontalLine)
        horizontalLine.topAnchor.constraint(equalTo: taskCompletedLabel.bottomAnchor, constant: 16).isActive = true
        horizontalLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        horizontalLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        horizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setupRateUsTitleLabel() {
        scrollView.addSubview(rateOurServiceTitleLabel)
        rateOurServiceTitleLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 16).isActive = true
        rateOurServiceTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupContainerView() {
        scrollView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: rateOurServiceTitleLabel.bottomAnchor, constant: 16).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupStarReviewView(){
        containerView.addSubview(starRatingView)
        starRatingView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        starRatingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        starRatingView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        starRatingView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
    }
    
    private func setupNoteLabel() {
        scrollView.addSubview(noteTitleLabel)
        noteTitleLabel.topAnchor.constraint(equalTo: starRatingView.bottomAnchor, constant: 16).isActive = true
        noteTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupNoteTextView() {
        scrollView.addSubview(noteTextView)
        noteTextView.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 8).isActive = true
        noteTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        noteTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupTipsLabel() {
        scrollView.addSubview(tipsLabel)
        tipsLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 16).isActive = true
        tipsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    private func setupHorizontalCollectionView() {
        scrollView.addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: tipsLabel.bottomAnchor, constant: 8).isActive = true
        horizontalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        horizontalCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private func setupPayNowButtonButton() {
        scrollView.addSubview(payNowButton)
        payNowButton.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 32).isActive = true
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
        
        self.rateThisService()
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
        self.alert2(title: "Ooops!!".localized(), message: "Sorry you can not edit Service Request details from here.".localized())
    }
    
    private func alert2(title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func alert(title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: { action in
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is JobListViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension CustomerJobDone : UIScrollViewDelegate {
    
}

extension CustomerJobDone : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView == self.collectionView {
            return self.listOfServices.count
        }
        else {
            return self.tipsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
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
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: horizontalCellID, for: indexPath) as? HorizontalCollectionViewCell else {
                let cell = collectionView.cellForItem(at: indexPath)!
                return cell
            }
            cell.priceText = "\(self.tipsArray[indexPath.row])"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView {
            self.selectedItem = indexPath.item
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.reloadData()
        }
        else {
            
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.isSelected = true
            self.tips = self.tipsArray[indexPath.row]
        }
        
    }
    
    
    @objc func handleExpandButton(_ sender : UIButton) {
        showServiceDetailsList.show(serviceID : sender.tag)
    }
}

extension CustomerJobDone: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let width: CGFloat = collectionView.frame.width
            let height: CGFloat = 90
            return CGSize(width: width, height: height)
        }
        else {
            let width: CGFloat = (collectionView.frame.width / 7) - 10
            let height: CGFloat = collectionView.frame.height
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView {
         return 0
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView {
            return 8
        }
        else {
            return 5
        }
    }
    
}

// API Functions
extension CustomerJobDone {
    
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
                    
                    self.areaNameLabel.text = "\(serviceList.data.serviceRequest.location.apartmentNo), \(serviceList.data.serviceRequest.location.street), \(serviceList.data.serviceRequest.location.street), \(serviceList.data.serviceRequest.location.areaName)"
                    self.jobIDLabel.text = "\(serviceList.data.serviceRequest.serviceRequestMasterId)"
                    self.taskCompletedLabel.text = Helper.getDateAndTime(timeInterval: serviceList.data.serviceRequest.completedByAgentAt, dateFormat: "MM-dd-YYYY")
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
    
    func rateThisService() {
        
        self.activityIndicator.startAnimating()
        guard let serviceRequestMasterID = self.serviceRequestMasterID else { return }
        guard let note = self.noteTextView.text else { return }
        
        guard let url = URL(string: "\(API_URL)api/v1/member/service/rating/submit") else { return }
        let params = ["MemberId" : UserDefaults.standard.value(forKey: MEMBER_ID) as! Int,
                      "AgentId" : 1,
                      "ServiceRequestMasterId" : serviceRequestMasterID,
                      "Tip" : self.tips,
                      "Comment" : note,
                      "Rating" : self.starRatingView.value] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            // code after a successfull reponse
            self.activityIndicator.stopAnimating()
            print(response)
            self.alert(title: "Thank You".localized(), message: "Thanks for rating our service. We really appreciate it.".localized())
        })
    }
}

extension CustomerJobDone : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your comments".localized()
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
