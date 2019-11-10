//
//  LoginModelingProtocol.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 09/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

protocol LoginModeling {
    /**
     Call this function to login User
     */
    func login(with email :String , password : String)
    
    /**
     Indicates that View is about to appear
     */
    func viewWillAppear()
    
    /**
     Callback to handle Activity Indicators when to show and hide them
     */
    typealias handleIndicator = () -> ()
    var startIndicator : handleIndicator? {get set}
    var stopIndicator : handleIndicator? {get set}
    
    /**
     Callback to handle errors and show them on view
     */
    typealias errorAlias = (String) -> ()
    var showError : errorAlias? {get set}
    
    /**
     Callback to handle flow of the view
     */
    typealias updateFlowAlias = () -> ()
    var moveToMapView : updateFlowAlias?{get set}
    
    /**
     Callback to reset view after some decision
     */
    typealias resetViewAlias = () -> ()
    var resetView : resetViewAlias?{get set}
    
}
