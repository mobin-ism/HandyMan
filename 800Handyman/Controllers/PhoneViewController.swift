//
//  PhoneViewController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.setGradientBackground(colors: [NAV_GRADIENT_TOP, NAV_GRADIENT_BOTTOM])
    }
    
}
