//
//  User.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 07/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation


/**
 Represents ths Current Logged In User
 */
class CurrentUser:NSObject {
    static var sharedInstance = CurrentUser()
    private override init() {
        self.email = ""
        self.username = ""
    }
    
    var email : String
    var username : String
    
}
