//
//  Token.swift
//  CodeSample
//
//  Created by Alejandro Ravasio on 11/17/16.
//  Copyright © 2016 Alejandro Ravasio. All rights reserved.
//

import Foundation

class AppToken {
    
    static let sharedInstance = AppToken()
    fileprivate var token: String
    
    fileprivate init() {
        token = ""
    }
    
    func prepareToken() {
        if token.isEmpty {
            RequestManager.requestAppToken( onCompletion: { token in
                self.token = token
            })
        }
    }
    
    func getToken() -> String {
        return token
    }
}
