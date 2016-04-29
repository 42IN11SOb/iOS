//
//  Figure.swift
//  PEP
//
//  Created by Corina Nibbering on 29-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import Foundation
import RealmSwift

class Figure: Object {
    dynamic var passport: Passport? = nil
    dynamic var title = ""
    dynamic var advice = ""
    dynamic var img = ""
    let figureRules = List<FigureRules>()
    
}
