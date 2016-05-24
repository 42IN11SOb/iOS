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
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        user = User()
        user.getUserInformation()
        
        
        let pass = DatabaseController.sharedControl.getPassport()
        
        if(pass.season.count == 0){
            downloadPassport { (loaded) in
                print("Download passport complete")
                
            }
        }
        
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
    
    func downloadPassport(completion: (loaded: Bool) ->()){
        
        DatabaseController.sharedControl.deleteAll()
    
        
        RequestController.requestPassport { (result, error) in
            
            if(result != nil){
                let pass: Passport = Passport()
                if ((result?.objectForKey("success")) != nil) {
                    
                    let data = result?.objectForKey("data")
                    if((data?.objectForKey("passport")) != nil){
                        print(data?.objectForKey("passport"))
                        let passport = data?.objectForKey("passport")
                        let season = passport!.objectForKey("season")
                        pass.season_title = season!.objectForKey("name") as! String
                        let figureObj = passport!.objectForKey("figure")
                        
                        pass.figure_title = figureObj!.objectForKey("title") as! String
                        
                        let figure = Figure()
                        figure.title = figureObj!.objectForKey("title") as! String
                        figure.advice = figureObj!.objectForKey("advice") as! String
                        figure.img = figureObj!.objectForKey("img") as! String
                        figure.info = figureObj!.objectForKey("info") as! String
                        
                        DatabaseController.sharedControl.saveFigure(figure)
                        pass.figure = figure
                        DatabaseController.sharedControl.savePassport(pass)

                        let figureRulesDoObj = figureObj!.objectForKey("dos") as! NSArray
                        
                        for does in figureRulesDoObj {
                            let rule = FigureRules()
                            rule.do_or_dont = true
                            rule.text = does as! String
                            DatabaseController.sharedControl.saveFigureRule(rule)
                            DatabaseController.sharedControl.addRuleToFigure(rule)
                        }
                        
                        let figureRulesDontObj = figureObj!.objectForKey("donts") as! NSArray
                        
                        for dont in figureRulesDontObj {
                            let rule = FigureRules()
                            rule.do_or_dont = false
                            rule.text = dont as! String
                            DatabaseController.sharedControl.saveFigureRule(rule)
                            DatabaseController.sharedControl.addRuleToFigure(rule)
                        }
                        
                        let colors = season!.objectForKey("colors") as! NSArray
                        
                        for color in colors {
                            let col = color.objectForKey("color")
                            let passColor : PassportColor = PassportColor()
                            
                            passColor.name = col!["name"] as! String
                            passColor.redColor = col!["r"] as! Float
                            passColor.greenColor = col!["g"] as! Float
                            passColor.blueColor = col!["b"] as! Float
                            
                            passColor.passport_id = pass.id
                            DatabaseController.sharedControl.savePassColor(passColor)
                            DatabaseController.sharedControl.addColorToPassport( passColor)
                        }
                    }
                    
                }
                
                completion(loaded: true)
            } else {
                completion(loaded: false)
            }
        }
    }
    
    
    
    
}
