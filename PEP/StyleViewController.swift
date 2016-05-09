//
//  StyleViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 19-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import ImageLoader

class StyleViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var figureImgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("STYLETITLE", comment:"Style title")
        self.view.backgroundColor = backgroundColor
        
        let pass = DatabaseController.sharedControl.getPassport()

        for rule in (pass.figure?.figureRules)! {
            print(rule)
        }
        
        figureImgView.load((pass.figure?.img)!)
        
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