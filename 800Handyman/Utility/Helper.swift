//
//  Helper.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 3/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit
import Localize_Swift
class Helper {
    
    public static var isIphoneX: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return true
            default:
                return false
            }
        }
        return false
    }
    
    public static var selectedLanguage : String {
        return UserDefaults.standard.value(forKey: SELECTED_LANGUAGE) as! String
    }
    
    public static func getDateAndTime(timeInterval : Int, dateFormat : String) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval / 1000))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat // MMM dd YYYY hh:mm a
        dayTimePeriodFormatter.timeZone = TimeZone(identifier: TIME_ZONE)
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
    }
    
    static func Exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

class Alert: UIViewController {
    public static func logOutConfirmationAlert(on vc : UIViewController) {
        
        let alert = UIAlertController(title: "Are you sure?".localized(), message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Logout".localized(), style: .default, handler: { action in
            //run your function here
            vc.navigationController?.tabBarController?.selectedIndex = 0
            UserDefaults.standard.set(false, forKey: IS_LOGGED_IN)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .default, handler: { action in
            //run your function here
            
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}

