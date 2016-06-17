//
//  ScanResultController.swift
//  PEP
//
//  Created by Corina Nibbering on 17-06-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class ScanResultViewController: UIViewController{
    

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = yellowColor
     
        
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
    
    @IBAction func closeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}