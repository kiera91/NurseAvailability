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
    var showCalendarView: ((Void) -> Void)?
    
    func makeSignInRequest(params: [String: String]) {
        nurseLoginClient.postNurseDetails(params, success: { [weak self] responseDict in
            self?.parseNurseLoggedInData(responseDict)
        }, failure: { [weak self] errorString in
            self?.displayLoginError!(errorString)
        })
    }
    
    func parseNurseLoggedInData(responseDict: NSDictionary) {
        guard let nurseId = responseDict["id"],
            let authToken = responseDict["apitoken"] else {
            return
        }
        
        updateUserLoggedInFlag(nurseId as! Int, authToken: authToken as! String)
        showCalendarView!()
    }
    
    func updateUserLoggedInFlag(nurseId: Int, authToken: String) {
        NSUserDefaults.standardUserDefaults().setObject(nurseId, forKey: "nurseId")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        NSUserDefaults.standardUserDefaults().setObject(authToken, forKey: "authToken")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
