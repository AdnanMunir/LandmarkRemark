//
//  NotesVM.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 08/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation



final class NotesTableViewModel: NotesTableModeling {
    var isShowNoNoteAvailableCell = false
    
    
    private var notes : [Note]?
    
    
    func getSections() -> Int {
        return 1
    }
    
    
    func getRows() -> Int {
        if let notes = notes , notes.count > 0 {
            isShowNoNoteAvailableCell = false
            return notes.count
        }
        isShowNoNoteAvailableCell = true
        return 1
    }
    
    func getNote(at index : Int) -> Note {
        if let notes = notes {
            return notes[index]
        }
        
        return Note()
    }
    
    func setNotes(notes: [Note]) {
        self.notes = notes
    }
    
    
}
