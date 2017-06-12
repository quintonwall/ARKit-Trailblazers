//
//  WelcomeContentViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/9/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import SwiftlySalesforce
import FCAlertView
import PromiseKit


class WelcomeContentViewController: UIViewController {
    
    @IBOutlet weak var tourImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleMessage: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var pageIndicatorControl: UIPageControl!
    
    var pageIndex: Int = 0
    
    var strTitle: String!
    var strPhotoName: String!
    var hideGetStartedButton : Bool!
    
    override func viewDidLoad()
    {
       	super.viewDidLoad()
        
        
        
        
        
              
       // backgroundImage.image = UIImage(named: strPhotoName)
        backgroundImage.blurImage()
        
        titleMessage.text = strTitle
        
        tourImage.image = UIImage(named: strPhotoName)
        
        let borderAlpha : CGFloat = 1.0
        let cornerRadius : CGFloat = 5.0
        getStartedButton.frame = CGRectMake(100, 100, 200, 50)
        getStartedButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        getStartedButton.backgroundColor = UIColor.clearColor()
        getStartedButton.layer.borderWidth = 2.0
        getStartedButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        getStartedButton.layer.cornerRadius = cornerRadius
        
        getStartedButton.hidden = hideGetStartedButton
        
        pageIndicatorControl.currentPage = pageIndex
        
        
        
        
    }
    
    @IBAction func getStartedTapped(sender: AnyObject) {
        showLogMeInScreen()
    }
    
    @IBAction func skipTapped(sender: AnyObject) {
        showLogMeInScreen()
    }
    
    private func showLogMeInScreen() {
       
        firstly {
            SalesforceAPI.Identity.request()
            
        }.then {_ in 
                self.dismissViewControllerAnimated(true, completion: {
                    print("dismissing welcome after login")
                    AppDefaults.loggedIn()
                })
           
        }.error { _ in
            let fcdialog = FCAlertView()
                fcdialog.showAlertInView(self, withTitle: "Oh no!", withSubtitle: "Astro got lost on the trail. Try again later.", withCustomImage: UIImage(named: "astro_floating_head"), withDoneButtonTitle: "OK", andButtons: nil)
                fcdialog.colorScheme = fcdialog.flatGreen
                fcdialog.dismissOnOutsideTouch = true
        }
        
        
    }
    
    
}