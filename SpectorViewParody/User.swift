
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
    
    private struct UsersKeys{
        static let accessTokenKey = "access_token"
        static let tokenTypeKey = "token_type"
        static let refreshTokenKey = "refresh_token"
        static let expiresInKey = "expires_in"
        static let scopeKey = "scope"

    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        User.access_token <- map["access_token"]
        User.token_type <- map["token_type"]
        User.refresh_token <- map["refresh_token"]
        User.expires_in <- map["expires_in"]
        User.scope <- map["scope"]
        
    }
    static func saveUserInfo (){
        let defaults = UserDefaults.standard
        defaults.set(User.access_token, forKey: UsersKeys.accessTokenKey)
        defaults.set(User.token_type, forKey: UsersKeys.tokenTypeKey)
        defaults.set(User.refresh_token, forKey: UsersKeys.refreshTokenKey)
        defaults.set(User.expires_in, forKey: UsersKeys.expiresInKey)
        defaults.set(User.scope, forKey: UsersKeys.scopeKey)
    }
    
    static func cleanUserInfo (){
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: UsersKeys.accessTokenKey)
        defaults.set(nil, forKey: UsersKeys.tokenTypeKey)
        defaults.set(nil, forKey: UsersKeys.refreshTokenKey)
        defaults.set(nil, forKey: UsersKeys.expiresInKey)
        defaults.set(nil, forKey: UsersKeys.scopeKey)
    }
    
    static func getLocalUserInfo() -> Bool {
        let defaults = UserDefaults.standard

        if let access_token = defaults.string(forKey: UsersKeys.accessTokenKey) {
            User.access_token = access_token
        }else {
            return false
        }
        User.token_type = defaults.string(forKey: UsersKeys.tokenTypeKey)
        User.refresh_token = defaults.string(forKey: UsersKeys.refreshTokenKey)
        User.expires_in = defaults.string(forKey: UsersKeys.expiresInKey)
        User.scope = defaults.string(forKey: UsersKeys.scopeKey)
        Headers.headers.append(other: ["Authorization" : token_type! + " " + access_token!])
        return true
        
    }
    
    static func getUserMetaData () -> Promise<UserMetaData>{
        return ApiManager<UserMetaData>().get("https://dev.spectorview.com/api/v2/meta/my")
    }
    
    
    
}

