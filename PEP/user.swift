//
//  user.swift
//  PEP
//
//  Created by John Huiskes on 08-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit


class User {
    // MARK: Properties
    
    var name: String = ""
    var password: String = ""
    var email: String = ""
    var token: String = ""
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func saveUser(){
        
        defaults.setObject(name, forKey: "nameKey")
        defaults.setObject(email, forKey: "emailKey")
        defaults.setObject(token, forKey: "apiToken")
        
    }
    
    func saveUser(_id: String, name: String, email: String, token: String){
    
        defaults.setObject(name, forKey: "nameKey")
        defaults.setObject(email, forKey: "emailKey")
        defaults.setObject(token, forKey: "apiToken")
        
    }
    
    func updateUser(){
        defaults.setObject(self.name, forKey: "nameKey")
        defaults.setObject(self.email, forKey: "emailKey")
        defaults.setObject(self.token, forKey: "apiToken")
    }
    
    func getUserInformation(){
        
        if let token = defaults.stringForKey("apiToken"){
            self.token = token
        }
        if let name = defaults.stringForKey("nameKey"){
            self.name = name
        }
        
        if let email = defaults.stringForKey("emailKey"){
            self.email = email
        }
        
    }

    
}