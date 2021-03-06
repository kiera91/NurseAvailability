//
//  SignUpViewModel.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 23/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import Foundation
import UIKit

struct InputFieldData {
    let key: String
    let placeholder: String
    let tag: Int
    let keyboardType: UIKeyboardType
    let validator: ValidatorProtocol
}

class SignUpViewModel {
    let inputFieldsAndText = [
        InputFieldData(key: "full_name", placeholder: "Enter your full name", tag: 1, keyboardType: .Default, validator: FirstNameValidator()),
        InputFieldData(key: "phone_number", placeholder: "Enter your phone number", tag: 2, keyboardType: .PhonePad, validator: PhoneNumberValidator()),
        InputFieldData(key: "email_address", placeholder: "Enter your email address", tag: 3, keyboardType: .EmailAddress, validator: EmailAddressValidator())
    ]
    
    var currentInputField: InputFieldData!
    var currentIndex: Int = 0
    
    var dataToStore: [String:String] = [:]
    var showActivityIndicator: (() -> Void)?
    
    let nurseSignUpClient = NurseSignUpClient()
    
    init() {
        currentIndex = inputFieldsAndText.startIndex
        currentInputField = inputFieldsAndText[currentIndex]
    }

    func storeData(textEntered: String) {
        dataToStore[currentInputField.key] = textEntered
    }
    
    func sendCompleteData(success: (() -> Void), failure: (() -> Void)) {
        showActivityIndicator?()
        nurseSignUpClient.postNurseDetails(dataToStore, success: {
            success()
            }) { 
                failure()
        }
    }
    
    func updateCurrentAndNextInputFields(didUpdateCurrentField: (() -> Void), handleCompleteData: (() -> Void), failedNetworkRequest: (() -> Void)) {
        currentIndex += 1
        if currentIndex < inputFieldsAndText.count {
            currentInputField = inputFieldsAndText[currentIndex]
            didUpdateCurrentField()
        } else {
            sendCompleteData(handleCompleteData, failure: failedNetworkRequest)
        }
    }
}
