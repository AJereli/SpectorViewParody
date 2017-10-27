//
//  DeviceManager.swift
//  SpectorViewParody
//
//  Created by User on 26/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
class DeviceManager {

    static let XDeviceHash:String = "testDevice2ForOwner1"
    static var deviceInfo:DeviceInfo?
    static func getCurrentDevice () -> Promise<DeviceInfo>{
        //UIDevice.current.identifierForVendor!.uuidString
        Headers.headers.append(other: ["X-Device-Hash" : XDeviceHash])
        return ApiManager<DeviceInfo>().get("https://dev.spectorview.com/api/v2/device/device/me").then{ result -> Promise<DeviceInfo> in
            deviceInfo = result
            return Promise{ fulfill, reject in
                fulfill(result)
            }
        }
    }
    
}
