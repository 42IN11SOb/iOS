//
//  Passport.swift
//  PEP
//
//  Created by Corina Nibbering on 26-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Passport: Object {
    
    dynamic var id = 0
    dynamic var user_id =  0
    dynamic var makeup_title = ""
    dynamic var figure_title = ""
    dynamic var season_title = ""
    dynamic var figure: Figure? = nil
    let season = List<PassportColor>()
    
    override class func primaryKey() -> String? {
        return "id"
    }

}