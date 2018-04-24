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
}

struct servicesForSubservice : Decodable {
    
    let title : String
    let description : String
    let serviceTitle : String
    let serviceIcon : String
}
