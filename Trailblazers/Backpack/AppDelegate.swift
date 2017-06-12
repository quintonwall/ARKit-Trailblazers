//
//  AppDelegate.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/9/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import UIKit
import SwiftlySalesforce
import FCAlertView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginViewPresentable {

    var window: UIWindow?
    
    //note: connected app set up in dash app org
    let consumerKey = "3MVG9uudbyLbNPZNuIUUb1Twl.GDnRbhV1oirzCTTthaCOJxBsL3zhIl78WSnnmeGDqDMEL14Gw8ObFxRPwXz"
    let redirectURL = NSURL(string: "thbackpack://success")!
    let hostname = "na30.lightning.force.com"
    let trailheadAPIKey = "106f9b40b806fe6581688a92d0b6892a"
    let trailheadAPIVersion = "v1"
    
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        OAuth2Manager.sharedInstance.configureWithConsumerKey(consumerKey, redirectURL: redirectURL, hostname: hostname)
        OAuth2Manager.sharedInstance.authenticationDelegate = self
        
        TrailheadManager.sharedInstance.trailheadAPIKey = trailheadAPIKey
        TrailheadManager.sharedInstance.trailheadAPIVersion = trailheadAPIVersion
        
        if(!AppDefaults.isLoggedIn()) {
            AppDefaults.setInitalDefaults()
        }
       
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        handleRedirectURL(url)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

     func showErrorDialog(attemptingToDo : String, errorMsg : String) {
        AppDefaults.storeLastError(attemptingToDo, error: errorMsg)
        let fcdialog = FCAlertView()
        fcdialog.showAlertInView(self.window?.rootViewController, withTitle: "Oh Snap!", withSubtitle: errorMsg, withCustomImage: UIImage(named: "astro_hi_there"), withDoneButtonTitle: "OK", andButtons: nil)
        fcdialog.colorScheme = AppColors.accentMountains
        fcdialog.dismissOnOutsideTouch = true
    }
    
    func showInfoDialog(message : String) {
        let fcdialog = FCAlertView()
        fcdialog.showAlertInView(self.window?.rootViewController, withTitle: "FYI", withSubtitle: message, withCustomImage: UIImage(named: "astro_hi_there"), withDoneButtonTitle: "OK", andButtons: nil)
        fcdialog.colorScheme = AppColors.accentSigns
        fcdialog.dismissOnOutsideTouch = true
    }
}

