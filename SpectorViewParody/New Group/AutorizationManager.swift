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
    
    private struct UsersKeys{
        static let accessTokenKey = "access_token"
        static let tokenTypeKey = "token_type"
        static let refreshTokenKey = "refresh_token"
        static let expiresInKey = "expires_in"
        static let scopeKey = "scope"
        
    }
    
    static private func startAutorizationPagePageView (){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "autorizationController") as! AutorizationPageController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    static func logout (){
        AutorizationManager.cleanUserInfo()
        startAutorizationPagePageView()
    }
    
    static func login(email:String, password:String) -> Promise<User>{
        return Promise {fulfill, reject in
            let params:Parameters = ["password": password, "grant_type": "password","username": email, "client_id": "ios", "client_secret": "qwerty"]
            let header:HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
            Alamofire.request("https://dev.spectorview.com/api/oauth/token", method: .post, parameters:params, headers:header).validate().responseJSON{
                response -> Void in
                switch response.result {
                case .success:
                    let jsonResponse = response.result.value as? [String: Any]
                    let user = User(JSON: jsonResponse!)!
                    Headers.headers.append(other: ["Authorization" : User.token_type! + " " + User.access_token!])
                    AutorizationManager.saveUserInfo()
                    fulfill(user)
                case .failure( _):
                    let error = response.result.error!
                    reject(error)
                    return
                    
                }
                }
        }
    }
    
    static func saveUserInfo (){
        let defaults = UserDefaults.standard
        defaults.set(User.access_token, forKey: UsersKeys.accessTokenKey)
        defaults.set(User.token_type, forKey: UsersKeys.tokenTypeKey)
        defaults.set(User.refresh_token, forKey: UsersKeys.refreshTokenKey)
        defaults.set(User.expires_in, forKey: UsersKeys.expiresInKey)
        defaults.set(User.scope, forKey: UsersKeys.scopeKey)
    }
    
    static func cleanUserInfo (){
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: UsersKeys.accessTokenKey)
        defaults.set(nil, forKey: UsersKeys.tokenTypeKey)
        defaults.set(nil, forKey: UsersKeys.refreshTokenKey)
        defaults.set(nil, forKey: UsersKeys.expiresInKey)
        defaults.set(nil, forKey: UsersKeys.scopeKey)
    }
    
    static func getLocalUserInfo() -> Bool {
        let defaults = UserDefaults.standard
        
        if let access_token = defaults.string(forKey: UsersKeys.accessTokenKey) {
            User.access_token = access_token
        }else {
            return false
        }
        //User.access_token = "6084e819-c210-4f49-a3e7-0ea58d1db53d"
        User.token_type = defaults.string(forKey: UsersKeys.tokenTypeKey)
        User.refresh_token = defaults.string(forKey: UsersKeys.refreshTokenKey)
        User.expires_in = defaults.string(forKey: UsersKeys.expiresInKey)
        User.scope = defaults.string(forKey: UsersKeys.scopeKey)
        Headers.headers.append(other: ["Authorization" : User.token_type! + " " + User.access_token!])
        return true
        
    }
    
    
}
