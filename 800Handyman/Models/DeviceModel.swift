//
//  RegisterDeviceModel.swift
//  800Handyman
//
//  Created by Creativeitem on 16/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct DeviceResponse : Decodable {
    let message : String
    let data : DeviceData
}

struct DeviceData : Decodable {

    let member : DeviceMember
}

struct DeviceMember : Decodable {

    let memberId : Int
    let deviceId : String
}

