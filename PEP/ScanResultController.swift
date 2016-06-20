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
    @IBOutlet weak var backgroundView: UIView!
    
    var scanResult: Bool  = false
    var resultColor: PassportColor?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Setting results
    
    func configureView(){
        
        if(scanResult){
            self.colorLabel.text = resultColor?.name
            self.resultColorView.backgroundColor = resultColor?.getColorFromRGB()
            self.resultLabel.text =  NSLocalizedString("COLORHASBEENFOUND", comment:"The following color has been found") + ":"
        } else {
            self.view.backgroundColor = redColor
            self.resultLabel.text =  NSLocalizedString("NOCOLORHASBEENFOUND", comment:"No matching color has been found") + "!"
            self.colorLabel.text = " "
            self.resultColorView.backgroundColor = UIColor.clearColor()
        }
    }
    

    
}