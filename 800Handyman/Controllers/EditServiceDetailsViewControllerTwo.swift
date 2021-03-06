//
//  EditServiceDetailsViewControllerTwo.swift
//  800Handyman
//
//  Created by Al Mobin on 4/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Photos
import SDWebImage
import Localize_Swift

class EditServiceDetailsViewControllerTwo: UIViewController {
    
    var selectedServiceId : Int!
    var selectedSubServiceId : Int!
    var serviceRequestDetailsID : Int?
    var serviceDetailsObj = [NSObject]()
    var imagePicker = UIImagePickerController()
    
    var imageArray = [UIImage]()
    var imageURLs = [String]()
    var isImageSelected : Bool = false
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Service Details"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceTag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "priceIcon")
        return imageView
    }()
    
    let jobSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Description"
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        //field.placeholder = "Write Your Job Details"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
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
    
    let specialNoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Any Special Note (Optional)"
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var specialNoteTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        //field.placeholder = "Don't press the door bell"
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor(red:0.99, green:0.85, blue:0.21, alpha:1.0).cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let addAnotherServiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPDATE", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateButtonTapped(_:)), for: .touchUpInside)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_BOLD, size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNewImageButtonTapped(_:)), for: .touchUpInside)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 25
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
    
    let serviceRequestImageCellID = "ServiceRequestImageCell"
    
    
    var locationVC = LocationFirstViewController()
    var numberOfItems : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfItems = self.imageArray.count
        
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        collectionView.register(ServiceRequestImageCell.self, forCellWithReuseIdentifier: serviceRequestImageCellID)
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.descriptionTextField.delegate = self
        self.specialNoteTextField.delegate = self
        self.imagePicker.delegate = self
        
        layout()
        guard let serviceRequestDetailsID = self.serviceRequestDetailsID else { return }
        print(serviceRequestDetailsID)
        self.getDetailsOfSelectedSubService(subServiceID: serviceRequestDetailsID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 140)
        self.collectionView.reloadData()
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        /*navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)*/
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: nil, action: nil)
    }
    
    private func layout() {
        setScrollView()
        setTitleLabel()
        setJobTitleLabel()
        setPriceLabel()
        setPriceTagIcon()
        setJobSubTitleLabel()
        setDescriptionLabel()
        setDescriptionTextField()
        setCollectionView()
        setAddNewImageButton()
        setSpecialNoteLabel()
        setSpecialNoteTextField()
        //setNextButton()
        setAnotherServiceButton()
        setCancelButton()
        setupActivityIndicator()
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
    }
    
    private func setJobTitleLabel() {
        scrollView.addSubview(jobTitleLabel)
        jobTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        jobTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setPriceLabel() {
        scrollView.addSubview(priceLabel)
        priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: jobTitleLabel.centerYAnchor).isActive = true
    }
    
    private func setPriceTagIcon(){
        scrollView.addSubview(priceTag)
        priceTag.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -5).isActive = true
        priceTag.widthAnchor.constraint(equalToConstant: 16).isActive = true
        priceTag.heightAnchor.constraint(equalToConstant: 16).isActive = true
        priceTag.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
    }
    
    private func setJobSubTitleLabel() {
        scrollView.addSubview(jobSubTitleLabel)
        jobSubTitleLabel.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        jobSubTitleLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 8).isActive = true
        jobSubTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func setDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: jobSubTitleLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setDescriptionTextField() {
        scrollView.addSubview(descriptionTextField)
        descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        descriptionTextField.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        descriptionTextField.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor).isActive = true
        descriptionTextField.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setCollectionView() {
        scrollView.addSubview(collectionView)
        let rows: CGFloat = (CGFloat(numberOfItems)/3).rounded(.up)
        _ = (view.frame.width / 3) * (rows) - 32
        collectionView.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 50).isActive = true
        collectionView.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    private func setAddNewImageButton(){
        scrollView.addSubview(addImageButton)
        addImageButton.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -25).isActive = true
        addImageButton.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor, constant: -10).isActive = true
        addImageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addImageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setSpecialNoteLabel() {
        scrollView.addSubview(specialNoteLabel)
        specialNoteLabel.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        specialNoteLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 12).isActive = true
    }
    
    private func setSpecialNoteTextField() {
        scrollView.addSubview(specialNoteTextField)
        specialNoteTextField.topAnchor.constraint(equalTo: specialNoteLabel.bottomAnchor, constant: 8).isActive = true
        specialNoteTextField.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        specialNoteTextField.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor).isActive = true
        specialNoteTextField.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setNextButton() {
        scrollView.addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: specialNoteTextField.bottomAnchor, constant: 16).isActive = true
        nextButton.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    private func setAnotherServiceButton() {
        scrollView.addSubview(addAnotherServiceButton)
        addAnotherServiceButton.topAnchor.constraint(equalTo: specialNoteTextField.bottomAnchor, constant: 16).isActive = true
        addAnotherServiceButton.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        addAnotherServiceButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.45).isActive = true
        addAnotherServiceButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    private func setCancelButton() {
        scrollView.addSubview(cancelButton)
        cancelButton.centerYAnchor.constraint(equalTo: addAnotherServiceButton.centerYAnchor).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.45).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditServiceDetailsViewControllerTwo: UIScrollViewDelegate {
    
}

