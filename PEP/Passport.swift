//
//  Passport.swift
//  PEP
//
//  Created by Corina Nibbering on 26-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import Foundation
import UIKit

class Passport {
    
    var styleAdvice = ""
    var does = ""
    var donts = ""
    var seasonColors: [PassportColor] = []
    

    func downloadSeason(){
        let color : PassportColor = PassportColor()
        color.color = UIColor.redColor()
        color.colorName = "Red"
        
        let color1 : PassportColor = PassportColor()
        color1.color = UIColor.greenColor()
        color1.colorName = "Green"
        
        let color2 : PassportColor = PassportColor()
        color2.color = UIColor.blueColor()
        color2.colorName = "Blue"
        
        let color3 : PassportColor = PassportColor()
        color3.color = UIColor.yellowColor()
        color3.colorName = "Yellow"
        
        let color4 : PassportColor = PassportColor()
        color4.color = UIColor.purpleColor()
        color4.colorName = "Purple"
        
        
        for _ in 0..<10 {
            seasonColors.append(color)
            seasonColors.append(color2)
            seasonColors.append(color3)
            seasonColors.append(color4)
        }
        
    }
    
   
    
    
}