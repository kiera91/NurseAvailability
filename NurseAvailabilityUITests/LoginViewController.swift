//
//  LoginViewController.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 26/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    var loginViewModel: LoginViewModel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loginViewModel = LoginViewModel()
        loginViewModel.displayLoginError = { [weak self] errorString in
            self?.displayErrorMessage(errorString)
        }
    }

    @IBAction func signInAction() {
        let params = ["email_address":usernameTextfield.text!, "password": passwordTextfield.text!]
        loginViewModel.makeSignInRequest(params)
    }
    
    func displayErrorMessage(errorString: String) {
        dispatch_async(dispatch_get_main_queue(), {
            let alertController = UIAlertController(title: errorString , message:
                "", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                _ in
            }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let textFieldLabel = textField.accessibilityLabel {
            if textFieldLabel == "password" {
                passwordTextfield.resignFirstResponder()
                return true
            } else {
                passwordTextfield.becomeFirstResponder()
            }
        }
        return false
    }
}
