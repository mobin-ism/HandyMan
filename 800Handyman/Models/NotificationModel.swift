//
//  NotificationModel.swift
//  800Handyman
//
//  Created by Al Mobin on 3/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct NotificationModel : Decodable {
    let data : NotificationData
}

struct NotificationData : Decodable {
    let notifications : [Notifications]
}

struct Notifications : Decodable {
    let notificationId : Int
    let serviceRequestMasterId : Int
    let title : String
    let message : String
    let lastModified : Int
}

class NotificationNSObject : NSObject {
    
    private var _notificationId : Int
    private var _title : String
    private var _message : String
    private var _date : String
    private var _time : String
    
    
    var notificationId : Int {
        get{
            return _notificationId
        }
    }
    
    var title : String {
        get{
            return _title
        }
    }
    
    var message : String {
        get{
            return _message
        }
    }
    
    var date : String {
        get{
            return _date
        }
    }
    
    var time : String {
        get{
            return _time
        }
    }
    
    init(notificationId : Int, title : String, message : String, date : String, time : String){
        
        self._notificationId = notificationId
        self._title = title
        self._message = message
        self._date = date
        self._time = time
    }
    
}
