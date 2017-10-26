//
//  ApiManager.swift
//  SpectorViewParody
//
//  Created by User on 24/10/2017.
//  Copyright © 2017 User. All rights reserved.
//
import Foundation
import Alamofire
import PromiseKit
import ObjectMapper

struct Headers {
    static var headers:HTTPHeaders = ["Content-Type": "application/json"]
}

extension Dictionary {
    mutating func append(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

class ApiManager<O:Mappable> {
    
    func get  (_ stringUrl:String, parameters:Parameters? = nil, method:HTTPMethod = .get) -> Promise<O>{
        return Promise{ fulfill, reject in
            Alamofire.request(stringUrl, method: method, parameters:parameters, encoding: JSONEncoding.default, headers:Headers.headers).validate().responseJSON{
                responseJson -> Void in
                guard responseJson.result.isSuccess else {
                    print("Error while fetching remote rooms: \(responseJson.result.error!)")
                    reject(responseJson.result.error!)
                    return
                }
                let jsonResponse = responseJson.result.value as? [String: Any]
                fulfill(O(JSON: jsonResponse!)!)
                
            }

        }   
        
        
    }
    
    
}
