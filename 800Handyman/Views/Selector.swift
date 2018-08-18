
//
//  Selector.swift
//  800Handyman
//
//  Created by Creativeitem on 17/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class Selector : NSObject {
    
    var selectorData = [NSObject]()
    
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
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.allowsMultipleSelection = false
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let cellId = "selectorCell"
    
    var locationVC = LocationFirstViewController()
    var editLocationVC = EditLocationFirstViewController()
    
    override init() {
        super.init()
        tableView.register(SelectorCell.self, forCellReuseIdentifier: cellId)
    }
    
    func show(withData tableData: [NSObject]) {
        selectorData = tableData
        setupSubViews()
        tableView.reloadData()
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
            backgroundView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
            backgroundView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
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
        
        setupTableView()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    func setupTableView() {
        containerView.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
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

extension Selector : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SelectorCell {
            
            if let data = selectorData as? [AreaNSObject] {
                cell.titleText = "\(data[indexPath.row].areaName)"
            }
            return cell
        }
        else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            if let data = self.selectorData as? [AreaNSObject] {
                self.locationVC.changeSelectorTitle(withString: "\(data[indexPath.row].areaName)")
                self.locationVC.selectedAreaID = data[indexPath.row].areaId
                
                self.editLocationVC.changeSelectorTitle(withString: "\(data[indexPath.row].areaName)")
                self.editLocationVC.selectedAreaID = data[indexPath.row].areaId
            }
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
}
