//
//  MoviesManager.swift
//  SpectorViewParody
//
//  Created by User on 26/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class MoviesManager {
    
    var movies:[Movie] = []
    static let getInstance = MoviesManager()
    
    fileprivate init() {}
    
    func getAllMovie () -> Promise<Movie>{
        return ApiManager<Movie>().get("https://dev.spectorview.com/api/v2/movie/all")
    }
}



