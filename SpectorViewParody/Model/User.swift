
//
//  User.swift
//  SpectorViewParody
//
//  Created by User on 23/10/2017.
//  Copyright © 2017 User. All rights reserved.
//
import Foundation
import ObjectMapper

import PromiseKit
import Alamofire

struct UserMetaData : Mappable{
    
    struct User : Mappable{
        var id:Int?
        var email:String?
        var role:String?
        var plan:Plan?
        var planStartedTs:Date?
        var planEndedTs:Date?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            email <- map["email"]
            role <- map["role"]
            plan <- map["plan"]
            planStartedTs <- (map["planStartedTs"], DateTransform())
            planEndedTs <- (map["planEndedTs"], DateTransform())

        }
        
    }
    struct PlanCapacity : Mappable{
        var moviesAmount:Int?
        var devicesAmount:Int?
        var storageLimit:Int?
        
         init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            moviesAmount <- map["moviesAmount"]
            devicesAmount <- map["devicesAmount"]
            storageLimit <- map["storageLimit"]
            
        }
    }
    struct Plan : Mappable{
        var id:Int?
        var moviesAmount:Int?
        var devicesAmount:Int?
        var storageLimit:Int?
        var name:String?
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            moviesAmount <- map["moviesAmount"]
            devicesAmount <- map["devicesAmount"]
            storageLimit <- map["storageLimit"]
            name <- map["name"]
            
        }
       
    }
    
    var user:UserMetaData.User?
    var planCapacity:PlanCapacity?

    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        self.user <- map["user"]
        self.planCapacity <- map["planCapacity"]
       
        
    }

}



class User : Mappable{
    
    static var access_token:String?
    static var token_type:String?
    static var refresh_token:String?
    static var expires_in:String?
    static var scope:String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        User.access_token <- map["access_token"]
        User.token_type <- map["token_type"]
        User.refresh_token <- map["refresh_token"]
        User.expires_in <- map["expires_in"]
        User.scope <- map["scope"]
        
    }
    
}

