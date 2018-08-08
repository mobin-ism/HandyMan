//
//  AppDelegate.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CustomTabBarController()
        
        
        window?.makeKeyAndVisible()
        
        GMSServices.provideAPIKey(GOOGLE_MAP_API_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_MAP_API_KEY)
        
        // registering the device id
        UserDefaults.standard.set(UIDevice.current.identifierForVendor!.uuidString, forKey: DEVICE_ID)
        
        // initializing the Service Request Master Id
        UserDefaults.standard.set(0, forKey: SERVICE_REQUEST_MASTER_ID)
    
        // initializing the Is Another Service Request
        UserDefaults.standard.set(false, forKey: IS_ANOTHER_SERVICE_REQUEST)
        
        //initialiizng login status to false
        //UserDefaults.standard.set(false, forKey: IS_LOGGED_IN)
        
        // initializing show thank you message to false
        UserDefaults.standard.set(false, forKey: SHOW_THANK_YOU_MESSAGE)
        return true
    }
}

