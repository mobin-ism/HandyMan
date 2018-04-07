//
//  CustomTabBarController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = UIColor.white
        tabBar.isTranslucent = false
        
        let homeController = createController(viewController: HomeViewController(), imageName: "home", selectedImageName: "home")
        let notificationController = createController(viewController: NotificationViewController(), imageName: "notification", selectedImageName: "notification")
        let contactsController = createController(viewController: ContactsViewController(), imageName: "users", selectedImageName: "users")
        let phoneController = createController(viewController: PhoneViewController(), imageName: "phone", selectedImageName: "phone")
        let chatController = createController(viewController: ChatViewController(), imageName: "chat", selectedImageName: "chat")
        viewControllers = [homeController, notificationController, contactsController, phoneController, chatController]
    }
    
    private func createController(viewController: UIViewController, imageName: String, selectedImageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.tabBarItem.image = UIImage(named: imageName)
        navigationController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        return navigationController
    }
    
}
