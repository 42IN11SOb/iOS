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
//    var requestController: RequestController = RequestController()
    

    func downloadSeason(completion: (loaded: Bool) ->()){
        
       RequestController.requestPassportColors { (result, error) in
        
            if(result != nil){
                for object in result! {
                        
                        let r = object["r"] as! CGFloat
                        let g = object["g"] as! CGFloat
                        let b = object["b"] as! CGFloat
                        let color = UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
                    
                        let passColor : PassportColor = PassportColor()
                        passColor.color = color
                        passColor.colorName = "Color name"

                        self.seasonColors.append(passColor)
                    }
                
                completion(loaded: true)
            } else {
                completion(loaded: false)
            }
        }
    }

    
}