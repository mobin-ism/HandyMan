//
//  ReasonOfCancellation.swift
//  800Handyman
//
//  Created by Al Mobin on 31/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
class ReasonOfCancellation: UIViewController {
    
    var reasonForCancelling : String = ""
    let reasons = ["Customer not in home".localized(), "Customer want to change the date".localized()]
    var serviceRequestMasterID : Int?
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isUserInteractionEnabled = true
        return scroll
    }()
    
    let reasonOfCancellationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Reason oF Cancellation".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Note".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteTextView : UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.clipsToBounds = true
        textview.isEditable = true
        textview.backgroundColor = .white
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor.lightGray.cgColor
        textview.layer.cornerRadius = 4
        return textview
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor(red:0.99, green:0.85, blue:0.21, alpha:1.0).cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSubmitButton(_:)), for: .touchUpInside)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
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
    
    let reasonSelectionCellId = "ReasonSelectionCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        collectionView.register(TimeSelectCell.self, forCellWithReuseIdentifier: reasonSelectionCellId)
        layout()
        noteTextView.delegate = self
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: nil)
    }
    private func layout() {
        setScrollView()
        setupReasonOfCancellationLabel()
        setupCollectionView()
        setupNoteLabel()
        setupNoteTextView()
        setupSubmitButton()
        setupActivityIndicator()
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupReasonOfCancellationLabel() {
        scrollView.addSubview(reasonOfCancellationLabel)
        reasonOfCancellationLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        reasonOfCancellationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    func setupCollectionView() {
        scrollView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: reasonOfCancellationLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupNoteLabel() {
        scrollView.addSubview(noteLabel)
        noteLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    func setupNoteTextView() {
        scrollView.addSubview(noteTextView)
        noteTextView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 10).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupSubmitButton() {
        scrollView.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 16).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive =  true
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSubmitButton(_ sender : UIButton) {
        self.cancelServiceProviderOrder()
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


extension ReasonOfCancellation: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reasonSelectionCellId, for: indexPath) as? TimeSelectCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainText = self.reasons[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TimeSelectCell else { return }
        
        cell.isSelected = true
        self.reasonForCancelling = self.reasons[indexPath.row]
    }
    
}

extension ReasonOfCancellation: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

extension ReasonOfCancellation : UIScrollViewDelegate {
    
}

extension ReasonOfCancellation : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// API Calls
extension ReasonOfCancellation {
    func cancelServiceProviderOrder() {
        self.activityIndicator.startAnimating()
        guard let serviceRequestMasterID = self.serviceRequestMasterID else { return }
        guard let url = URL(string: "\(API_URL)api/v1/member/cancel/service-request") else { return }
        let params = ["ServiceRequestMasterId" : serviceRequestMasterID,
                      "Note" : self.noteTextView.text,
                      "CancelReason" : self.reasonForCancelling] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            self.activityIndicator.stopAnimating()
            print(response)
            self.alert(title: "Service Cancelled".localized(), message: "Congratulations, The Services has been cancelled successfully!".localized())
        })
    }
}
