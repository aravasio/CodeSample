//
//  RequestManager.swift
//  CodeSample
//
//  Created by Alejandro Ravasio on 11/17/16.
//  Copyright © 2016 Alejandro Ravasio. All rights reserved.
//

import Foundation
import RestEssentials

class RequestManager {
    
    static func requestLogin( username: String, password: String, onSuccess: @escaping (() -> Void), onFailure: @escaping (() -> Void)) {
        
        guard let rest = RestController.make(urlString: Endpoint.AccountServices.baseURL + Endpoint.AccountServices.login) else {
            print("Something Happened")
            return
        }
        
        let token = AppToken.sharedInstance.getToken()
        //TODO: Actually use username/password parameters instead of the Const-Dev ones.
        
        
//        let postData: JSON = ["username": username, "password": password, "appToken": token]
        let postData: JSON = ["username": Endpoint.devUser, "password": Endpoint.devPass, "appToken": token]
        rest.post(postData, at: "post") { result, httpResponse in
            print(result)
            do {
                let json = try result.value()
                print(json["userId"].string ?? "NO-DATA")
                onSuccess()
            } catch {
                print("Error performing POST action: \(error)")
                onFailure()
            }
        }
    }
    
    static func requestAppToken( onCompletion: @escaping ((String) -> Void) ) {
        
        if let rest = RestController.make(urlString: Endpoint.AccountServices.baseURL + Endpoint.AccountServices.getAppToken) {
            let postData: JSON = ["appId": Endpoint.appId]
            rest.post(postData, at: "post") { result, httpResponse in
                do {
                    let json = try result.value()
                    if let token = json["Token"].string {
                        onCompletion( token )
                    }
                } catch {
                    print("Error performing POST action: \(error)")
                }
            }
        }
    }
}
