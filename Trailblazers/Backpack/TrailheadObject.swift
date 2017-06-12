//
//  TrailheadObject.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/20/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit


struct TrailheadObjectType {
     static var Trail : String = "Trail"
    static var Module : String = "Module"
    static var Unit : String = "Unit"
    static var Tag : String = "Tag"
    static var Level : String = "Level"
    static var Role : String = "Role"
    static var Product : String = "Product"
    
}

public class TrailheadObject  {
    
    public var id: Int?
    public var title: String?
    public var webUrl: NSURL?
    public var type :String?
  
    
    public init(objectType: String) {
        type = objectType
    }
    
    func challengeTimeToFormattedString(minutes : Int) -> String {
        let (h,m,s) = secondsToHoursMinutesSeconds(minutes * 60)
        
        if(h == 0) {
            return "\(m) mins"
        } else {
            return "\(h) hrs \(m) mins"
        }
    }
    
    func arrayToFormattedTitles(thobjects: [TrailheadObject], delimiter : String) -> String {
        var s = ""
        var i = 1
        for t in thobjects as [TrailheadObject] {
            s.appendContentsOf(t.title ?? "")
            if(i != thobjects.count) {
                s.appendContentsOf(" \(delimiter)")
                i += 1
            }
        }
        return s

        
    }
    
    
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
