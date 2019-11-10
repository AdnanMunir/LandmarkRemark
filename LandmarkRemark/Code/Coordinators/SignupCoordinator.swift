//
//  SignupCoordinator.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import UIKit

final class SignupCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    weak var parentCoordinator : LoginCoordinator?
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    
    func start() {
        let signupVC = SignupViewController.instantiate(withStoryBoard: .Authentication)
        signupVC.coordinator = self
        signupVC.signupVM = SignupViewModel(authService: AuthenticationService())
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func signupCompleted() {
        //parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }
    
    
}
