//
//  PhoneViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {
    
    lazy var button: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Move to test vc", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.backgroundColor = YELLOW_ACCENT
        bt.clipsToBounds = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
        
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc func btnTapped() {
        //navigationController?.pushViewController(ThankYouViewController(), animated: true)
        navigationController?.pushViewController(SelectDateTimeViewController(), animated: true)
        //navigationController?.pushViewController(LocationFirstViewController(), animated: true)
        //navigationController?.pushViewController(LocationSecondViewController(), animated: true)
        //navigationController?.pushViewController(LetUsKnowDetailsViewController(), animated: true)
        //navigationController?.pushViewController(JobDetailsViewController(), animated: true)
    }
    
}
