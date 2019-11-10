//
//  SignupRequest.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

struct SignupRequest {
    var email : String
    var password : String
    var username : String
    
    init(email : String = "" , password : String = "" , username : String = "" ) {
        self.email = email
        self.password = password
        self.username = username
    }
}
