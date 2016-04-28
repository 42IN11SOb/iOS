//
//  RequestController.swift
//  PEP
//
//  Created by Corina Nibbering on 28-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import Foundation
import UIKit

class RequestController {
    
    static func requestPassportColors(completion: (result: NSArray?, error: NSError?)->()){
        
        let user = User()
        user.getUserInformation()
        let requestProfwithToken = requestProfile + user.token
        let request = NSMutableURLRequest(URL: NSURL(string: requestProfwithToken)!)
        request.HTTPMethod = "GET"

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                completion(result: nil, error: error)
            } else {
                do {
                    
                    let result:NSArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                        completion(result: result, error: nil)
                } catch {
                     print("error serializing JSON: \(error)")
                }
            }
        }
        
        task.resume()
    }

}