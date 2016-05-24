//
//  Validator.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 24/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import Foundation

protocol ValidatorProtocol {
    func isValid(enteredText: String) -> Bool
}

class FirstNameValidator: ValidatorProtocol {
    func isValid(enteredText: String) -> Bool {
        return enteredText.containsString(" ")
    }
}

class PhoneNumberValidator: ValidatorProtocol {
    func isValid(enteredText: String) -> Bool {
        return enteredText.characters.count > 10 && enteredText.characters.count < 12
    }
}

class EmailAddressValidator: ValidatorProtocol {
    func isValid(enteredText: String) -> Bool {
        return enteredText.containsString("@") && enteredText.containsString(".")
    }
}
