//
//  ChatViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire

class ChatViewController: UIViewController {
    
    var tabBar = UITabBar()
    var chats = [NSObject]()
    
    var isChatHistoryExist : Bool?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = NSLocalizedString("No Chat History Found", comment: "No Chat History Found")
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    let replyContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var replyTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.placeholder = "Write a reply"
        field.textAlignment = .left
        field.font = UIFont.systemFont(ofSize: 14)
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        return field
    }()
    
    lazy var replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleReplyButton), for: .touchUpInside)
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
    
    let receiverMessageCellId = "ReceiverMessageCell"
    let senderMessageCellId = "SenderMessageCell"
    
    var keyboardHeight: CGFloat = 0
    var replyContainerBottomConstraint: NSLayoutConstraint!
    
    @objc private func handleReplyButton() {
        
        guard let reply = self.replyTextField.text else {
            
            print("Reply text field error")
            return
        }
        
        if reply != "" {
            
            if  self.checkMemberID() {
                
                sendMessage(reply: reply)
            }
            else {
                
                self.alert(title: "Ooops!!", message: "Please register first")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BACKGROUND_COLOR
        setNavigationBar()
        
        collectionView.register(ReceiverMessageCell.self, forCellWithReuseIdentifier: receiverMessageCellId)
        collectionView.register(SenderMessageCell.self, forCellWithReuseIdentifier: senderMessageCellId)
        
        layout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // add keyboard appear observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // add keyboard disappear observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappeared(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // chat history
        if self.checkMemberID() {
            
            self.getChatHisotry()
        }
        else {
            
            self.alert(title: "Ooops!!", message: "Please register first")
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        let imageView = UIImageView(image: #imageLiteral(resourceName: "navLogo"))
        imageView.contentMode = .scaleAspectFit
        navigationController?.navigationBar.topItem?.titleView = imageView
    }
    
    private func layout() {
        //setTitleLabel()
        setupReplyContainer()
        setCollectionView()
        setupActivityIndicator()
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.replyContainer.topAnchor, constant: -10).isActive = true
    }
    
    private func setupReplyContainer() {
        view.addSubview(replyContainer)
        replyContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        replyContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        replyContainerBottomConstraint = replyContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        replyContainerBottomConstraint.isActive = true
        replyContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupReplyButton()
        setupReplyTextField()
    }
    
    private func setupReplyButton() {
        replyContainer.addSubview(replyButton)
        replyButton.centerYAnchor.constraint(equalTo: replyContainer.centerYAnchor).isActive = true
        replyButton.rightAnchor.constraint(equalTo: replyContainer.rightAnchor, constant: -10).isActive = true
        replyButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        replyButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupReplyTextField() {
        replyContainer.addSubview(replyTextField)
        replyTextField.centerYAnchor.constraint(equalTo: replyContainer.centerYAnchor).isActive = true
        replyTextField.leftAnchor.constraint(equalTo: replyContainer.leftAnchor, constant: 5).isActive = true
        replyTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        replyTextField.rightAnchor.constraint(equalTo: replyButton.leftAnchor, constant: -5).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func scrollCollectionView(position: UICollectionViewScrollPosition) {
        let itemIndex: Int!
        
        switch position {
        case .top:
            itemIndex = 0
        default:
            itemIndex = self.collectionView.numberOfItems(inSection: 0) - 1
        }
        
        self.collectionView.scrollToItem(at: IndexPath(item: itemIndex, section: 0), at: position, animated: false)
        
    }
    
    private func adaptLayoutChanges() {
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardAppeared(notification: Notification) {
        
        guard let isChatHistoryExist = self.isChatHistoryExist else {
            return
        }
        if isChatHistoryExist {
            self.getChatHisotry()
        }
        
        guard var customTabBarHeight = CustomTabBarController.customTabBarHeight else {
            return
        }
        
        if Helper.isIphoneX {
            
            customTabBarHeight = customTabBarHeight + 34
        }
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            keyboardHeight = keyboardSize.height
            replyContainerBottomConstraint.constant = -keyboardHeight + customTabBarHeight
            collectionView.contentOffset = CGPoint(x: 0, y: collectionView.contentOffset.y + keyboardHeight + 10)
            adaptLayoutChanges()
            
            print(keyboardHeight)
        }
    }
    
    @objc private func keyboardDisappeared(notification: Notification) {
        replyContainerBottomConstraint.constant = 0
        adaptLayoutChanges()
    }
    
    private func makeFormEmpty() {
        
        self.replyTextField.text = ""
    }
    
    //if key exists
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    private func alert(title : String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // check member is registered or not
    func checkMemberID() -> Bool {
        
        if isKeyPresentInUserDefaults(key: MEMBER_ID) {
            return true
        }
        else {
            
            return false
        }
    }
}

extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let receiverCell = collectionView.dequeueReusableCell(withReuseIdentifier: receiverMessageCellId, for: indexPath) as? ReceiverMessageCell else {
            let cell_1 = collectionView.cellForItem(at: indexPath)!
            return cell_1
        }
        
        guard let senderCell = collectionView.dequeueReusableCell(withReuseIdentifier: senderMessageCellId, for: indexPath) as? SenderMessageCell else {
            let cell_2 = collectionView.cellForItem(at: indexPath)!
            return cell_2
        }
        
        if let data = chats as? [chatNSObject] {
            
            if  data[indexPath.row].isMe {
                
                senderCell.senderText = data[indexPath.row].message
                senderCell.timeText = "\(data[indexPath.row].time)"
                if  data[indexPath.row].isSeen {
                    
                    senderCell.seenStatusImageView.image = #imageLiteral(resourceName: "seen")
                }
                else {
                    
                    senderCell.seenStatusImageView.image = #imageLiteral(resourceName: "unseen")
                }
                
                
                return senderCell
            }
            else {
                
                receiverCell.profileImageView.image = #imageLiteral(resourceName: "support")
                receiverCell.receiverText = data[indexPath.row].message
                receiverCell.timeText = "\(data[indexPath.row].time)"
                if  data[indexPath.row].isSeen {
                    
                    receiverCell.seenStatusImageView.image = #imageLiteral(resourceName: "seen")
                }
                else {
                    
                    receiverCell.seenStatusImageView.image = #imageLiteral(resourceName: "unseen")
                }
                return receiverCell
            }
        }
        else {
            
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let data = chats as? [chatNSObject] else { return CGSize(width: 0, height: 0) }
        
        let width: CGFloat = collectionView.frame.width
        let contents = NSAttributedString(string: data[indexPath.item].message, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        let cellRect = contents.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil)
        let height: CGFloat = cellRect.size.height + 30
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
}

extension ChatViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

// API FUNCTIONS
extension ChatViewController {
    
    // send message
    private func sendMessage(reply : String) {
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/chat/submit") else { return }
        let params = ["MemberId" : UserDefaults.standard.value(forKey: MEMBER_ID) as! Int,
                      "MessageBody" : reply] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            
            // code after a successfull reponse
            print(response)
            self.makeFormEmpty()
            self.getChatHisotry()
            self.activityIndicator.stopAnimating()
        })
    }
    
    
    // chat history
    private func getChatHisotry() {
        
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "\(API_URL)api/v1/member/chat/history?id=\(UserDefaults.standard.value(forKey: MEMBER_ID) as! Int)") else { return }
        
        Alamofire.request(url,method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                self.activityIndicator.stopAnimating()
                return
            }
            if !self.chats.isEmpty {
                
                self.chats.removeAll()
            }
            // code after a successfull reponse

            if let json = response.data {
                
                let decoder = JSONDecoder()
                do {
                    let chatHistoryStatus = try decoder.decode(ChatHistoryStatus.self, from: json)
                    
                    print(chatHistoryStatus.isSuccess)
                    
                    self.isChatHistoryExist = chatHistoryStatus.isSuccess
                    
                    if  !chatHistoryStatus.isSuccess {
                        self.alert(title: "Oops!!", message: "No Chat History Found")
                    }
                    else {
                        
                        let chatHistory = try decoder.decode(ChatResponse.self, from: json)
                        
                        for eachChat in chatHistory.data.chats {
                            
                            let chat = chatNSObject(message: eachChat.message, isMe: eachChat.isMe, isSeen: eachChat.isSeen, time: eachChat.time)
                            self.chats.append(chat)
                        }
                        
                        self.collectionView.reloadData()
                        DispatchQueue.main.async(execute: {
                            self.scrollCollectionView(position: .bottom)
                        })
                    }
                    
                    self.activityIndicator.stopAnimating()
                    
                } catch let err {
                    print(err)
                }
            }
            self.activityIndicator.stopAnimating()
        })
    }
}
