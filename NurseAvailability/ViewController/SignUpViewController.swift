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
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var nextFieldButton: UIButton!
    
    @IBOutlet weak var signUpDetailsView: SignUpDetailsView!
    @IBOutlet weak var signUpDetailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var enteredDetailsTopConstraint: NSLayoutConstraint!
    
    var signUpViewModel = SignUpViewModel()
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        inputTextField.becomeFirstResponder()
        
        setTouchRecogniser()
        setupTextFieldWithCorrectPlaceholder()
        
        signUpDetailsViewHeight.constant = CGFloat(signUpViewModel.inputFieldsAndText.count) * 30
        
        setupActivityIndicator()
        
        signUpViewModel.showActivityIndicator = showActivityIndicator
    }
    
    func setupActivityIndicator() {
       activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
    }
    
    func setupTextFieldWithCorrectPlaceholder() {
        inputTextField.text = ""
        inputTextField.placeholder = signUpViewModel.currentInputField.placeholder
        inputTextField.keyboardType = signUpViewModel.currentInputField.keyboardType
        inputTextField.tag = signUpViewModel.currentInputField.tag
        inputTextField.reloadInputViews()
        
        nextFieldButton.hidden = true
    }
    
    func dismissKeyboard() {
        inputTextField.resignFirstResponder()
    }
    
    func setTouchRecogniser() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func storeEntryData(textfield: UITextField) {
        signUpViewModel.storeData(textfield.text!)
        signUpViewModel.updateCurrentAndNextInputFields(updatedCurrentTextfield, handleCompleteData: completeDataSent)
    }
    
    func showActivityIndicator() {
        activityView.startAnimating()
    }
    
    func completeDataSent() {
        activityView.stopAnimating()
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissKeyboard()
            self.showCompletedAlertView()
        })
    }
    
    func showCompletedAlertView() {
        let alertController = UIAlertController(title: "Data sent successfully!", message:
            "Someone will be in touch soon.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            _ in
            self.closeView()
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func updatedCurrentTextfield() {
        signUpDetailsView.showTextFieldLabel(inputTextField.text!)
        animateView()
        setupTextFieldWithCorrectPlaceholder()
    }
    
    func animateView() {
        enteredDetailsTopConstraint.constant += 40
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func nextField() {
        storeEntryData(inputTextField)
    }
    
    @IBAction func closeView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewForKeyboardVisible(true)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = textField.text ?? ""
        let currentText = textFieldText.stringByReplacingCharactersInRange(range, withString: string)
        nextFieldButton.hidden = !signUpViewModel.currentInputField.validator.isValid(currentText)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.hidden = true
    }
    
    func animateViewForKeyboardVisible(visible: Bool) {
        inputTextFieldBottomConstraint.constant = visible ? 226 : 0
        UIView.animateWithDuration(0.25, animations: {
            self.view.layoutSubviews()
            }, completion: nil)
    }
}
