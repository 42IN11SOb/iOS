//
//  PassportController.swift
//  PEP
//
//  Created by Corina Nibbering on 17-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class PassportViewController: UIViewController {
    
    // #TODO:
    // - var outlets aanmaken voor alle elementen in de view
    // - passport model aanmaken
    // - passport color 'show' functie aanmaken (specifiek tonen van 1 kleur -> via nieuwe controller)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PASPOORT"
        self.view.backgroundColor = backgroundColor
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

