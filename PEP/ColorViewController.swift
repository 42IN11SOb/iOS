//
//  ColorViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 19-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    
    @IBOutlet weak var colorLabel: UILabel!
    var selectedColor: PassportColor? {
        didSet{
            configureView()
        }
    }

    var pageIndex: Int?
    
    func configureView(){
        if let selectedColor = selectedColor {
            self.view.backgroundColor = selectedColor.getColorFromRGB()
            self.colorLabel.text = selectedColor.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColor
        
        configureView()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
}


