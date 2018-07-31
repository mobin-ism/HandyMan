//
//  CustomTabBarController.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class CustomTabBarController: UITabBarController {
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.customTabBar = self
        return slideMenu
    }()
    
    public static var customTabBarHeight : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = UIColor.white
        tabBar.isTranslucent = false
        
        CustomTabBarController.customTabBarHeight = tabBar.frame.size.height
        
        let homeController = createController(viewController: HomeViewController(), imageName: "home", selectedImageName: "home")
        let notificationController = createController(viewController: NotificationViewController(), imageName: "notification", selectedImageName: "notification")
        let contactsController = createController(viewController: LoginViewController(), imageName: "users", selectedImageName: "users")
        let phoneController = createController(viewController: ProfileViewController(), imageName: "phone", selectedImageName: "phone")
        let chatController = createController(viewController: ChatViewController(), imageName: "chat", selectedImageName: "chat")
        viewControllers = [homeController, notificationController, contactsController, phoneController, chatController]
        
        // Clearing the Cahced Images
        self.clearCachedImages()
        
        // Modal for changing the Language view
        DispatchQueue.main.async {
            self.present(LanguageSelectViewController(), animated: true, completion: nil)
        }
    }
    
    private func createController(viewController: UIViewController, imageName: String, selectedImageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.tabBarItem.image = UIImage(named: imageName)
        navigationController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        return navigationController
    }
    
    func clearCachedImages(){
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk(onCompletion: nil)
    }
    
}
