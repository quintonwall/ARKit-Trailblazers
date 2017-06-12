//
//  TestUtility.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/19/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation

class TestUtility {
    
    class func getJSONDataFromFile(thefile : String) -> NSData {
        
        var data : NSData?
        if let path = NSBundle.mainBundle().pathForResource(thefile, ofType: "json") {
            do {
                data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return data!
    }
}
