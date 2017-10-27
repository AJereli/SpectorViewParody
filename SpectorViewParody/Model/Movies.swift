//
//  Movies.swift
//  SpectorViewParody
//
//  Created by User on 26/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import ObjectMapper


class Movie:Mappable{
    
    var video:VideoInfo?
    var thumbnail:Thumbnail?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        video <- map["video"]
        thumbnail <- map["thumbnail"]
    }
    
}

