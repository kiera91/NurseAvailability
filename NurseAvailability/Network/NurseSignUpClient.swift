//
//  NurseSignUpClient.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 24/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import Foundation

protocol NurseSignUpClientProtocol {
    func postNurseDetails(params: [String:String], success: (() -> Void))
}

class NurseSignUpClient: NurseSignUpClientProtocol {
    let baseUrl = "http://localhost:9393"
    
    
    func postNurseDetails(params: [String:String], success: (() -> Void)) {
        let urlString = baseUrl + "/signup_request"
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
            let url: NSURL = NSURL(string: urlString)!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = jsonData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (data, response, error) in
                success()
            }
            
            task.resume()
            
        } catch let error as NSError {
            print(error)
        }
    }
}