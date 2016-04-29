//
//  ColorViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 19-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    var selectedColor: PassportColor? {
        didSet{
            configureView()
        }
    }
    
    var pageIndex: Int?
    
    func configureView(){
        if let selectedColor = selectedColor {
            self.view.backgroundColor = selectedColor.color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColor
        
        configureView()
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
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
}


