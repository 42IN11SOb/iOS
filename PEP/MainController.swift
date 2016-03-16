//
//  MainController.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//


import UIKit

class MainController : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var passportButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PEP 2.0"
        self.view.backgroundColor = backgroundColor
        self.scrollView.backgroundColor = backgroundColor 
        scanButton.backgroundColor = blackColor
        passportButton.backgroundColor = yellowColor
        settingsButton.backgroundColor = blackColor
        informationButton.backgroundColor = yellowColor
        
        scanButton.setTitleColor(yellowColor, forState: UIControlState.Normal)
        passportButton.setTitleColor(textColor, forState: UIControlState.Normal)
        settingsButton.setTitleColor(yellowColor, forState: UIControlState.Normal)
        informationButton.setTitleColor(textColor, forState: UIControlState.Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.scrollEnabled = true
    }
    
    
    
}
