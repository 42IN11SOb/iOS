//
//  LoginViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 28-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController {
    
    // #TODO:
    // - inlog functionaliteit
    // - api call voor inloggen
    // - opslaan "sessie" gegevens // passport gegevens ophalen.
    
    
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var nonLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        panelView.backgroundColor = panelColor
        
        
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