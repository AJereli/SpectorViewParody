//
//  DeviceInfo.swift
//  SpectorViewParody
//
//  Created by User on 25/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import ObjectMapper

class DeviceInfo: ImmutableMappable {
    let id:Int
    //let ownerId:Int
    let hash:String
    let title:String
    let osVersion:String
    let model:String
    let remoteAddress:String
    
    
    required init(map: Map) throws {
        id = try map.value("id")
        //ownerId = try map.value("ownerId")
        
        hash = try map.value("hash")
        title = try map.value("title")
        osVersion = try map.value("osVersion")
        model = try map.value("model")
        remoteAddress = try map.value("remoteAddress")
        
    }
    func mapping(map: Map) {
        id >>> map["id"]
        //ownerId >>> map["ownerId"]
        hash >>> map["hash"]
        title >>> map["title"]
        osVersion >>> map["osVersion"]
        model >>> map["model"]
        remoteAddress >>> map["remoteAddress"]
    }
    
   
}

