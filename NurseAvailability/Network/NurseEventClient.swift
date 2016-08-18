//
//  NurseEventClient.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 26/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import Foundation

protocol NurseEventClientProtocol {
    func getNurseEventDetails(params: [String:String], success: ((NSDictionary) -> Void), failure: ((String) -> Void))
}

class NurseEventClient: NurseEventClientProtocol {
    let baseUrl = "http://localhost:3000/nurse_events/events"
    
    
    func getNurseEventDetails(params: [String:String], success: ((NSDictionary) -> Void), failure: ((String) -> Void)) {
            let urlString = "\(baseUrl)?nurse_id=\(params["nurse_id"])"

            
            let url: NSURL = NSURL(string: urlString)!
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("Token token=\(params["api_token"])", forHTTPHeaderField: "Authorization")
            
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
    }
}