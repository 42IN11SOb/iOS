//
//  IntroViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 24-05-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    var user: User!
    
    override func loadView() {
        super.loadView()

        user = User()
        user.getUserInformation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
     
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
}