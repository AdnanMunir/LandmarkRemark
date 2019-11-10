//
//  SignupModeling.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 09/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation


protocol SignUpModeling {
    /**
     Call this function to Signup User
     */
    func signUp(with email :String ,username : String , password : String)
    
    /**
     Callback to handle Activity Indicators when to show and hide them
     */
    typealias handleIndicator = () -> ()
    var startIndicator : handleIndicator? {get set}
    var stopIndicator : handleIndicator? {get set}
    
    /**
     Callback to handle errors and show them on view
     */
    typealias error = (String) -> ()
    var showError : error? {get set}
    
    /**
     Callback to handle flow of the view
     */
    typealias updateFlow = (String) -> ()
    var moveBackToLogin : updateFlow?{get set}
    
}