extension EditServiceDetailsViewControllerTwo: UISearchControllerDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceRequestImageCellID, for: indexPath) as? ServiceRequestImageCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.removeButton.alpha = 1
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removeImage(sender:)), for: .touchUpInside)
        //cell.mainImage = self.imageArray[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: self.imageURLs[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "image_placeholder"), options: [.continueInBackground, .progressiveDownload, .lowPriority, .scaleDownLargeImages], completed: nil)
        if let image = cell.imageView.image {
            self.imageArray.append(image)
        }
        
        return cell
    }
    
    @objc private func removeImage(sender: UIButton) {
        
        self.imageArray.remove(at: sender.tag)
        self.collectionView.reloadData()
    }
}

extension EditServiceDetailsViewControllerTwo: UICollectionViewDelegateFlowLayout {
    
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

// Actions and API functions
extension EditServiceDetailsViewControllerTwo {
    
    func showEmptyAlert( requiredField : String ){
        let alert = UIAlertController(title: "Ooops!!", message: "\(requiredField) field can not be empty", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeFormEmpty(){
        self.descriptionTextField.text = ""
        self.specialNoteTextField.text = ""
    }
    
    @objc private func updateButtonTapped(_ sender: UIButton) {
        
        self.updateServiceDetails()
    }
    
    @objc private func addAnotherServiceButtonTapped(_ sender: UIButton) {
        
        if  UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int > 0 && UserDefaults.standard.value(forKey: IS_ANOTHER_SERVICE_REQUEST) as! Bool == true {
            
            self.addAnotherServiceInMasterId()
        }
        else {
            
            self.addServiceRequest()
        }
        
        UserDefaults.standard.set(true, forKey: IS_ANOTHER_SERVICE_REQUEST) /* This value should be true for multiple service adding */
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addServiceRequest(){
        
        guard let description = self.descriptionTextField.text else { return }
        guard let title       = self.jobSubTitleLabel.text else { return }
        
        if description == "" {
            self.showEmptyAlert(requiredField: "Description")
            return
        }
        
        if title == "" {
            self.showEmptyAlert(requiredField: "Title")
            return
        }
        
        self.activityIndicator.startAnimating()
        
        var params = ["Title"       : title,
                      "Description" : description,
                      "Note"        : self.specialNoteTextField.text!,
                      "ServiceId"   : self.selectedSubServiceId!,
                      "MemberId"    : UserDefaults.standard.value(forKey: MEMBER_ID) as! Int] as [String : Any]
        
        /* Checking whether multiple services have been added */
        if UserDefaults.standard.value(forKey: IS_ANOTHER_SERVICE_REQUEST) as! Bool {
            
            if UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int > 0 {
                
                params["serviceRequestMasterId"] = UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int
            }
        }
        
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/submit") else { return }
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type": "application/x-www-form-urlencoded", "Authorization" : "\(AUTH_KEY)"]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            print("Response of Next Button: \(response)")
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let submittedRequestResponse = try decoder.decode(AnotherServiceRequestResponse.self, from: json)
                    
                    let serviceRequestMasterId = submittedRequestResponse.data.serviceRequest.serviceRequestMasterId
                    UserDefaults.standard.set(serviceRequestMasterId, forKey: SERVICE_REQUEST_MASTER_ID)
                    
                    if self.isImageSelected {
                        
                        self.sendImageToServer(serviceRequestDetailId: submittedRequestResponse.data.serviceRequest.serviceRequestDetailId)
                    }
                    
                } catch let err {
                    print(err)
                }
            }
            
            self.makeFormEmpty()
            self.activityIndicator.stopAnimating()
        })
    }
    
