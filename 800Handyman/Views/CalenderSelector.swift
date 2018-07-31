//
//  CalenderSelector.swift
//  800Handyman
//
//  Created by Al Mobin on 15/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
class CalendarSelector: NSObject {
    
    var selectorData = [NSObject]()
    var selectedDateButton : String!
    var userType : String!
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        view.alpha = 0
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var todayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Today", for: .normal)
        button.setTitleColor(UIColor(red:0.12, green:0.53, blue:0.90, alpha:1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleToday), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let myDatePicker: UIDatePicker = {
       
        let datepicker = UIDatePicker()
        return datepicker
    }()
    
    var dateTimeVC = SelectDateTimeViewController()
    
    func show() {
        
        setupSubViews()
    }
    
    func setupSubViews() {
        // adding the background view
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 1
            })
            // constraints
            backgroundView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            
            // adding the container view
            setupContainerView(window: window)
        }
    }
    
    func setupContainerView(window: UIWindow) {
        window.addSubview(containerView)
        let height = window.frame.height * 0.4
        let y = window.frame.height - height
        containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        self.setupCalendarView()
        self.setuptodayButtonView()
        self.setupCancelButtonView()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    func setupCalendarView(){
        // setting properties of the datePicker
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let datePickerHeight = screenHeight * 0.4
        //let y = screenHeight - datePickerHeight
        myDatePicker.frame = CGRect(x: 0, y: 0, width: screenWidth, height: datePickerHeight)
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.backgroundColor = UIColor.white
        myDatePicker.layer.cornerRadius = 5.0
        myDatePicker.layer.shadowOpacity = 0.5
        myDatePicker.datePickerMode = .date
        myDatePicker.addTarget(self, action: #selector(handleDate(sender:)), for: .valueChanged )
        
        self.containerView.addSubview(myDatePicker)
    }
    func setuptodayButtonView(){
        self.backgroundView.addSubview(todayButton)
        todayButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        todayButton.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    }
    func setupCancelButtonView(){
        self.backgroundView.addSubview(cancelButton)
        cancelButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: todayButton.centerYAnchor).isActive = true
    }
    @objc func handleDate(sender: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let selectedDate = dateFormatter.string(from: sender.date)
        
        self.handleDate(selectedDate: selectedDate)
    }
    @objc func handleToday(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let today = formatter.string(from: date)
        
        self.handleDate(selectedDate: today)
    }
    
    private func handleDate(selectedDate : String) {
        dateTimeVC.changeFromDateButtonTitle(withString: selectedDate)
    }
    @objc func handleCancel(){
        
        self.hide()
    }
    @objc func hide() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
}
