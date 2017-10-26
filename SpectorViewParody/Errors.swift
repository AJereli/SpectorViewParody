//
//  Errors.swift
//  SpectorViewParody
//
//  Created by User on 25/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import ObjectMapper

class UnauthorizedError: Error, ImmutableMappable{
   
    
    let error:String
    let error_description:String
    
    required init(map: Map) throws {
        error   = try map.value("error")
        error_description = try map.value("error_description")
    }
    func mapping(map: Map) {
        error   >>> map["error"]
        error_description >>> map["error_description"]
    }
}
