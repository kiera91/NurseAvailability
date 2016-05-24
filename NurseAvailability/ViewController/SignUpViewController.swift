//
//  SignUpViewController.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 20/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var inputTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var enteredDetailsTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var signUpDetailsView: SignUpDetailsView!
    
    var dataToStore: [String] = []
    
    // Put this in a struct
    var inputFieldsAndText = [
        ["key": "fullName", "placeholder": "Enter your full name", "textFieldTag": 1],
        ["key": "phoneNumber", "placeholder": "Enter your phone number", "textFieldTag": 2],
        ["key": "emailAddress", "placeholder": "Enter your email address", "textFieldTag": 3],
        ["key": "nurseId", "placeholder": "Enter your nursing id", "textFieldTag": 4]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        inputTextField.becomeFirstResponder()
        
        setTouchRecogniser()
        setupTextFieldWithCorrectPlaceholder(inputFieldsAndText.startIndex)
    }
    
    func setupTextFieldWithCorrectPlaceholder(index: Int) {
        inputTextField.placeholder = inputFieldsAndText[index]["placeholder"] as? String
        inputTextField.tag = inputFieldsAndText[index]["textFieldTag"] as! Int
    }
    
    func dismissKeyboard() {
        inputTextField.resignFirstResponder()
    }
    
    func setTouchRecogniser() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func storeEntryData(textfield: UITextField) {
        dataToStore.append(textfield.text!)
        signUpDetailsView.showTextFieldLabel(textfield.tag, text: textfield.text!)
        animateView()
        setupTextFieldWithCorrectPlaceholder(<#T##index: Int##Int#>)
    }
    
    func animateView() {
        enteredDetailsTopConstraint.constant += 29
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewForKeyboardVisible(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let _ = textField.text {
            storeEntryData(textField)
            
            return true
        }
        return false
    }
    
    func animateViewForKeyboardVisible(visible: Bool) {
        inputTextFieldBottomConstraint.constant = visible ? 226 : 0
        UIView.animateWithDuration(0.25, animations: {
            self.view.layoutSubviews()
            }, completion: nil)
    }
}
