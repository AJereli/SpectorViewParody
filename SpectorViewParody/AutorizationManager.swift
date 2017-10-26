//
//  Autorization.swift
//  SpectorViewParody
//
//  Created by User on 23/10/2017.
//  Copyright © 2017 User. All rights reserved.
//
import Alamofire
import PromiseKit
import Foundation


class AutorizationManager {
    
    static private func startAutorizationPagePageView (){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "autorizationPage") as! AutorizationPageController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    static func logout (){
        User.cleanUserInfo()
        startAutorizationPagePageView()
    }
    
    static func login(email:String, password:String) -> Promise<User>{
        return Promise {fulfill, reject in
            let params:Parameters = ["password": password, "grant_type": "password","username": email, "client_id": "ios", "client_secret": "qwerty"]
            let header:HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
            Alamofire.request("https://dev.spectorview.com/api/oauth/token", method: .post, parameters:params, headers:header).responseJSON{
                response -> Void in
                switch response.result {
                case .success:
                    let jsonResponse = response.result.value as? [String: Any]
                    let user = User(JSON: jsonResponse!)!
                    Headers.headers.append(other: ["Authorization" : User.token_type! + " " + User.access_token!])
                    User.saveUserInfo()
                    fulfill(user)
                case .failure(let error):
                    
                    let error = response.result.error!
                    reject(error)
                    return
                    
                }
                }
        }
        
        
    }
}
