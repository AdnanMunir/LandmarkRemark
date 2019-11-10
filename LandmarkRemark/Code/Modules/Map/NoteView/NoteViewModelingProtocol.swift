//
//  NoteViewModeling.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 09/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

protocol NoteViewModeling {
    /**
     Call this function to add User Note in Provider(Firebase , Server, DB etc)
     */
    func addNotes(title : String , notes : String)
    
    /**
     Callback to show error on view
     */
    typealias errorAlias = (String) -> ()
    var showError : errorAlias? {get set}
    
    /**
     Callback to handle Activity Indicators when to show and hide them
     */
    typealias handleIndicator = () -> ()
    var startIndicator : handleIndicator? {get set}
    var stopIndicator : handleIndicator? {get set}
    
    /**
     Callback to reload view after some decision
     */
    typealias reloadViewAias = () -> ()
    var reloadMapView : reloadViewAias?{get set}
}
