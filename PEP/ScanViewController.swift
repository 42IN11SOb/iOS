//
//  ViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import AVFoundation


class ScanViewController: UIViewController{

    // #TODO:
    // - var outlets aanmaken voor alle elementen in de view
    // - scan knop of continue scan?
    // - camera koppeling (camera spul zelf in core!)
    // - model aanmaken voor een herkende scan 
    // - scan 'recognized' functie opzetten (al is het maar een opzet) 
    // -

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SCANTITLE", comment:"Scan title")
        self.view.backgroundColor = backgroundColor
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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

