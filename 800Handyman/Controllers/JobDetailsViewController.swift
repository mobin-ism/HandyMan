//
//  JobDetailsViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 9/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class JobDetailsViewController: UIViewController {
    
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
        label.text = "Job Details"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Cleaning"
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.gray
        label.text = "EDIT"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Full house cleaning"
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
    
    let descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Pha sellus vehicula venena tis elit, quis volu tpat velit ultr icies ac. Pha sellus ultr ma ssa sem, effici tur vitae ullamc orper at, consequat vel augue. Quis qamc orpue arcu metus, fauc."
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Location"
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let zoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Zone: Jumeirah"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Area: Lorem ipsum dolor sit"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Date and time"
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTimeTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "10-03-2018 | 8 AM"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobDetailsImageCellId = "JobDetailsImageCell"
    let numberOfItems = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        collectionView.register(JobDetailsImageCell.self, forCellWithReuseIdentifier: jobDetailsImageCellId)
        layout()
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
        
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftArrowIcon")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: nil, action: nil)
    }
    
    private func layout() {
        setScrollView()
        setTitleLabel()
        setJobTitleLabel()
        setEditLabel()
        setJobSubTitleLabel()
        setDescriptionLabel()
        setDescriptionTextLabel()
        setCollectionView()
        setLocationLabel()
        setZoneLabel()
        setAreaLabel()
        setDateTimeLabel()
        setDateTimeTextLabel()
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
    
    private func setEditLabel() {
        scrollView.addSubview(editLabel)
        editLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        editLabel.centerYAnchor.constraint(equalTo: jobTitleLabel.centerYAnchor).isActive = true
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
    
    private func setDescriptionTextLabel() {
        scrollView.addSubview(descriptionTextLabel)
        descriptionTextLabel.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        descriptionTextLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        descriptionTextLabel.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor).isActive = true
    }
    
    private func setCollectionView() {
        scrollView.addSubview(collectionView)
        let rows: CGFloat = (CGFloat(numberOfItems)/3).rounded(.up)
        let height = (view.frame.width / 3) * (rows) - 32
        collectionView.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 32).isActive = true
        collectionView.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: jobSubTitleLabel.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setLocationLabel() {
        scrollView.addSubview(locationLabel)
        locationLabel.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 12).isActive = true
    }
    
    private func setZoneLabel() {
        scrollView.addSubview(zoneLabel)
        zoneLabel.leftAnchor.constraint(equalTo: locationLabel.leftAnchor).isActive = true
        zoneLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    private func setAreaLabel() {
        scrollView.addSubview(areaLabel)
        areaLabel.leftAnchor.constraint(equalTo: locationLabel.leftAnchor).isActive = true
        areaLabel.topAnchor.constraint(equalTo: zoneLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    private func setDateTimeLabel() {
        scrollView.addSubview(dateTimeLabel)
        dateTimeLabel.leftAnchor.constraint(equalTo: locationLabel.leftAnchor).isActive = true
        dateTimeLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setDateTimeTextLabel() {
        scrollView.addSubview(dateTimeTextLabel)
        dateTimeTextLabel.leftAnchor.constraint(equalTo: dateTimeLabel.leftAnchor).isActive = true
        dateTimeTextLabel.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 8).isActive = true
    }
    
}

extension JobDetailsViewController: UIScrollViewDelegate {
    
}

extension JobDetailsViewController: UISearchControllerDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: jobDetailsImageCellId, for: indexPath) as? JobDetailsImageCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainImage = #imageLiteral(resourceName: "dummy4")
        return cell
    }
    
}

extension JobDetailsViewController: UICollectionViewDelegateFlowLayout {
    
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