    func addAnotherServiceInMasterId(){
        
        guard let description = self.descriptionTextField.text else { return }
        guard let title       = self.jobSubTitleLabel.text else { return }
        
        if description == "" {
            self.showEmptyAlert(requiredField: "Description")
            return
        }
        
        if title == "" {
            self.showEmptyAlert(requiredField: "Title")
            return
        }
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/submit/another") else { return }
        var params = ["Title"       : title,
                      "Description" : description,
                      "Note"        : self.specialNoteTextField.text!,
                      "ServiceId"   : self.selectedSubServiceId!,
                      "MemberId"    : UserDefaults.standard.value(forKey: MEMBER_ID) as! Int] as [String : Any]
        
        /* Checking whether multiple services have been added */
        if UserDefaults.standard.value(forKey: IS_ANOTHER_SERVICE_REQUEST) as! Bool {
            
            if UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int > 0 {
                
                params["serviceRequestMasterId"] = UserDefaults.standard.value(forKey: SERVICE_REQUEST_MASTER_ID) as! Int
                
            }
        }
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type": "application/x-www-form-urlencoded", "Authorization" : "\(AUTH_KEY)"]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let submittedRequestResponse = try decoder.decode(AnotherServiceRequestResponse.self, from: json)
                    
                    print("Response of Another Button: \(response)")
                    print(submittedRequestResponse.data.serviceRequest.serviceRequestDetailId)
                    
                    if self.isImageSelected {
                        
                        self.sendImageToServer(serviceRequestDetailId: submittedRequestResponse.data.serviceRequest.serviceRequestDetailId)
                    }
                    
                    
                } catch let err {
                    print(err)
                }
            }
            
            self.makeFormEmpty()
            self.activityIndicator.stopAnimating()
        })
    }
    
    func sendImageToServer(serviceRequestDetailId : Int){
        
        let url = "\(API_URL)api/v1/member/service/request/image/file/upload" /* your API url */
        
        let headers: HTTPHeaders = [
            "Authorization": "\(AUTH_KEY)",
            "Content-type": "multipart/form-data"
        ]
        let parameters = ["ServiceRequestDetailId" : serviceRequestDetailId] as [String: Any]
        print("The Service request detail id is: \(serviceRequestDetailId)")
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for (image) in self.imageArray {
                if  let imageData = UIImageJPEGRepresentation(image, 0.6) {
                    
                    multipartFormData.append(imageData, withName: "file", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
            }
            
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response)
                    
                    //
                    self.isImageSelected = false
                    self.imageArray.removeAll()
                    self.imageArray = [#imageLiteral(resourceName: "image_placeholder"), #imageLiteral(resourceName: "image_placeholder"), #imageLiteral(resourceName: "image_placeholder")]
                    
                    if let err = response.error{
                        print(err)
                        return
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewImageButtonTapped(_ sender: UIButton){
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension EditServiceDetailsViewControllerTwo : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //            if !isImageSelected {
            //                self.imageArray.removeAll()
            //            }
            
            self.imageArray.append(image)
            
            self.isImageSelected = true
            self.numberOfItems = self.imageArray.count
            
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        picker.dismiss(animated: true, completion: nil);
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func resizeImage2(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newWidth, height: newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
}

extension EditServiceDetailsViewControllerTwo : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.specialNoteTextField {
            
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

extension EditServiceDetailsViewControllerTwo {
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
                            
                            self.jobTitleLabel.text = eachService.serviceParentTitle
                            self.jobSubTitleLabel.text = eachService.title
                            self.serviceRequestDetailsID = eachService.serviceRequestDetailId
                            self.titleLabel.text = eachService.serviceParentTitle
                            self.descriptionTextField.text = eachService.description
                            self.priceLabel.text = eachService.serviceRate
                            self.specialNoteTextField.text = eachService.note
                            self.serviceDetailsObj.append(container)
                            self.imageURLs = eachService.thumbnails
                            
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
    
    func updateServiceDetails() {
        guard let serviceRequestDetailsID = self.serviceRequestDetailsID else { return }
        guard let description = self.descriptionTextField.text else { return }
        guard let title       = self.jobSubTitleLabel.text else { return }
        
        if description == "" {
            self.showEmptyAlert(requiredField: "Description")
            return
        }
        
        if title == "" {
            self.showEmptyAlert(requiredField: "Title")
            return
        }
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/service/request/details/update") else { return }
        let params = ["Title"       : title,
                      "Description" : description,
                      "Note"        : self.specialNoteTextField.text!,
                      "ServiceRequestDetailId" : serviceRequestDetailsID] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            print(response)
            self.navigationController?.popViewController(animated: true)
            self.activityIndicator.stopAnimating()
        })
        
    }
}

