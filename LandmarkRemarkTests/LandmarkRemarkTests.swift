//
//  LandmarkRemarkTests.swift
//  LandmarkRemarkTests
//
//  Created by Adnan Munir on 10/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import XCTest
@testable import LandmarkRemark


struct MockGetNotesService: GetNotesProtocol {
    
    func getAllNotes(completion: @escaping (Result<[Note]>) -> Void) {
        completion(.success([
            Note(title: "Note 1", note: "This is mock note 1", lat: 0.0, long: 0.0, email: "test@test.com", username: "Test"),
            Note(title: "Note 2", note: "This is mock note 2", lat: 0.0, long: 0.0, email: "test@test.com", username: "Test"),
            Note(title: "Note 3", note: "This is mock note 3", lat: 0.0, long: 0.0, email: "at@a.com", username: "Adnan"),
            Note(title: "Note 4", note: "This is mock note 4", lat: 0.0, long: 0.0, email: "b@b.com", username: "Munir")]))
    }
    
    func getMyNotes(completion: @escaping (Result<[Note]>) -> Void) {
        completion(.success([
            Note(title: "Note 1", note: "This is mock note 1", lat: 0.0, long: 0.0, email: "test@test.com", username: "Test"),
            Note(title: "Note 2", note: "This is mock note 2", lat: 0.0, long: 0.0, email: "test@test.com", username: "Test")]))
    }
    
}



class LandmarkRemarkTests: XCTestCase {

    var loginService : LoginProtocol!
    var addNotesService : AddNotesProtocol!
    var mapVM : MapViewModel!
    
    override func setUp() {
        loginService = AuthenticationService()
        addNotesService = NotesService()
        mapVM = MapViewModel(authService: AuthenticationService(), notesService: MockGetNotesService())
        testLoginUser()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        loginService = nil
        addNotesService = nil
        mapVM = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    
    
    func testLoginUser() {
        
        let expect = expectation(description: "Test")
        
        let request = LoginRequest(email: "test@test.com", password: "123456")
        
        loginService.login(request: request) { (result) in
            switch result {
            case .success(_):
                if CurrentUser.sharedInstance.username == "Test" {
                    expect.fulfill()
                }
                break
            case .failure(_):
                break
            }
        }
    
        wait(for: [expect], timeout: 5)
//        waitForExpectations(timeout: 5) { (_) in
//            XCTAssert(false)
//
//        }
    }
    
    func testAddNote() {
        
        let expect = expectation(description: "Note added successfully")
        let request = NotesRequest(username: "Test", notes: "This note is from Tests", lat: 21.0, long: 0.987, title: "Test Note", email: "test@test.com")
        
        addNotesService.addNotes(request: request) { (result) in
            switch result {
            case .success(_):
                expect.fulfill()
                break
            case .failure(_):
                break
            }
        }
        
        wait(for: [expect], timeout: 5)
    }
    
    func testSearchNoteWithNoteText() {
        mapVM.changeSearchType(type: SearchType.NOTES.rawValue)
        mapVM.reloadMap()
        mapVM.filterNotes(searchText: "mock") { (notes) in
            XCTAssertEqual(notes.count, 4)
        }
    }
    
    func testSearchNoteWithUsername() {
        mapVM.changeSearchType(type: SearchType.USERNAME.rawValue)
        mapVM.reloadMap()
        mapVM.filterNotes(searchText: "Test") { (notes) in
            XCTAssertEqual(notes.count, 2)
        }
    }

}
