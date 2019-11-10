//
//  NotesService.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 07/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct NotesService : AddNotesProtocol,GetNotesProtocol {
    func getMyNotes(completion: @escaping (Result<[Note]>) -> Void) {
        FIRInterface.sharedInstance.getMyNotes { (result) in
            switch result {
            case .success(let docs):
                var notes = [Note]()
                if let docs = docs {
                    notes = self.parseNotes(snapshot: docs)
                }
                completion(.success(notes))
                
                break
            case .failure(let reason):
                completion(.failure(reason))
            }
        }
    }
    
    func getAllNotes(completion: @escaping (Result<[Note]>) -> Void) {
        FIRInterface.sharedInstance.getAllNotes { (result) in
            switch result {
            case .success(let docs):
                var notes = [Note]()
                if let docs = docs {
                    notes = self.parseNotes(snapshot: docs)
                }
                completion(.success(notes))
                
                break
            case .failure(let reason):
                completion(.failure(reason))
            }
        }
    }
    
    private func parseNotes(snapshot : [QueryDocumentSnapshot]) -> [Note] {
        var notes = [Note]()
        for document in snapshot {
            var note = Note()
            note.title = document.data()["title"] as? String
            note.note = document.data()["note"] as? String
            note.email = document.data()["email"] as? String
            note.username = document.data()["username"] as? String
            let loc = document.data()["location"] as? GeoPoint
            note.lat = loc?.latitude
            note.long = loc?.longitude
            notes.append(note)
            print("\(document.documentID) => \(document.data())")
        }
        return notes
    }
    
    func addNotes(request: NotesRequest, completion: @escaping (Result<APIResponse>) -> Void) {
        let params = ["title" : request.title,
                      "note" : request.notes,
                      "username" : request.username ,
                      "email" : request.email,
                      "location" :GeoPoint(latitude: request.lat, longitude: request.long)] as [String : Any]
        
        FIRInterface.sharedInstance.saveNotes(parameters: params, completion: completion)
    }
}
