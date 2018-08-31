//
//  TimeSlotModel.swift
//  800Handyman
//
//  Created by Al Mobin on 15/5/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct TimeSlotResponse : Decodable {
    
    let data : TimeSlotData
}

struct TimeSlotData : Decodable {
    
    let timeSlots : [TimeSlots]
}

struct TimeSlots : Decodable {
    
    let timeRange : String
    let agentId   : Int?
}

class TimeSlotNSObject : NSObject {
    
    private var _timeSlot : String
    private var _agentId  : Int
    
    var timeSlot : String {
        get{
            return _timeSlot
        }
    }
    
    var agentId : Int {
        get{
            return _agentId
        }
    }
    
    init(timeSlot : String, agentId : Int){
        
        self._timeSlot = timeSlot
        self._agentId = agentId
    }
    
}

