//
//  ServiceModel.swift
//  800Handyman
//
//  Created by Al Mobin on 12/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct DataResponse : Decodable {
    let code : Int
    let message: String
    let isSuccess: Bool
    let data : ServiceData
}

struct ServiceData: Decodable {
    let services: [Services]
    let banners : [String]
}

struct Services : Decodable {
    
    let serviceId : Int
    let title : String
    let smallIconOne : String
    let child: [Child]
}

struct Child : Decodable {
    
    let serviceId : Int
    let title : String
    let subTitle : String?
    let serviceRate : String
    let requiredHours : String?
}

