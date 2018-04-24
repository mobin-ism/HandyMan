//
//  LoginAuthorizationModel.swift
//  800Handyman
//
//  Created by Creativeitem on 19/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import Foundation

struct TokenValidity : Decodable {
    
    let isSuccess : Bool
}

struct TokenReponse : Decodable {
    
    let data : GetToken
}

struct GetToken : Decodable {
    
    let token : String
}

struct LoginResponse : Decodable {
    
    let data : MemberData
    let isSuccess : Bool
}

struct MemberData : Decodable {
    
    let member : MemberDetails
}

struct MemberDetails : Decodable {
    
    let email       : String
    let memberId    : Int
    let name        : String
    let phoneNumber : String
}


struct RegistrationValidity : Decodable {
    
    let isSuccess : Bool
}
