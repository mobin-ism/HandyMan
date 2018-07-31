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
}

class TimeSlotNSObject : NSObject {
    
    private var _timeSlot : String
    
    var timeSlot : String {
        get{
            return _timeSlot
        }
    }
    
    init(timeSlot : String){
        
        self._timeSlot = timeSlot
    }
    
}

