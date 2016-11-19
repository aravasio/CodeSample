//
//  Login.swift
//  CodeSample
//
//  Created by Alejandro Ravasio on 11/17/16.
//  Copyright © 2016 Alejandro Ravasio. All rights reserved.
//

import Foundation
import RestEssentials

class Login {
    var user : String!
    var password : String!
    
    private init() {
        user = ""
        password = ""
    }
    
    init(_user: String, _password: String) {
        user = _user
        password = _password
    }
    
    func make( onSucess: @escaping (()->Void), onFailure: @escaping (()->Void)) {
        RequestManager.requestLogin(username: user, password: password, onSuccess: onSucess, onFailure: onFailure)
    }
}
