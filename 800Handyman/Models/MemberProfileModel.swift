//
//  MemberProfileModel.swift
//  800Handyman
//
//  Created by Al Mobin on 4/8/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct MemberProfile : Decodable {
    let data : IndividualMember
}

struct IndividualMember : Decodable {
    let member : IndividualMemberDetails
}

struct IndividualMemberDetails : Decodable {
    let name : String
    let totalSpent : Int
    let loyaltyPoint : Int
    let totalJob : Int
    let completedJob : Int
    let runningJob : Int
    let cancelledJob : Int
    let cards : [String]
    let email : String
    let phoneNumber : String
    
}

class ProfileNSObject : NSObject {
    
    private var _name : String
    private var _totalSpent : Int
    private var _loyaltyPoint : Int
    private var _completedJob : Int
    private var _runningJob : Int
    private var _cancelledJob : Int
    
    var name : String {
        get{
            return _name
        }
    }
    
    var totalSpent : Int {
        get{
            return _totalSpent
        }
    }
    
    var loyaltyPoint : Int {
        get{
            return _loyaltyPoint
        }
    }
    
    var completedJob : Int {
        get{
            return _completedJob
        }
    }
    
    var runningJob : Int {
        get{
            return _runningJob
        }
    }
    
    var cancelledJob : Int {
        get{
            return _cancelledJob
        }
    }
    
    init(name : String, totalSpent : Int, loyaltyPoint : Int, completedJob : Int, runningJob : Int, cancelledJob : Int){
        
        self._name = name
        self._totalSpent = totalSpent
        self._loyaltyPoint = loyaltyPoint
        self._completedJob = completedJob
        self._runningJob = runningJob
        self._cancelledJob = cancelledJob
    }
    
}
