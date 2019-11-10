//
//  HomeCoordinator.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import UIKit

final class LoginCoordinator: NSObject,Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        navigationController.delegate = self
        let loginVC = LoginViewController.instantiate(withStoryBoard: .Authentication)
        loginVC.loginVM = LoginViewModel(authService: AuthenticationService())
        loginVC.coordinator = self
        navigationController = UINavigationController(rootViewController: loginVC)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        //navigationController.pushViewController(loginVC, animated: false)
    
    }
    
    func moveToSignup() {
        let signupCoordinator = SignupCoordinator(navController: navigationController)
        signupCoordinator.parentCoordinator = self
        childCoordinators.append(signupCoordinator)
        signupCoordinator.start()
    }
    
    func moveToMapView() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.changeRootViewToMap()
    }
    
    
    
}

extension LoginCoordinator : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let signupVC = fromViewController as? SignupViewController {
            childDidFinish(signupVC.coordinator!)
        }
    }
}
