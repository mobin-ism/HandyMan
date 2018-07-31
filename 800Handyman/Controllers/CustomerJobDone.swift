//
//  CustomerJobDone.swift
//  800Handyman
//
//  Created by Creativeitem on 8/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
class CustomerJobDone : UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Customer Job Done", comment: "Customer Job Done")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
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
    
    let innerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var innerScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let jobIdTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Job ID", comment: "Job ID")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "HM6978"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskCompletedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Task Completed", comment: "Task Completed")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobCompletedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Job Completed Date", comment: "Job Completed Date")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobCompletedDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rateOurServicesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Rate Our Services", comment: "Rate Our Services")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starRateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Note", comment: "Note")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.backgroundColor = UIColor.white
        field.keyboardType = .default
        field.layer.cornerRadius = 4
        field.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        field.textColor = UIColor.black
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let tipsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("Do you like to pay tips", comment: "Do you like to pay tips")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rate Now", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        layout()
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentHeight: CGFloat = 0
        var innerContentHeight : CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 140)
        
        for innerView in innerScrollView.subviews {
            innerContentHeight = innerContentHeight + innerView.frame.size.height
        }
        innerScrollView.contentSize = CGSize(width: innerView.frame.width, height: innerContentHeight + 140)
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: nil, action: nil)
    }
    
    private func layout() {
        setScrollView()
        setTitleLabel()
        setInnerView()
        setInnerScrollView()
        setJobIdTitleLabel()
        setJobIDLabel()
        //set()
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
    
    private func setInnerView() {
        scrollView.addSubview(innerView)
        innerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        innerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        innerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        innerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setInnerScrollView() {
        innerView.addSubview(innerScrollView)
        innerScrollView.topAnchor.constraint(equalTo: innerView.topAnchor).isActive = true
        innerScrollView.leftAnchor.constraint(equalTo: innerView.leftAnchor).isActive  = true
        innerScrollView.rightAnchor.constraint(equalTo: innerView.rightAnchor).isActive = true
        innerScrollView.bottomAnchor.constraint(equalTo: innerView.bottomAnchor).isActive = true
    }
    
    private func setJobIdTitleLabel() {
        scrollView.addSubview(jobIdTitleLabel)
        jobIdTitleLabel.topAnchor.constraint(equalTo: innerView.bottomAnchor, constant: 16).isActive = true
        jobIdTitleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
    }
    
    private func setJobIDLabel() {
        scrollView.addSubview(jobIdLabel)
        jobIdLabel.centerYAnchor.constraint(equalTo: jobIdTitleLabel.centerYAnchor).isActive = true
        jobIdLabel.leftAnchor.constraint(equalTo: jobIdTitleLabel.rightAnchor, constant: 10).isActive = true
    }
    
    private func setTaskCompletedLabel() {
        scrollView.addSubview(taskCompletedLabel)
        taskCompletedLabel.topAnchor.constraint(equalTo: jobIdTitleLabel.bottomAnchor, constant: 16).isActive = true
        taskCompletedLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
    }
    
    private func setJobCompletedLabel() {
        scrollView.addSubview(jobCompletedLabel)
        jobCompletedLabel.topAnchor.constraint(equalTo: taskCompletedLabel.bottomAnchor, constant: 16).isActive = true
        jobCompletedLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
    }
    
    private func setRateOurServicesTitleLabel() {
        scrollView.addSubview(rateOurServicesLabel)
        rateOurServicesLabel.topAnchor.constraint(equalTo: jobCompletedLabel.bottomAnchor, constant: 16).isActive = true
        rateOurServicesLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
    
        
    }
    private func set() {
        
        innerScrollView.addSubview(jobCompletedDateLabel)
        jobCompletedDateLabel.topAnchor.constraint(equalTo: innerScrollView.topAnchor, constant: 16).isActive = true
        jobCompletedDateLabel.leftAnchor.constraint(equalTo: innerScrollView.leftAnchor, constant: 16).isActive = true
        jobCompletedDateLabel.rightAnchor.constraint(equalTo: innerScrollView.rightAnchor, constant: -16).isActive = true
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension CustomerJobDone : UIScrollViewDelegate {
    
}
