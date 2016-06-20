//
//  ScanResultController.swift
//  PEP
//
//  Created by Corina Nibbering on 17-06-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class ScanResultViewController: UIViewController{
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultColorView: UIView!
    
    
    var scanResult: Bool  = false {
        didSet {
            configureView()
        }
    }
    
    var resultColor: PassportColor? {
        didSet{
            configureView()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.navigationItem.backBarButtonItem?.title = " "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func closeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configureView(){
        
        if(scanResult){
            self.view.backgroundColor = greenColor
            self.colorLabel.text = resultColor?.name
            self.resultColorView.backgroundColor = resultColor?.getColorFromRGB()
            self.resultLabel.text =  NSLocalizedString("COLORHASBEENFOUND", comment:"The following color has been found") + ":"
            
            
        } else {
            self.view.backgroundColor = redColor
            self.resultLabel.text =  NSLocalizedString("NOCOLORHASBEENFOUND", comment:"No matching color has been found") + "!"
            self.resultColorView.backgroundColor = UIColor.clearColor()
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}