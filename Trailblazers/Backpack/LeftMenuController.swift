//
//  LeftMenuController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/13/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import SwiftlySalesforce


class LeftMenuController: UITableViewController {
    
    let kInset:CGFloat = 64.0
    var selectedMenuItem : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.contentInset = UIEdgeInsetsMake(kInset, 0, 0, 0)
        //tableView.scrollsToTop = false
        // tableView.separatorStyle = .None
        // tableView.backgroundColor = UIColor.clearColor()
        //  tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        // tableView.clearsSelectionOnViewWillAppear = false
        
        //tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("SELECTED INDEX: \(indexPath.row)")
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        switch (indexPath.section) {
        case 0: // home section
            switch (indexPath.row) {
            case 0:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
                break
            case 1:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TrailsView")
                break
            case 2:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ModulesView")
                break
            case 3:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NotImplementedView")
                break
            case 4:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NotImplementedView")
                break
            default:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
                break
            }
        case 1: //account section
            switch (indexPath.row) {
            case 0:
                print("NOT IMPLEMENTED YET. Setting to Welcome View")
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NotImplementedView")
                break
            case 1:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SettingsView")
                break
            case 2:
                print("revoking tokens and logging out")
                AppDefaults.logOut()
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
                break
            default:
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
                break
            }
        default: //you're screwed section
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
        
    }
    
    
}
