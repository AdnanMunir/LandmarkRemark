//
//  SignUpVM.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation



final class SignupViewModel: SignUpModeling {
    var moveBackToLogin: SignUpModeling.updateFlow?
    var showError: SignUpModeling.error?
    var startIndicator: SignUpModeling.handleIndicator?
    var stopIndicator: SignUpModeling.handleIndicator?
    
    private var authService : SignUpProtocol
    
    init(authService : SignUpProtocol) {
        self.authService = authService
    }
    
    
    func signUp(with email :String ,username : String , password : String) {
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            showError?("Email is empty. Please enter email")
            return
        }
        
        if password.trimmingCharacters(in: .whitespaces).isEmpty {
            showError?("password is empty. Pleaase enter password")
            return
        }
        
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            showError?("Username is empty. Pleaase enter Username")
            return
        }
        
        var request = SignupRequest(email: email,password: password)
        request.email = email
        request.password = password
        request.username = username
        
        startIndicator?()
        
        authService.signUp(request: request) {[weak self] (result) in
            self?.stopIndicator?()
            switch result {
            case .success(_):
                self?.moveBackToLogin?("Signup Successful")
                break
            case .failure(let reason):
                self?.showError?(reason.localizedDescription)
                print(reason)
            }
        }
        
        
    }
    
}
