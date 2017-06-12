//
//  TrailheadManager.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/20/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation

public final class TrailheadManager {
    
    public var trailheadAPIKey = "NOT SET"
    public var trailheadAPIVersion = "v1"
    public var salesforceOAuthToken = "NOT SET"
    public var testMode : Bool = true
    
    
    public static let sharedInstance = TrailheadManager()
    
    func getBaseURI() -> String {
        return "https://api.trailhead.salesforce.com/\(trailheadAPIVersion)"
    }
    
    
     func getRequestHeaders() ->  [String:String] {
        let headers =  [
            "Authorization": "Bearer \(salesforceOAuthToken)",
            "API-X-Key": trailheadAPIKey
        ]
        print("Using HTTPHeaders: \(headers)")
        return headers
    }
    
    

}