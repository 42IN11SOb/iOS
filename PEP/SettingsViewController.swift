//
//  SettingsController.swift
//  PEP
//
//  Created by Corina Nibbering on 17-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    // #TODO:
    // - var outlets aanmaken voor alle elementen in de view
    // - mogelijke benodigde functies aanmaken (denk aan save / discard etc. )
    //
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SETTINGSTITLE", comment:"Settings title")
        self.view.backgroundColor = backgroundColor
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    @IBAction func logoutButtonClicked(sender: AnyObject) {
        
        RequestController.logout { (result, error) in
            print(result)
            
            if ((result?.objectForKey("success")) != nil) {
                let success = result?.objectForKey("success") as! Bool
                if(success){
                    DatabaseController.sharedControl.deleteAll()
//                    let appDomain = NSBundle.mainBundle().bundleIdentifier!
//                    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("StartBoard") as UIViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

