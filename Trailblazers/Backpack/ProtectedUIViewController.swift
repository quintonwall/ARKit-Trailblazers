//
//  ProtectedUIViewController.swift
//This should be used for all of the screens that require the user to be logged in.
//  Backpack
//
//  Created by QUINTON WALL on 9/13/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit


class ProtectedUIViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
    }
       
    func checkLogin() {
        if (!AppDefaults.isLoggedIn()) {
            print("not logged in")
            showWelcomeTour()
        }

        
    }
    
    private func showWelcomeTour() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let welcomeViewController = mainStoryboard.instantiateViewControllerWithIdentifier("PageContentViewController")
        self.presentViewController(welcomeViewController, animated: true, completion: nil)

    }
    
}
