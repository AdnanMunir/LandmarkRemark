//
//  SplashVM.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

protocol AppConfigurationDelegate : class {
    func moveToLogin()
    func moveToMap()
}

final class AppConfigurations {
    private let authService : AuthenticationProtocol
    weak var delegate : AppConfigurationDelegate?
    init(authService : AuthenticationProtocol) {
        self.authService = authService
        configureFirebase()
    }
    
    private func configureFirebase() {
        FIRInterface.sharedInstance.initialize()
    }
    
    func decideAppFlow() {
        
        // Checks through firebase current user that if credentials available move to MapVC else move to LoginVC
        
        authService.isUserAuthenticated {[weak self] (result) in
            switch result {
            case .success(_):
                self?.delegate?.moveToMap()
                break
            case .failure(_):
                self?.delegate?.moveToLogin()
                break
            }
        }
    }
}

