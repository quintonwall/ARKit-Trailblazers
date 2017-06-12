//
//  SettingsTableViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/19/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import EventKit


class SettingsTableViewController : ProtectedTableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var calEntriesForFavoritesSwitch: UISwitch!
    @IBOutlet weak var enablePushNotificationsSwitch: UISwitch!
    @IBOutlet weak var useTestDataSwitch: UISwitch!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var sendDebugButton: UIButton!
    @IBOutlet weak var removeAllFavoritesButton: UIButton!
    
    let eventStore = EKEventStore()
    
    override func viewWillAppear(animated: Bool) {
        self.setInitialValues()
    }
    
    override func viewDidLoad() {
        
        let cornerRadius : CGFloat = 5.0
        
        sendDebugButton.layer.borderWidth = 1.0
        sendDebugButton.layer.borderColor = AppColors.accentSky.CGColor
        sendDebugButton.layer.cornerRadius = cornerRadius
        
        removeAllFavoritesButton.layer.borderWidth = 1.0
        removeAllFavoritesButton.layer.borderColor = AppColors.accentSky.CGColor
        removeAllFavoritesButton.layer.cornerRadius = cornerRadius
    }
    
    func setInitialValues() {
        
        appVersionLabel.text = "App Version "+AppDefaults.getAppVersion()
        
        //reflect defaults onto controls
        let defaults = NSUserDefaults.standardUserDefaults()
        
        calEntriesForFavoritesSwitch.on = defaults.boolForKey(KEY_ADD_CAL_ENTRIES_FOR_FAVORITES)
        enablePushNotificationsSwitch.on = defaults.boolForKey(KEY_ENABLE_PUSH_NOTIFICATIONS)
        useTestDataSwitch.on = defaults.boolForKey(KEY_USE_TEST_DATA)
                
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func removeAllFavoritesTapped(sender: AnyObject) {
         let defaults = NSUserDefaults.standardUserDefaults()
         defaults.setObject([Int](), forKey: KEY_FAVORITES)

        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
        ad.showInfoDialog("Backpacked removed your favorites. You will have to remove your calendar entries though.")
    }
    
    
    @IBAction func calEntriesToggled(sender: UISwitch) {
        calEntriesForFavoritesSwitch.setOn(sender.on, animated: true)
         let defaults = NSUserDefaults.standardUserDefaults()
        if(sender.on) {
            requestAccessToCalendar()
        }
        defaults.setBool(sender.on, forKey: KEY_ADD_CAL_ENTRIES_FOR_FAVORITES)
    
    }
    
    @IBAction func pushNotificationsToggled(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        enablePushNotificationsSwitch.setOn(sender.on, animated: true)
        defaults.setBool(sender.on, forKey: KEY_ENABLE_PUSH_NOTIFICATIONS)
    }
    
    @IBAction func hamburgerButtonTapped(sender: AnyObject) {
       toggleSideMenuView()
    }
    
    @IBAction func useTestDataToggled(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        useTestDataSwitch.setOn(sender.on, animated: true)
        TrailheadManager.sharedInstance.testMode = sender.on
        defaults.setBool(sender.on, forKey: KEY_USE_TEST_DATA)
    }
    
    
    
    //MARK: mail stuff
    
    @IBAction func sendDebugButtonTapped(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Backpack App Debug")
            mail.setToRecipients(["quinton@heroku.com"])
            mail.setMessageBody("<p>&nbsp;</p><p>-------------</p><p>LAST ERROR:</p><p>-------------</p><p>"+AppDefaults.getLastError()+"<p>-------------</p><p></p>Running app version "+AppDefaults.getAppVersion()+"</p>", isHTML: true)
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: additional features 
    
    func requestAccessToCalendar() -> Bool {
        
        var access = false
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
            (accessGranted: Bool, error: NSError?) in
             access = accessGranted
           })
        return access
    }
}
