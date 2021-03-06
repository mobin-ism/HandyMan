//
//  ProfileViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 8/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift

class ProfileViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "profileBg")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "dummy3")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileInfoHolder: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let vipIconView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "vipIcon")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let zoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
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
    
    let creditCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cardLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 10)
        label.text = "Credit card".localized()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 20)
        label.text = "3939........4567"
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("EDIT".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var addNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD NEW".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = YELLOW_ACCENT
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    let profileInfoCellId = "ProfileInfoCell"
    let infos = ["Total Spent".localized(), "Loyalty Point".localized(), "Total Job".localized(), "Completed Job".localized(), "Running Job".localized(),  "Cancel Job".localized()]
    var mains = ["", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        collectionView.register(ProfileInfoCell.self, forCellWithReuseIdentifier: profileInfoCellId)
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getProfileDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileInfoHolder.setGradientLayer(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationController?.navigationBar.topItem?.titleView = imageView
    }
    
    private func layout() {
        setBackgroundImage()
        setProfileInfoHolder()
        setProfileImage()
        setNameLabel()
        setVipIconView()
        setVerticalLine()
        setZoneLabel()
        setAreaLabel()
        setCollectionView()
        setCreditCardView()
        setCardLabel()
        setCardNumberLabel()
        setEditButton()
        setAddNewButton()
        
        setupActivityIndicator()
    }
    
    private func setBackgroundImage() {
        view.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setProfileInfoHolder() {
        view.addSubview(profileInfoHolder)
        profileInfoHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        profileInfoHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        profileInfoHolder.topAnchor.constraint(equalTo: view.topAnchor, constant: 16 * 6).isActive = true
        if Helper.isIphoneX {
            profileInfoHolder.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22).isActive = true
        } else {
            profileInfoHolder.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        }
    }
    
    private func setProfileImage() {
        view.addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: profileInfoHolder.topAnchor).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: profileInfoHolder.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileInfoHolder.heightAnchor, multiplier: 0.8).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileInfoHolder.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: profileInfoHolder.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
    }
    
    private func setVipIconView() {
        view.addSubview(vipIconView)
        vipIconView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        vipIconView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4).isActive = true
        vipIconView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        vipIconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func setVerticalLine() {
        view.addSubview(verticalLine)
        verticalLine.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        verticalLine.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        verticalLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        verticalLine.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setZoneLabel() {
        view.addSubview(zoneLabel)
        zoneLabel.centerYAnchor.constraint(equalTo: verticalLine.centerYAnchor).isActive = true
        zoneLabel.trailingAnchor.constraint(equalTo: verticalLine.leadingAnchor, constant: -8).isActive = true
    }
    
    private func setAreaLabel() {
        view.addSubview(areaLabel)
        areaLabel.centerYAnchor.constraint(equalTo: verticalLine.centerYAnchor).isActive = true
        areaLabel.leadingAnchor.constraint(equalTo: verticalLine.trailingAnchor, constant: 8).isActive = true
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: profileInfoHolder.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: profileInfoHolder.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: profileInfoHolder.bottomAnchor, constant: 16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 208).isActive = true
    }
    
    private func setCreditCardView() {
        view.addSubview(creditCardView)
        creditCardView.leadingAnchor.constraint(equalTo: profileInfoHolder.leadingAnchor).isActive = true
        creditCardView.trailingAnchor.constraint(equalTo: profileInfoHolder.trailingAnchor).isActive = true
        creditCardView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8).isActive = true
        creditCardView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    private func setCardLabel() {
        creditCardView.addSubview(cardLabel)
        cardLabel.leadingAnchor.constraint(equalTo: creditCardView.leadingAnchor, constant: 8).isActive = true
        cardLabel.topAnchor.constraint(equalTo: creditCardView.topAnchor, constant: 8).isActive = true
    }
    
    private func setCardNumberLabel() {
        creditCardView.addSubview(cardNumberLabel)
        cardNumberLabel.leadingAnchor.constraint(equalTo: cardLabel.leadingAnchor).isActive = true
        cardNumberLabel.topAnchor.constraint(equalTo: cardLabel.bottomAnchor).isActive = true
        cardNumberLabel.widthAnchor.constraint(equalTo: creditCardView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setEditButton() {
        creditCardView.addSubview(editButton)
        editButton.centerYAnchor.constraint(equalTo: creditCardView.centerYAnchor).isActive = true
        editButton.trailingAnchor.constraint(equalTo: creditCardView.trailingAnchor, constant: -8).isActive = true
        editButton.heightAnchor.constraint(equalTo: creditCardView.heightAnchor, multiplier: 0.6).isActive = true
        editButton.widthAnchor.constraint(equalTo: creditCardView.widthAnchor, multiplier: 0.2).isActive = true
    }
    
    private func setAddNewButton() {
        creditCardView.addSubview(addNewButton)
        addNewButton.centerYAnchor.constraint(equalTo: creditCardView.centerYAnchor).isActive = true
        addNewButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -4).isActive = true
        addNewButton.heightAnchor.constraint(equalTo: creditCardView.heightAnchor, multiplier: 0.6).isActive = true
        addNewButton.widthAnchor.constraint(equalTo: creditCardView.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setSelectedIndex(at index: Int) {
        if (index == 3) {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
        else if(index == 4) {
            // Modal for changing the Language view
            DispatchQueue.main.async {
                self.present(LanguageSelectViewController(), animated: true, completion: nil)
            }
        }
        else if(index == 5) {
            if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
                Alert.logOutConfirmationAlert(on: self)
            }
            else {
                navigationController?.tabBarController?.selectedIndex = 2
            }
        }
        else {
            navigationController?.tabBarController?.selectedIndex = index
            //CustomTabBarController().selectedIndex = index
        }
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileInfoCellId, for: indexPath) as? ProfileInfoCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.info = NSLocalizedString(infos[indexPath.item], comment: infos[indexPath.item])
        cell.mainText = mains[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 2 - 8
        let height: CGFloat = 64
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

// API Calls
extension ProfileViewController {
    
    func getProfileDetails() {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/get/data?id=\(UserDefaults.standard.value(forKey: MEMBER_ID) as! Int)") else { return }
        Alamofire.request(url,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            print(response)
            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let profileDataResponse = try decoder.decode(MemberProfile.self, from: json)
                    
                
                    self.nameLabel.text = profileDataResponse.data.member.name
                    self.zoneLabel.text = "Phone No.".localized() + ": \(profileDataResponse.data.member.phoneNumber)"
                    self.areaLabel.text = "Email".localized() + ": \(profileDataResponse.data.member.email)"
                    self.mains[0]       = "\(profileDataResponse.data.member.totalSpent)"
                    self.mains[1]       = "\(profileDataResponse.data.member.loyaltyPoint)"
                    self.mains[2]       = "\(profileDataResponse.data.member.totalJob)"
                    self.mains[3]       = "\(profileDataResponse.data.member.completedJob)"
                    self.mains[4]       = "\(profileDataResponse.data.member.runningJob)"
                    self.mains[5]       = "\(profileDataResponse.data.member.cancelledJob)"
                    self.view.layoutIfNeeded()
                    self.collectionView.reloadData()
                } catch let err {
                    print(err)
                }
            }
            self.view.layoutIfNeeded()
            self.activityIndicator.stopAnimating()
            
        })
    }
}
