//
//  UserManager.swift
//  SpectorViewParody
//
//  Created by User on 30/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import PromiseKit


class UserManager{
    
    static func getUserMetaData () -> Promise<UserMetaData>{
        return ApiManager<UserMetaData>().get("https://dev.spectorview.com/api/v2/meta/my")
    }
    
}
