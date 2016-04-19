//
//  ColorTableViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 19-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit

class ColorTableViewController: UITableViewController {

    var colors: [PassportColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("COLORTABLETITLE", comment:"Colortable title")
        self.view.backgroundColor = backgroundColor
        self.tableView.backgroundColor = backgroundColor
        
        
        let color : PassportColor = PassportColor()
        color.color = UIColor.redColor()
        color.colorName = "Red"
        
        let color1 : PassportColor = PassportColor()
        color1.color = UIColor.greenColor()
        color1.colorName = "Green"
        
        let color2 : PassportColor = PassportColor()
        color2.color = UIColor.blueColor()
        color2.colorName = "Blue"
        
        let color3 : PassportColor = PassportColor()
        color3.color = UIColor.yellowColor()
        color3.colorName = "Yellow"
        
        let color4 : PassportColor = PassportColor()
        color4.color = UIColor.purpleColor()
        color4.colorName = "Purple"
        
        
        for _ in 0..<10 {
            colors.append(color)
            colors.append(color2)
            colors.append(color3)
            colors.append(color4)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as! ColorTableCell
        
        let color: PassportColor = self.colors[indexPath.row]
        cell.headingLabel?.text = color.colorName
    
        cell.backgroundColor = color.color
        cell.contentView.backgroundColor = color.color
        
    
        return cell
    }

    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "colorSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let color: PassportColor  = colors[indexPath.row]
                let controller:ColorViewController = segue.destinationViewController as! ColorViewController
                controller.selectedColor = color
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    
    
}