//
//  LoginViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 28-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        
        //makes sure keyboard removes
        nameField.delegate=self
        passField.delegate=self
        
        
    }
    
    @IBAction func signInTapped(sender: UIButton) {
        //check if fields arent empty
       login()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    //removes keyboard when touching elsewhere than a textbox
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if(textField == self.nameField){
            self.passField.becomeFirstResponder()
        } else {
            login()
        }
        return true;
    }
    
    func login()
    {
        if(nameField.text == "" || passField.text == "")
        {
            print("signin tapped")
            let alertController = UIAlertController(title:"Login Mislukt", message: "Beide velden zijn verplicht, vul beide velden in en probeer het opniew", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            //clear both fields
            nameField.text = ""
            passField.text = ""
        }
            
        else
        {
            let request = NSMutableURLRequest(URL: NSURL(string: requestLogin)!)
            request.HTTPMethod = "POST"
            let postString = "username=\(nameField.text!)&password=\(passField.text!)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                } else if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode == 401 {
                    print("Request failed, on authorisation")
                    print("response = \(response)")
                }
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
            }
            task.resume()
        
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}