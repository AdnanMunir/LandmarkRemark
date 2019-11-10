//
//  MapModelingProtocol.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 09/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

protocol MapModeling {
    
    /**
     Call this function to Logout User
     */
    func logout()
    
    /**
     This informs that view has loaded, perform the tasks accordingly
     */
    func viewDidLoad()
    
    /**
     Returns the NoteViewVM when NoteView is about to appear
     */
    func getNotesVM() -> NoteViewViewModel
    
    /**
     Reloads the map for upddates
     */
    func reloadMap()
    
    /**
     Call this function to view notes according to type ALL,MINE
     */
    func changeNotesType(type : Int)
    
    /**
     Call this function to get User Title to show on View
     */
    func getUserTitle() -> String
    
    /**
     Call this function to Filter notes on the basis of  search query
     */
    func filterNotes(searchText : String , completion : ([Note]) -> Void)
    
    /**
     Call this function to search notes according to type USERNAME,NOTES
     */
    func changeSearchType(type : Int)
    
    /**
     Variable To Get,Set Notes Type
     */
    var notesType : NotesType {get set}
    
    /**
     Variable To Get,Set Search Type
     */
    var searchType : SearchType {get set}
    
    /**
     Callback to update Flow of the View
     */
    typealias updateFlowAlias = () -> ()
    var moveToLogin : updateFlowAlias?{get set}
    
    /**
     Callback to Configure View
     */
    typealias configureViewAlias = () -> ()
    var initializeView : configureViewAlias?{get set}
    
    /**
     Callback to show errors
     */
    typealias errorAlias = (String) -> ()
    var showError : errorAlias? {get set}
    
    /**
     Callback to add annotations on map
     */
    typealias addAnnotationAlias = (Note) -> ()
    var addAnnotation : addAnnotationAlias? {get set}
    
    /**
     Callback to remove annotations
     */
    typealias removeAnnotationAlias = () -> ()
    var removeAllAnnotations : removeAnnotationAlias? {get set}
    
    /**
     Callback to handle Activity Indicators when to show and hide them
     */
    typealias handleIndicator = () -> ()
    var startIndicator : handleIndicator? {get set}
    var stopIndicator : handleIndicator? {get set}
    
    
}
