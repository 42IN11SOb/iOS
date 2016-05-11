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
    dynamic var passport_id = 0
    dynamic var title = ""
    dynamic var advice = ""
    dynamic var img = ""
    dynamic var info = ""
    let figureRules = List<FigureRules>()
    
}
