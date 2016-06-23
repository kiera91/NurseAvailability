//
//  NurseLoginClient.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 26/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import Foundation

protocol NurseLoginClientProtocol {
    func postNurseDetails(params: [String:String], success: ((NSDictionary) -> Void), failure: ((String) -> Void))
}

class NurseLoginClient: NurseLoginClientProtocol {
    let baseUrl = "http://localhost:3000/login/signin"
    
    
    func postNurseDetails(params: [String:String], success: ((NSDictionary) -> Void), failure: ((String) -> Void)) {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
            let url: NSURL = NSURL(string: baseUrl)!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = jsonData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("", forHTTPHeaderField: "X-CSRF-Token")
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (data, response, error) in
                if error != nil {
                    failure(error!.localizedDescription)
                } else {
                    do {
                        let message = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                        if let dict = message as? NSDictionary {
                            if dict["status"] as? Int != 200 {
                                failure(dict["message"] as! String)
                            } else {
                                success(dict)
                            }
                        }
                    } catch {
                        failure("Sorry, we've had a problem")
                    }
                }
            }
            
            task.resume()
            
        } catch let error as NSError {
            print(error)
        }
    }
}