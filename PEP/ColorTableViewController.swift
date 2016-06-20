//
//  ColorTableViewController.swift
//  PEP
//
//  Created by Corina Nibbering on 19-04-16.
//  Copyright © 2016 42IN11SOb. All rights reserved.
//

import UIKit
import RealmSwift

class ColorTableViewController: UITableViewController {

    var colors: [PassportColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = backgroundColor
        self.tableView.backgroundColor = backgroundColor
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let pass = DatabaseController.sharedControl.getPassport()
        self.title = NSLocalizedString("COLORTABLETITLE", comment:"Colortable title") + " " + pass.season_title

        for color in pass.season {
           colors.append(color as PassportColor)
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

        cell.layer.backgroundColor = color.getColorFromRGB().CGColor
        cell.headingLabel?.text = color.name
        cell.contentView.backgroundColor = color.getColorFromRGB()
    
        return cell
    }

    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "colorSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let color: PassportColor  = colors[indexPath.row]
                let controller:ColorPageViewController = segue.destinationViewController as! ColorPageViewController
                controller.selectedColor = color
                
                let coloring : [PassportColor] = self.colors
                controller.pageColors = coloring
                controller.selectedIndex = indexPath.row
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.backBarButtonItem?.title = " "

            }
        }
    }

    
    
}