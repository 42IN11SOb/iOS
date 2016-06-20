//
//  Color.swift
//  PEP
//
//  Created by Corina Nibbering on 19-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import RealmSwift

class PassportColor: Object {
    
    dynamic var passport_id = 0
    dynamic var name = ""
    dynamic var redColor: Float = 0.0
    dynamic var greenColor: Float = 0.0
    dynamic var blueColor: Float = 0.0

    
    func getColorFromRGB() -> UIColor{
        let color = UIColor(red: CGFloat(self.redColor)/255, green: CGFloat(self.greenColor)/255, blue: CGFloat(self.blueColor)/255, alpha: 1)
        return color
    }

}