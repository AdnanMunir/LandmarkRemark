//
//  NotesProtocol.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 07/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

protocol AddNotesProtocol {
    /**
     Call this function to Add Notes in any of the Provider(Firbase , server , DB etc)
     */
    func addNotes(request : NotesRequest , completion : @escaping (Result<APIResponse>) -> Void)
    
}

protocol GetNotesProtocol {
    /**
     Call this function to get all notes of all Users from any of the Provider(Firbase , server , DB etc)
     */
    func getAllNotes( completion : @escaping (Result<[Note]>) -> Void)
    
    /**
     Call this function to Get Current User All Notes from any of the Provider(Firbase , server , DB etc)
     */
    func getMyNotes( completion : @escaping (Result<[Note]>) -> Void)
}
