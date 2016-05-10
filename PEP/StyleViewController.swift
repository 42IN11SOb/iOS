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
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var figureTitleLabel: UILabel!
    @IBOutlet weak var figureLabel: UILabel!
    @IBOutlet weak var doLabel: UILabel!
    @IBOutlet weak var dontLabel: UILabel!
    @IBOutlet weak var heightConstraintDo: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("STYLETITLE", comment:"Style title")
        self.view.backgroundColor = backgroundColor
        
        let pass = DatabaseController.sharedControl.getPassport()

        print(pass)
        for rule in (pass.figure?.figureRules)! {
            print(rule)
        }
        
        figureImgView.load((pass.figure?.img)!)
        
        figureTitleLabel.text = pass.figure_title
        figureLabel.text = pass.figure?.info
        adviceLabel.text = pass.figure?.advice
        
        
        
//        seasonLabel.text = pass.season_title

//        self.contentView.backgroundColor = yellowColor
        
        
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