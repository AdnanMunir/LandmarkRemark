//
//  LoginVC.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var coordinator : LoginCoordinator?
    var loginVM : LoginModeling! {
        didSet {
            self.loginVM.showError = { error in
                AppAlerts.showAlert(message: error)
            }
            
            self.loginVM.startIndicator = {[weak self] in
                self?.view.isUserInteractionEnabled = false
                self?.activityIndicator.startAnimating()
            }
            
            self.loginVM.stopIndicator = {[weak self] in
                self?.view.isUserInteractionEnabled = true
                self?.activityIndicator.stopAnimating()
            }
            
            self.loginVM.moveToMapView = {[weak self] in
                self?.coordinator?.moveToMapView()
            }
            
            self.loginVM.resetView = {[weak self] in
                self?.textFieldPassword.text = ""
                self?.textFieldEmail.text = ""
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        loginVM.viewWillAppear()
        
    }
    

    @IBAction func signupButtonAction(_ sender: Any) {
        coordinator?.moveToSignup()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        loginVM.login(with: textFieldEmail.text ?? "", password: textFieldPassword.text ?? "")
    }
    
}
