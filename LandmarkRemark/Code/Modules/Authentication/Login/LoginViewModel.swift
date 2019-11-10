//
//  LoginVM.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation



final class LoginViewModel: LoginModeling {
    var resetView: LoginModeling.resetViewAlias?
    var moveToMapView: LoginModeling.updateFlowAlias?
    var startIndicator: LoginModeling.handleIndicator?
    var stopIndicator: LoginModeling.handleIndicator?
    var showError: LoginModeling.errorAlias?
    
    private let authService : LoginProtocol
    
    init(authService : LoginProtocol) {
        self.authService = authService
    }
    
    
    func viewWillAppear() {
        resetView?()
    }
    
    func login(with email: String, password: String) {
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            showError?("Email is empty. Please enter email")
            return
        }
        
        if password.trimmingCharacters(in: .whitespaces).isEmpty {
            showError?("password is empty. Pleaase enter password")
            return
        }
        
        var request = LoginRequest(email: email,password: password)
        request.email = email
        request.password = password
        
        startIndicator?()
        
        authService.login(request: request) {[weak self] (result) in
            self?.stopIndicator?()
            switch result {
            case .success(_) :
                self?.moveToMapView?()
                break
            case .failure(let reason):
                 self?.showError?(reason.localizedDescription)
                break
            }
        }
    }
    
    
    
}
