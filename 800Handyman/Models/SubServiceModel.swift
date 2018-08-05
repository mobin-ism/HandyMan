//
//  SubServiceModel.swift
//  800Handyman
//
//  Created by Al Mobin on 15/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct subService : Decodable {
    
    let data : DataForSubService
}

struct DataForSubService : Decodable {
    
    let serviceRequest : serviceRequest
}
struct serviceRequest : Decodable {
    
    let serviceRequestMasterId : Int
    let status                 : String
    let services : [servicesForSubservice]
    let location : locationForServices
    let createdAt : Int
    let timeslot : ServiceTimeSlot
    let completedByAgentAt : Int
}

struct servicesForSubservice : Decodable {
    
    let serviceRequestDetailId : Int
    let title : String
    let description : String
    let serviceTitle : String
    let serviceIcon : String
    let serviceParentIcon : String
    let serviceParentTitle : String
    let images : [String]
    let thumbnails : [String]
    let serviceRate : String
    let note : String
}

struct locationForServices : Decodable {
    let areaName : String
    let addressName : String
    let street : String
    let apartmentNo : String
}

struct ServiceTimeSlot : Decodable {
    let date : Int
    let time : String
}


class GetServicesListObject: NSObject {
    
    private var _serviceRequestDetailId   : Int
    private var _serviceParentIcon : String
    private var _serviceParentTitle : String
    private var _serviceTitle : String
    private var _serviceRate : String
    private var _thumbnails : [String]
    
    
    var serviceRequestDetailId : Int {
        get{
            return _serviceRequestDetailId
        }
    }
    var serviceParentIcon : String {
        get{
            return _serviceParentIcon
        }
    }
    var serviceParentTitle : String {
        get{
            return _serviceParentTitle
        }
    }
    var serviceTitle : String {
        get{
            return _serviceTitle
        }
    }
    var serviceRate : String {
        get{
            return _serviceRate
        }
    }
    var thumbnails : [String] {
        get{
            return _thumbnails
        }
    }
    
    init(serviceRequestDetailId : Int, serviceParentIcon : String, serviceParentTitle : String, serviceTitle : String, serviceRate : String, thumbnails : [String]) {
        
        self._serviceRequestDetailId = serviceRequestDetailId
        self._serviceParentIcon = serviceParentIcon
        self._serviceParentTitle = serviceParentTitle
        self._serviceTitle = serviceTitle
        self._serviceRate = serviceRate
        self._thumbnails = thumbnails
    }
}




