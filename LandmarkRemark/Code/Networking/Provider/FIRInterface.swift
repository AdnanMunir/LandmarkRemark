//
//  FIRInterface.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 05/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


enum Result<T> {
    case success(T?)
    case failure(FailureReason)
}


final class FIRInterface {
    static let sharedInstance = FIRInterface()
    private init() { }
    var docRef : DocumentReference!
    
    /**
     Call this function to Initialize Firebase
     */
    func initialize() {
        FirebaseApp.configure()
    }
    
    /**
     Call this function to Create User On Firestore
     */
    func createUser(request : SignupRequest , completion :@escaping  (Result<APIResponse>) -> Void) {
        Auth.auth().createUser(withEmail: request.email, password: request.password) {[weak self] authResult, error in
            
            if let error = error {
                return completion(.failure(.reason(error: error.localizedDescription)))
            }
            
            self?.updateUserInfo(request: request, completion: completion)
        }
    }
    
    
    /**
     Call this function to Sign In FireStore
     */
    func signInUser(request : LoginRequest , completion :@escaping  (Result<User>) -> Void) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { (authResult, error) in
            if let error = error {
                return completion(.failure(.reason(error: error.localizedDescription)))
            }
            
            if let user = Auth.auth().currentUser {
                completion(.success(user))
                return
            }
            
            completion(.success(nil))
        }

    }
    
    
    /**
     Call this function to Update  UserName of SignedUp User or update user Info in FIRUser object
     */
    func updateUserInfo(request : SignupRequest , completion :@escaping  (Result<APIResponse>) -> Void) {
        if let user = Auth.auth().currentUser {
            let updateRequest = user.createProfileChangeRequest()
            updateRequest.displayName = request.username
            updateRequest.commitChanges { (error) in
                if let error = error {
                    completion(.failure(.reason(error: error.localizedDescription)))
                    return
                }
                completion(.success(nil))
            }
        }
    }
    
    
    /**
     Call this function to verify weather user is logged in or not
     */
    func isUserLoggedIn( completion :@escaping  (Result<User>) -> Void) {
        if let user = Auth.auth().currentUser {
            completion(.success(user))
            return
        }
        
        completion(.failure(.reason(error: "User not logged In")))
    }
    
    
    /**
     Call this function to Log the user out of the app
     */
    func logoutUser( completion :@escaping  (Result<APIResponse>) -> Void) {
        
        do {
           try Auth.auth().signOut()
            completion(.success(nil))
            
        } catch let error {
            completion(.failure(.reason(error: error.localizedDescription)))
        }
        
    }
    
    
    /**
     Call this function to save Data in User Table on Firestore
     */
    func saveNotes(parameters : [String:Any] , completion :@escaping  (Result<APIResponse>) -> Void) {
        Firestore.firestore().collection("Users").document().setData(parameters) { err in
            if let err = err {
                completion(.failure(.reason(error: err.localizedDescription)))
                print("Error adding document: \(err)")
            } else {
                completion(.success(nil))
            }
        }
    }
    
    
    /**
     Call this function to get all users data for User table  on Firestore
     */
    func getAllNotes(completion :@escaping  (Result<[QueryDocumentSnapshot]>) -> Void) {
        Firestore.firestore().collection("Users").getDocuments { (querySnapshot, error) in
            if let err = error {
                completion(.failure(.reason(error: err.localizedDescription)))
                print("Error getting documents: \(err)")
            } else {
                if let snapshot = querySnapshot {
                    completion(.success(snapshot.documents))
                }
                
            }
        }
    }
    
    
    /**
     Call this function to get all data of logged In user from User Table
     */
    func getMyNotes(completion :@escaping  (Result<[QueryDocumentSnapshot]>) -> Void) {
        Firestore.firestore().collection("Users").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "").addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                completion(.failure(.reason(error: err.localizedDescription)))
                print("Error getting documents: \(err)")
            } else {
                if let snapshot = querySnapshot {
                    completion(.success(snapshot.documents))
                    return
                }
                completion(.success(nil))
            }
        }
    }
    
}
