//
//  LoginViewModel.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 26/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import Foundation

class LoginViewModel {
    var nurseLoginClient = NurseLoginClient()
    var displayLoginError: ((String) -> Void)?
    
    func makeSignInRequest(params: [String: String]) {
        nurseLoginClient.postNurseDetails(params, success: { responseDict in
            self.updateUserLoggedInFlag()
            self.saveApiTokenInKeychain(responseDict)
        }, failure: { [weak self] errorString in
            self?.displayLoginError!(errorString)
        })
    }
    
    func saveApiTokenInKeychain(responseDict: NSDictionary) {
    
    }
    
    func updateUserLoggedInFlag() {
        
    }
}
