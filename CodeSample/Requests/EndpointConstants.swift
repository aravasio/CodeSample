//
//  EndpointConstants.swift
//  CodeSample
//
//  Created by Alejandro Ravasio on 11/17/16.
//  Copyright © 2016 Alejandro Ravasio. All rights reserved.
//

import Foundation

struct Endpoint {
    
    static let appId = "1234"
    static let devUser = "user"
    static let devPass = "pass"
    
    // MARK: AccountServices
    struct AccountServices {
        static let baseURL = "http://some.url.com/services/"
        
        static let getAppToken = "/GetToken"
        static let login = "/Login"
    }
}
