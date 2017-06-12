//
//  MainNavigationController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/13/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import ENSwiftSideMenu

class MainNavigationController: ENSideMenuNavigationController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: AppColors.accentSky,
            NSFontAttributeName: UIFont(name: "Trailhead Bold2", size: 18)!
        ]
        
        
        let sideVC: LeftMenuController = storyboard?.instantiateViewControllerWithIdentifier("SideMenu") as! LeftMenuController
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: sideVC, menuPosition:.Left)
        print("set the side menu")
        
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 180.0 // optional, default is 160
        sideMenu?.bouncingEnabled = true
        sideMenu?.allowPanGesture = true
        sideMenu?.animationDuration = 0.5
        // make navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        // print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        //print("sideMenuWillClose")
    }
    
    func sideMenuDidClose() {
        // print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        // print("sideMenuDidOpen")
    }
    
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
