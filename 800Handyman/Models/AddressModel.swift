//
//  AreaModel.swift
//  800Handyman
//
//  Created by Creativeitem on 17/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct AddressResponse : Decodable {
    
    let data : AreaJsonResponse
}

struct AreaJsonResponse : Decodable {
    
    let areas : [AreaResponse]
}

struct AreaResponse : Decodable {
    
    let areaId : Int
    let name : String
}

class AreaNSObject : NSObject {
    
    private var _areaId   : Int
    private var _areaName : String
    
    var areaId : Int {
        get{
            return _areaId
        }
    }
    var areaName : String {
        
        get {
            return _areaName
        }
    }
    
    init(areaId : Int, areaName : String){
        
        self._areaId = areaId
        self._areaName = areaName
    }
    
}

