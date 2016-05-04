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
        downloadSeason { (loaded) in
            print("Season download complete")
            
        }
        print(user.name)
        
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            self.scanViewButton.userInteractionEnabled = false
        #endif
        
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
    
    func downloadSeason(completion: (loaded: Bool) ->()){
        
        DatabaseController.sharedControl.deleteAll()
    
        
        RequestController.requestPassportColors { (result, error) in
            
            if(result != nil){
                let pass: Passport = Passport()
                if ((result?.objectForKey("success")) != nil) {
//                   print(result?.objectForKey("user"))
                    
                    if((result?.objectForKey("user")?.objectForKey("passport")) != nil){
                        print(result?.objectForKey("user")?.objectForKey("passport"))
                        let passport = result?.objectForKey("user")?.objectForKey("passport")
                        let season = passport!.objectForKey("season")
                        pass.season_title = season!.objectForKey("name") as! String
                    }
                }
                
                DatabaseController.sharedControl.savePassport(pass)
                
                
//                for object in result! {
//                    
//                    let passColor : PassportColor = PassportColor()
//                    passColor.name = "Colr name"
//                    passColor.redColor = object["r"] as! Float
//                    passColor.greenColor = object["g"] as! Float
//                    passColor.blueColor = object["b"] as! Float
//
//                    passColor.passport_id = pass.id
//                    DatabaseController.sharedControl.savePassColor(passColor)
//                    DatabaseController.sharedControl.addColorToPassport( passColor)
//                }
                
                completion(loaded: true)
            } else {
                completion(loaded: false)
            }
        }
    }
    
    
    
    
}
