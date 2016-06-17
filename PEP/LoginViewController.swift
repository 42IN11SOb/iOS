//
//  LoginViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 28-03-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var nonLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var user: User!
    var loginSuccesfull: Bool! = false
    
    override func loadView() {
        super.loadView()
        
        user = User()
        user.getUserInformation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        panelView.backgroundColor = panelColor
        
        //makes sure keyboard removes
        nameField.delegate=self
        passField.delegate=self
        
        
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
    
    
    
    
    @IBAction func loginTapped(sender: AnyObject) {
        login()
    }
    
    func login (){
        self.loginSuccesfull = false
        activityIndicatorView.startAnimating()
        if(nameField.text == "" || passField.text == "")
        {
            let alertController = UIAlertController(title:NSLocalizedString("LoginFailed", comment:"Login Failed alert title"), message: NSLocalizedString("BothFields", comment:"Fill in both fields") + NSLocalizedString("TryAgain", comment:"Try Again"), preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }  else {

            let request = NSMutableURLRequest(URL: NSURL(string: requestLogin)!)
            request.HTTPMethod = "POST"
            let postString = "username=\(nameField.text!)&password=\(passField.text!)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print("error=\(error)")
                    
                    self.error(NSLocalizedString("NoNetwork", comment:"No network alert"), message: NSLocalizedString("NetworkNotAvailable", comment:"No network available message, please login"))
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 && httpStatus.statusCode != 401 {           // check for http errors
                    
                    
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    
                    //geef message terug er ging iets fouts
                    
                    self.error(NSLocalizedString("Error", comment:"Error"), message: NSLocalizedString("SomethingWrong", comment:"Something went wrong text") + NSLocalizedString("TryAgain", comment:"Please try again"))
                    
                } else if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode == 401 {
                    print("Request failed, on authorisation")
                    print("response = \(response)")
                                //geef message terug wachtwoord en username onjuist
                    
                    self.error(NSLocalizedString("WrongLogin", comment:"error message title"), message: NSLocalizedString("WrongUsernamePassword", comment:"error message wrong username and/or password") + NSLocalizedString("TryAgain", comment:"Please try again"))
                }
                
//                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("responseString = \(responseString)")
                
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    if (jsonResult["success"] != nil) {
                        let success = jsonResult["success"] as! Bool
                        if success {
                            let data = jsonResult["data"] as! NSDictionary
                            let token = data["token"] as! String
                            
                            self.user.name = self.nameField.text!
                            self.user.email = ""
                            self.user.token = token
                            self.user.saveUser()
                            self.loginSuccesfull = true
                            
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                self.performSegueWithIdentifier("login", sender: self)
                            }

                        }
                        
                    }
                                   } catch {
                    print("Error in parsing JSON")
                }
                
            }
            task.resume()
        
        }
        activityIndicatorView.stopAnimating()
        
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if(identifier == "login")
        {
           
            if(!loginSuccesfull){
                return false
            } else {
                return true
            }
        }
        else
        {
            return true
        }
        
    }
    
    func error(title: String, message: String){
        
        
        NSOperationQueue.mainQueue().addOperationWithBlock {

            let alertController = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:"Ok"), style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}