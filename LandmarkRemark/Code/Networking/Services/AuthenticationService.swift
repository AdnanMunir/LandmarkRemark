//
//  AuthenticationService.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

struct AuthenticationService : AuthenticationProtocol,SignUpProtocol,LoginProtocol,LogoutProtocol {
    
    func isUserAuthenticated(completion: @escaping ((Result<APIResponse>) -> Void)) {
        FIRInterface.sharedInstance.isUserLoggedIn { (result) in
            switch result {
            case .success(let user):
                if let user = user {
                    CurrentUser.sharedInstance.email = user.email ?? ""
                    CurrentUser.sharedInstance.username = user.displayName ?? ""
                }
                completion(.success(nil))
                break
            case .failure(let reason):
                completion(.failure(reason))
                break
            }
        }
    }
    
    func signUp(request : SignupRequest , completion : @escaping (Result<APIResponse>) -> Void) {
        FIRInterface.sharedInstance.createUser(request: request, completion: completion)
    }
    
    func login(request : LoginRequest , completion : @escaping (Result<APIResponse>) -> Void) {
        FIRInterface.sharedInstance.signInUser(request: request) { (result) in
            switch result {
            case .success(let user):
                if let user = user {
                    CurrentUser.sharedInstance.email = user.email ?? ""
                    CurrentUser.sharedInstance.username = user.displayName ?? ""
                }
                completion(.success(nil))
                break
            case .failure(let reason):
                completion(.failure(reason))
                break
            }
        }
    }
    
    func logout(completion: @escaping (Result<APIResponse>) -> Void) {
        FIRInterface.sharedInstance.logoutUser(completion: completion)
    }
}
