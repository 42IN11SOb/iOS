//
//  MainController.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//


import UIKit

class MainController : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scanViewButton: UIView!
    @IBOutlet weak var passportViewButton: UIView!
    @IBOutlet weak var settingsViewButton: UIView!
    @IBOutlet weak var informationViewButton: UIView!
    
    @IBOutlet weak var scanViewHeightContstraint: NSLayoutConstraint!
    @IBOutlet weak var passportHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var informationHeightConstraint: NSLayoutConstraint!
    
    var user: User!
    
    override func loadView() {
        super.loadView()
        
        let buttonHeight = SCREENHEIGHT/4
        
        scanViewHeightContstraint.constant = buttonHeight
        passportHeightConstraint.constant = buttonHeight
        settingsHeightConstraint.constant = buttonHeight
        informationHeightConstraint.constant = buttonHeight
        scrollView.contentSize.height = buttonHeight*4
        scrollView.needsUpdateConstraints()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PEP 2.0"
        self.view.backgroundColor = backgroundColor
        self.scrollView.backgroundColor = backgroundColor
        self.mainView.backgroundColor = backgroundColor
        self.contentView.backgroundColor = backgroundColor
        
        user = User()
        user.getUserInformation()
        print(user.name)
        
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
