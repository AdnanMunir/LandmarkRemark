//
//  AuthenticationProtocol.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 07/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

protocol SignUpProtocol {
    /**
     Call this function to Signup User from any of the Provider(Firbase , server , DB etc)
     */
    
    func signUp(request : SignupRequest , completion : @escaping (Result<APIResponse>) -> Void)
}

protocol LoginProtocol {
    /**
     Call this function to Login User from any of the Provider(Firbase , server , DB etc)
     */
    func login(request : LoginRequest , completion : @escaping (Result<APIResponse>) -> Void)
}

protocol AuthenticationProtocol {
    /**
     Call this function to Authenticate User from any of the Provider(Firbase , server , DB etc)
     */
    func isUserAuthenticated(completion :@escaping ((Result<APIResponse>) -> Void))
}

protocol LogoutProtocol {
    /**
     Call this function to Logout User from any of the Provider(Firbase , server , DB etc)
     */
    func logout(completion : @escaping (Result<APIResponse>) -> Void)
}
