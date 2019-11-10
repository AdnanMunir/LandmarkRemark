//
//  LoginRequest.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

struct LoginRequest {
    var email : String
    var password : String
    
    init(email : String = "" , password : String = "") {
        self.email = email
        self.password = password
    }
}
