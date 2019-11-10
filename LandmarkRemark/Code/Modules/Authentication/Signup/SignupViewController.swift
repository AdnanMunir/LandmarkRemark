//
//  SignUpVC.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit

final class SignupViewController: UIViewController {

    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var coordinator : SignupCoordinator?
    
    
    // Bindings to SignupVM
    var signupVM : SignUpModeling! {
        didSet {
            self.signupVM.showError = { error in
                AppAlerts.showAlert(message: error)
            }
            
            self.signupVM.startIndicator = {[weak self] in
                self?.view.isUserInteractionEnabled = false
                self?.activityIndicator.startAnimating()
            }
            
            self.signupVM.stopIndicator = {[weak self] in
                self?.view.isUserInteractionEnabled = true
                self?.activityIndicator.stopAnimating()
            }
            
            self.signupVM.moveBackToLogin = {[weak self] message in
                AppAlerts.showAlert(message: message, delegate: self)
            }
        }
    }
    
    
    
    //MARK: ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: User Interactions
    @IBAction func signupButtonActions(_ sender: Any) {
        signupVM.signUp(with: textFieldEmail.text ?? "", username: textFieldUsername.text ?? "", password: textFieldPassword.text ?? "")
    }
   

}

//MARK: Alert Delegate
extension SignupViewController : AlertDelegate {
    func alertOkPressed() {
        coordinator?.signupCompleted()
    }
}
