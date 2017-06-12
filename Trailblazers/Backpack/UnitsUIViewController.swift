//
//  UnitsUIViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/22/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class UnitsUIViewController : ProtectedUIViewController {
    
    var recordCount: Int = 0
    
    @IBOutlet weak var moduleBlurb: UILabel!

    @IBOutlet weak var moduleDuration: UILabel!
    @IBOutlet weak var moduleTitleLabel: UILabel!
    @IBOutlet weak var moduleLevels: UILabel!
    @IBOutlet weak var moduleTags: UILabel!
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var contentPane: UIView!
    @IBOutlet weak var unitsTable: UITableView!
    
    @IBOutlet weak var moduleBadge: UIImageView! {
        didSet {
            moduleBadge.layer.cornerRadius = moduleBadge.frame.size.height / 2
            moduleBadge.layer.borderWidth = 2
            moduleBadge.layer.masksToBounds = true

        }
    }
    
    @IBOutlet weak var dismissButton: UIButton!
    
    
    var module : Module? {
        didSet {
            //self.moduleBadge.sd_setImageWithURL(NSURL(string: module!.badgeIconURL!))
        }
    }
    
    var trail : Trail? {
        didSet {
           // self.dismissButton.backgroundColor = trail?.headerColor
        }
    }
    
     var defBackgroundColor : UIColor = AppColors.primaryDarkBlue
    
    override func viewWillAppear(animated: Bool) {
        popupView.layer.cornerRadius = 15
        dismissButton.layer.cornerRadius = 15
        
        moduleTitleLabel.text = module!.badgeTitle
        moduleBlurb.text = module?.descriptionHTML
        moduleDuration.text = module?.challengeTimeFormatted
        moduleLevels.text = module?.levelsFormatted
        moduleTags.text = module?.tagsFormatted
        
        
        
        
        moduleBadge!.sd_setImageWithURL(NSURL(string: module!.badgeIconURL!))
        
       
        if(trail != nil) {
            defBackgroundColor = trail!.headerColor!
        }
        
        dismissButton.backgroundColor = defBackgroundColor
        popupView.backgroundColor = defBackgroundColor
        moduleBadge.layer.borderColor = defBackgroundColor.CGColor
        contentPane.layer.borderColor = defBackgroundColor.CGColor
        
        unitsTable.reloadData()
    }

    
    @IBAction func dismissTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
}

extension UnitsUIViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = module?.units.count {
            recordCount = count
        }
        return recordCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("unitcell", forIndexPath: indexPath) as! UnitTableViewCell
        
        let u = module?.units[indexPath.row]
        cell.unit = u
        cell.title = u?.title
        cell.duration = u?.challengeTimeFormatted
        
        
        return cell
        
        
    }
}








