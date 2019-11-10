//
//  NotesTableModeling.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 09/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

protocol NotesTableModeling {
    /**
     Gets number of Notes to show in TableView
     */
    func getRows() -> Int
    
    /**
     Gets Number of sections to show in Tableview
     */
    func getSections() -> Int
    
    /**
     Gets specific Note at index
     */
    func getNote(at index : Int) -> Note
    
    /**
     Stores all notes coming from MapVM in NotesTableVM to show 
     */
    func setNotes(notes : [Note])
    
}
