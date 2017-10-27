//
//  Thumbnail.swift
//  SpectorViewParody
//
//  Created by User on 26/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import ObjectMapper


class Thumbnail : Mappable{
    
    var id:Int?
    var fileName:String?
    var url:String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        fileName <- map["fileName"]
        url <- map["url"]

    }
    
}
