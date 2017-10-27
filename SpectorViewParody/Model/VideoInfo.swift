//
//  VideoInfo.swift
//  SpectorViewParody
//
//  Created by User on 26/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import ObjectMapper


class VideoInfo: Mappable {
    
    var id:Int?
    var fileName:String?
    var fileSize:Int?
    var fileType:String?
    var createdTs:Int?
    var temp:Bool?
    var url:String?
    var mediaType:String?
    var md5:String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        fileName <- map["fileName"]
        fileSize <- map["fileSize"]
        fileType <- map["fileType"]
        createdTs <- map["createdTs"]
        temp <- map["temp"]
        url <- map["url"]
        mediaType <- map["mediaType"]
        md5 <- map["md5"]

    }
    
    
}
