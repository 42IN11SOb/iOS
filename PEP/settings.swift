//
//  settings.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import Foundation
import UIKit

// Colors still need to be determined.

let yellowColor     = UIColor(red: 255/255, green: 213/255, blue: 0/255, alpha: 1)
let lightGreyColor  = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
let blackColor      = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
let whiteColor      = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
let greyColor       = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)


let hightlightColor = yellowColor
let textColor       = blackColor
let buttonColor     = greyColor
let panelColor      = whiteColor
let backgroundColor = greyColor

let SCREENHEIGHT = UIScreen.mainScreen().bounds.size.height
let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width


// API INFO
let baseURL: String  = "https://projectpep.herokuapp.com"
//let baseURL: String  = "http://localhost:3000"
let requestLogin: String = baseURL + "/users/login"
let requestLogout: String = baseURL + "/users/logout?token="
//let requestProfile: String = baseURL + "/seasons?token="
let requestProfile: String = baseURL + "/users/profile?token="
let requestCheckLogin : String = baseURL + "/users/loggedIn?token="

let requestNews: String = baseURL + "/news"



func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

