//
//  ChatModel.swift
//  800Handyman
//
//  Created by Creativeitem on 24/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct ChatResponse : Decodable {
    
    let data : ChatData
}

struct ChatData : Decodable {
    
    let chats : [ChatHistory]
}

struct ChatHistory : Decodable {
    
    let isMe : Bool
    let isSeen : Bool
    let message : String
    let time : Int
}

struct ChatHistoryStatus : Decodable {
    
    let isSuccess : Bool
}


class chatNSObject : NSObject {
    
    private var _message : String
    private var _isMe : Bool
    private var _isSeen : Bool
    private var _time : String
    
    var message : String {
        get{
            return _message
        }
    }
    var isMe : Bool {
        
        get {
            return _isMe
        }
    }
    var isSeen : Bool {
        
        get {
            return _isSeen
        }
    }
    var time : String {
        
        get {
            return _time
        }
    }
    
    init(message : String, isMe : Bool, isSeen : Bool, time : String){
        
        self._message = message
        self._isMe    = isMe
        self._isSeen  = isSeen
        self._time     = time
    }
    
}
