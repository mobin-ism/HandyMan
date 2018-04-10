//
//  SelectDateTimeViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 8/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class SelectDateTimeViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Select Date and Time"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Select date"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "10-03-2018"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var downArrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "downArrowIcon")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let timeSlotLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Available Time Slot"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    let timeSelectCellId = "TimeSelectCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        collectionView.register(TimeSelectCell.self, forCellWithReuseIdentifier: timeSelectCellId)
        
        layout()
    }
    
    private func setNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leftArrowIcon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: nil)
    }
    
    private func layout() {
        setTitleLabel()
        setSelectDateLabel()
        setDateHolder()
        setDateLabel()
        setDownArrowIcon()
        setTimeSlotLabel()
        setNextButton()
        setCollectionView()
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    }
    
    private func setSelectDateLabel() {
        view.addSubview(selectDateLabel)
        selectDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        selectDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setDateHolder() {
        view.addSubview(dateHolder)
        dateHolder.leftAnchor.constraint(equalTo: selectDateLabel.leftAnchor).isActive = true
        dateHolder.topAnchor.constraint(equalTo: selectDateLabel.bottomAnchor, constant: 8).isActive = true
        dateHolder.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        dateHolder.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setDateLabel() {
        dateHolder.addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: dateHolder.centerYAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: dateHolder.leftAnchor, constant: 16).isActive = true
    }
    
    private func setDownArrowIcon() {
        dateHolder.addSubview(downArrowIcon)
        downArrowIcon.centerYAnchor.constraint(equalTo: dateHolder.centerYAnchor).isActive = true
        downArrowIcon.rightAnchor.constraint(equalTo: dateHolder.rightAnchor, constant: -16).isActive = true
        downArrowIcon.widthAnchor.constraint(equalToConstant: 11).isActive = true
        downArrowIcon.heightAnchor.constraint(equalToConstant: 11 * 0.6).isActive = true
    }
    
    private func setTimeSlotLabel() {
        view.addSubview(timeSlotLabel)
        timeSlotLabel.leftAnchor.constraint(equalTo: selectDateLabel.leftAnchor).isActive = true
        timeSlotLabel.topAnchor.constraint(equalTo: dateHolder.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setNextButton() {
        view.addSubview(nextButton)
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.topAnchor.constraint(equalTo: timeSlotLabel.bottomAnchor, constant: 8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16).isActive = true
    }
    
}

extension SelectDateTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timeSelectCellId, for: indexPath) as? TimeSelectCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainText = "7AM - 8AM"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TimeSelectCell else { return }
        cell.isSelected = true
        print(indexPath.item)
    }
    
}

extension SelectDateTimeViewController: UICollectionViewDelegateFlowLayout {
    
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
