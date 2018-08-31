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
import Firebase
import FirebaseMessaging
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
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
        
        // push notification settings
        
        let notificationTypes : UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let notificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerForRemoteNotifications()
        application.registerUserNotificationSettings(notificationSettings)
        
        // firebase token id
        if let firebaseToken = InstanceID.instanceID().token() {
            UserDefaults.standard.set(firebaseToken, forKey: FIREBASE_TOKEN)
            print(firebaseToken)
        }
        else {
            UserDefaults.standard.set("", forKey: FIREBASE_TOKEN)
            print("No token generated")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
    }
    
    @objc func tokenRefreshNotification(notification: NSNotification) {
        //    NOTE: It can be nil here
        if let token = InstanceID.instanceID().token() {
            UserDefaults.standard.set(token, forKey: FIREBASE_TOKEN)
            print("InstanceID token: \(token)")
        }
    }
}

