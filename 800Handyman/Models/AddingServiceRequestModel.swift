//
//  AddingServiceRequestModel.swift
//  800Handyman
//
//  Created by Creativeitem on 16/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct AnotherServiceRequestResponse : Decodable {
    
    let data : ServiceRequestResponseData
    let message : String
}

struct ServiceRequestResponseData : Decodable {
    
    let serviceRequest : ServiceRequestResponse
}

struct ServiceRequestResponse : Decodable {
    
    let serviceRequestDetailId : Int
    let serviceRequestMasterId : Int
    let status                 : String
    let currentStatus          : String
}
