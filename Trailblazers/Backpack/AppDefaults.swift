//
//  AppDefaults.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/9/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import SwiftlySalesforce
import PromiseKit
import Alamofire
import EventKit
import FCAlertView



struct AppColors {
    static let primaryDarkBlue : UIColor = UIColor(netHex: 0x0a3b61)
    static let primarySalesforceBlue : UIColor = UIColor(netHex: 0x00a1e0)
    static let primarySigns : UIColor = UIColor(netHex: 0x4a3116)
    static let primaryTrees : UIColor = UIColor(netHex: 0x14713e)
    static let accentSky : UIColor = UIColor(netHex: 0x78c7da)
    static let accentMountains : UIColor = UIColor(netHex: 0x0047bb)
    static let accentTrees : UIColor = UIColor(netHex: 0x129948)
    static let accentSigns : UIColor = UIColor(netHex: 0xe0c075)
    
}



//keys for local storage
let KEY_USE_TEST_DATA : String = "thbackpack-use-test-data"
let KEY_ADD_CAL_ENTRIES_FOR_FAVORITES : String = "thbackpack-access-cal"
let KEY_ENABLE_PUSH_NOTIFICATIONS : String = "thbackpack-push-notifications"
let KEY_LAST_ERROR : String = "thbackpack-last-error"
let KEY_FAVORITES : String = "thbackpack-favorites"



class AppDefaults {
    
    
    
    static func addToFavorites(favorite : TrailheadObject) {
       
         let defaults = NSUserDefaults.standardUserDefaults()
        if var favs = defaults.objectForKey(KEY_FAVORITES) as? [Int] {
            
            //check if thobj already in favs
            if favs.contains(favorite.id!) {
                favs.removeAtIndex(favs.indexOf(favorite.id!)!)
            }
            favs.append(favorite.id!)
            defaults.setObject(favs, forKey: KEY_FAVORITES)
            print("Currently \(favs.count) favorites stored")
        }
       
        
        if (canWriteFavoritesToCalendar()) {
            let eventStore = EKEventStore()
            let newEvent = EKEvent(eventStore: eventStore)
            newEvent.calendar = eventStore.defaultCalendarForNewEvents
            newEvent.title = "Complete Trailhead \(favorite.type!): \(favorite.title!)"
            newEvent.startDate = self.getDaysFromNow(3)
            newEvent.endDate = self.getDaysFromNow(3)
            newEvent.addAlarm(EKAlarm(absoluteDate: self.getDaysFromNow(2)))
            newEvent.URL = favorite.webUrl
            newEvent.allDay = true
            
            //save the event
            do {
                try eventStore.saveEvent(newEvent, span: .ThisEvent, commit: true)
            } catch let e as NSError  {
                let ad = UIApplication.sharedApplication().delegate as! AppDelegate
                ad.showErrorDialog("Add favorite id \(favorite.id!)", errorMsg: e.description)
            }
        }
    }
    
    static func removeFromFavorites(favorite : TrailheadObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if var favs = defaults.objectForKey(KEY_FAVORITES) as? [Int] {
            
            //check if thobj already in favs
            if favs.contains(favorite.id!) {
                favs.removeAtIndex(favs.indexOf(favorite.id!)!)
            }
            defaults.setObject(favs, forKey: KEY_FAVORITES)
        }
    }
    
    static func getFavorites() -> [Int] {
        let defaults = NSUserDefaults.standardUserDefaults()
        return(defaults.objectForKey(KEY_FAVORITES) as? [Int])!
    }
    
    static func isLoggedIn() -> Bool {
       
        if OAuth2Manager.sharedInstance.credentials == nil {
            return false
        }
        else {
            return true
        }
        
    }
    
    
    static func setInitalDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.objectForKey(KEY_USE_TEST_DATA) == nil) {
            TrailheadManager.sharedInstance.testMode = true
            defaults.setBool(true, forKey: KEY_USE_TEST_DATA)
        }
        if (defaults.objectForKey(KEY_ADD_CAL_ENTRIES_FOR_FAVORITES) == nil) {
            defaults.setBool(false, forKey: KEY_ADD_CAL_ENTRIES_FOR_FAVORITES)
        }
        if (defaults.objectForKey(KEY_ENABLE_PUSH_NOTIFICATIONS) == nil) {
            defaults.setBool(false, forKey: KEY_ENABLE_PUSH_NOTIFICATIONS)
        }
        
        if (defaults.objectForKey(KEY_FAVORITES) == nil) {
            defaults.setObject([Int](), forKey: KEY_FAVORITES)
        }
    }
    
    static func getAppVersion() -> String {
        return "v"+NSBundle.mainBundle().releaseVersionNumber! + " b"+NSBundle.mainBundle().buildVersionNumber!
    }
    
    
    static func storeLastError(attemptingToDo: String, error: String) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(attemptingToDo+" caused an error: "+error, forKey: KEY_LAST_ERROR)
        
    }
    static func getLastError() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let s = defaults.objectForKey(KEY_LAST_ERROR) as? String {
            return s
        } else {
            return "no errors stored"
        }
    }
    
    static func useTestData() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey(KEY_USE_TEST_DATA)
    }
    
    static func canWriteFavoritesToCalendar() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey(KEY_ADD_CAL_ENTRIES_FOR_FAVORITES)
    }
    
    
    
    static func loggedIn() {
        TrailheadManager.sharedInstance.salesforceOAuthToken = OAuth2Manager.sharedInstance.credentials!.accessToken
    }
    
    static func logOut() {
        setInitalDefaults()
        OAuth2Manager.sharedInstance.revoke()
        
    }
    
    static func getDaysFromNow(daysFromNow : Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: daysFromNow, toDate: NSDate(), options: [])!
    }
}
