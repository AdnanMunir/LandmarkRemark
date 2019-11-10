//
//  MainCoordinator.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    private let window: UIWindow
    private let appConfigurations : AppConfigurations
    
    init(window : UIWindow) {
        self.window = window
        self.appConfigurations = AppConfigurations(authService: AuthenticationService())
        self.navigationController = UINavigationController()
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    
    func start() {
        
        appConfigurations.delegate = self
        appConfigurations.decideAppFlow()

    }
    
    func changeRootViewToLogin() {
       
        let loginCoordinator = LoginCoordinator(navController: navigationController)
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    func changeRootViewToMap() {
        
        let mapCoordinator = MapViewCoordinator(navController: navigationController)
        mapCoordinator.parentCoordinator = self
        childCoordinators.append(mapCoordinator)
        mapCoordinator.start()
    }
    
}

extension MainCoordinator : AppConfigurationDelegate {
    func moveToLogin() {
        changeRootViewToLogin()
    }
    
    func moveToMap() {
        changeRootViewToMap()
    }
    
    
}
