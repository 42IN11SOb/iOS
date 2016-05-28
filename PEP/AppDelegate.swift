//
//  AppDelegate.swift
//  PEP
//
//  Created by Corina Nibbering on 15-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
    
        // #TODO: make boolean terms accepted
        // - make terms view 
        // - make switch for termsview or launch main. 
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.stringForKey("apiToken")
    
        if (token != nil) {
            print("Token in storage")
            print(token)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("MainController") as! MainController
            mainView.navigationItem.setHidesBackButton(true, animated:true);
            let rootViewController = self.window!.rootViewController as! UINavigationController
            
            rootViewController.pushViewController(mainView, animated: true)
            
        } else {
            print("No token ");
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let introView = mainStoryboard.instantiateViewControllerWithIdentifier("IntroViewController") as! IntroViewController
            let rootViewController = self.window!.rootViewController as! UINavigationController
            rootViewController.pushViewController(introView, animated: true)
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

