//
//  JobListModel.swift
//  800Handyman
//
//  Created by Creativeitem on 22/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct jobListResponse : Decodable {
    
    let data : jobsData
    
}

struct jobsData : Decodable {
    
    let jobs : [jobs]
}

struct jobs : Decodable {
    
    let serviceRequestMasterId : Int
    let status : String
    let createdAt : Int
    let services : [jobsServices]
    let timeslot : timeSchedule?
}

struct jobsServices : Decodable {
    
    let serviceId : Int
    let title : String
    let description : String
    let serviceParentIcon : String
    let serviceRate : String
}

struct timeSchedule : Decodable {
    
    let date : Int?
}

class JobNSObject: NSObject {
    
    private var _serviceRequestMasterId   : Int
    private var _serviceId   : Int
    private var _title : String
    private var _serviceDescription : String
    private var _totalAmount : String
    private var _createdAt : String
    private var _scheduleTime : String
    private var _status : String
    private var _parentIcon : String
    
    var serviceRequestMasterId : Int {
        get{
            return _serviceRequestMasterId
        }
    }
    var serviceId : Int {
        get{
            return _serviceId
        }
    }
    var title : String {
        
        get {
            return _title
        }
    }
    var serviceDescription : String {
        
        get {
            return _serviceDescription
        }
    }
    var totalAmount : String {
        
        get {
            return _totalAmount
        }
    }
    var createdAt : String {
        
        get {
            return _createdAt
        }
    }
    var scheduleTime : String {
        
        get {
            return _scheduleTime
        }
    }
    
    var status : String {
        
        get {
            return _status
        }
    }
    
    var parentIcon : String {
        
        get {
            return _parentIcon
        }
    }
    
    init(serviceRequestMasterId : Int, serviceId : Int, title : String, serviceDescription : String, totalAmount : String, createdAt : String, status : String, parentIcon : String, scheduleTime : String) {
        
        self._serviceRequestMasterId = serviceRequestMasterId
        self._serviceId = serviceId
        self._title = title
        self._serviceDescription = serviceDescription
        self._totalAmount = totalAmount
        self._createdAt = createdAt
        self._scheduleTime = scheduleTime
        self._status = status
        self._parentIcon = parentIcon
    }
}
