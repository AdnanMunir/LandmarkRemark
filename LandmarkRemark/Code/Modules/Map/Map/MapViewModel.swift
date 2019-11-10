//
//  MapVM.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

enum NotesType : Int {
    case ALL = 0
    case MINE = 1
}

enum SearchType : Int {
    case USERNAME = 0
    case NOTES = 1
}


final class MapViewModel : MapModeling {
    var searchType: SearchType
    var startIndicator: MapModeling.handleIndicator?
    var stopIndicator: MapModeling.handleIndicator?
    var removeAllAnnotations: MapModeling.removeAnnotationAlias?
    var addAnnotation: MapModeling.addAnnotationAlias?
    var showError: MapModeling.errorAlias?
    var notesType: NotesType
    var initializeView: MapModeling.configureViewAlias?
    
    var moveToLogin: MapModeling.updateFlowAlias?
    private let authService : LogoutProtocol
    private let notesService : GetNotesProtocol
    private var currentAvailableNotes = [Note]()
    
    
    
    init(authService : LogoutProtocol,notesService : GetNotesProtocol) {
        self.authService = authService
        self.notesService = notesService
        self.notesType = NotesType(rawValue: 0) ?? .ALL
        self.searchType = SearchType(rawValue: 0) ?? .USERNAME
    }
    
    func viewDidLoad() {
        LocationManager.sharedInstance.startLocationUpdates()
        initializeView?()
        reloadMap()
    }
    
    func getUserTitle() -> String {
        return "\(CurrentUser.sharedInstance.username)  (\(CurrentUser.sharedInstance.email)) "
    }
    
    func getNotesVM() -> NoteViewViewModel {
        return NoteViewViewModel(service: NotesService())
    }
    
    func changeNotesType(type: Int) {
        notesType = NotesType(rawValue: type) ?? .ALL
        reloadMap()
    }
    
    func changeSearchType(type: Int) {
        searchType = SearchType(rawValue: type) ?? .USERNAME
    }
    
    func reloadMap() {
        removeAllAnnotations?()
        switch notesType {
        case .ALL:
            getAllNotes()
            break
        case .MINE:
            getMyNotes()
            break
        }
    }
    
    private func getMyNotes() {
        startIndicator?()
        notesService.getMyNotes {[weak self] (result) in
            self?.stopIndicator?()
            switch result {
            case .success(let notes):
                if let notes = notes , notes.count > 0 {
                    self?.currentAvailableNotes = notes
                    self?.addAnnotations(notes: notes)
                } else {
                    self?.currentAvailableNotes = [Note]()
                }
                break
            case .failure(let reason):
                self?.showError?(reason.localizedDescription)
                break
            }
        }
    }
    
    private func getAllNotes() {
        startIndicator?()
        notesService.getAllNotes {[weak self] (result) in
            self?.stopIndicator?()
            switch result {
            case .success(let notes):
                if let notes = notes , notes.count > 0 {
                    self?.currentAvailableNotes = notes
                    self?.addAnnotations(notes: notes)
                } else {
                    self?.currentAvailableNotes = [Note]()
                }
                break
            case .failure(let reason):
                self?.showError?(reason.localizedDescription)
                break
            }
        }
    }
    
    private func addAnnotations(notes : [Note]) {
        for note in notes {
            addAnnotation?(note)
        }
    }
    
    func filterNotes(searchText: String, completion: ([Note]) -> Void) {
        
        switch searchType {
        case .USERNAME:
            let filteredNotesOnUsername = currentAvailableNotes.filter({ $0.username?.lowercased().contains(searchText.lowercased()) ?? false })
             completion(filteredNotesOnUsername)
            break
        case .NOTES:
            let filteredNotesOnNote = currentAvailableNotes.filter({
                $0.note?.lowercased().contains(searchText.lowercased()) ?? false
                
            })
            completion(filteredNotesOnNote)
        }

    }
    
    func logout() {
        authService.logout {[weak self] (result) in
            switch result {
            case .success(_) :
                LocationManager.sharedInstance.stopLocationUpdates()
                self?.moveToLogin?()
                break
            case .failure(_):
                break
            }
        }
    }
}
