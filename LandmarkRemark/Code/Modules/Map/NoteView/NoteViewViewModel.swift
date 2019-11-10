//
//  NoteViewVM.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 07/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation



class NoteViewViewModel: NoteViewModeling {
    var reloadMapView: NoteViewModeling.reloadViewAias?
    var startIndicator: NoteViewModeling.handleIndicator?
    var stopIndicator: NoteViewModeling.handleIndicator?
    
    var showError: NoteViewModeling.errorAlias?
    private let notesService : AddNotesProtocol
    
    init(service : AddNotesProtocol) {
        notesService = service
    }
    
    func addNotes(title: String, notes: String) {
        
        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            showError?("Title should not be empty")
            return
        }
        
        if notes.trimmingCharacters(in: .whitespaces).isEmpty {
            showError?("Notes should not be empty")
            return
        }
        
        guard let lat = LocationManager.sharedInstance.locationManager.location?.coordinate.latitude ,
            let long = LocationManager.sharedInstance.locationManager.location?.coordinate.longitude
            else {
                showError?("Location not present")
                return
            }
        
        var request = NotesRequest()
        
        request.lat = lat
        request.long = long
        request.title = title
        request.notes = notes
        request.username = CurrentUser.sharedInstance.username
        request.email = CurrentUser.sharedInstance.email
        
        
        startIndicator?()
        notesService.addNotes(request: request) {[weak self] (result) in
            self?.stopIndicator?()
            switch result {
            case .success(_):
                self?.reloadMapView?()
                // reload map with annotations and remove note view
                break
            case .failure(let reason):
                self?.showError?(reason.localizedDescription)
                break
            }
        }
        
        
    }
    
//    private func makeAddNoteRequest(lat : Double , long : Double , title : String , notes : String ,username : String , email : String) {
//
//    }
    
}
