//
//  TrailsKit.swift
//  Backpack
//
//  Created by Quinton Wall on 9/14/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import SwiftlySalesforce
import PromiseKit
import Alamofire
import SwiftyJSON


public final class TrailsKit {
    
    public static let sharedInstance = TrailsKit()
    
    public private(set) var cache : [Trail]?
    
    func getAllTrails(refresh refresh: Bool) -> Promise<[Trail]> {
        
        let thm =  TrailheadManager.sharedInstance
        
        if(thm.testMode) {
            return Promise {fulfill, reject in
                print("Using Trails Test Data")
                let trails = self.createTrailsFromTestData("trails")
                self.cache = trails
                fulfill(trails)
            }
            
        }
        else {
            return Promise { fulfill, reject in
                print("using: \(thm.getBaseURI()))/trails")
                Alamofire.request(.GET, thm.getBaseURI()+"/trails", headers: thm.getRequestHeaders())
                    .responseJSON { response in
                        switch response.result {
                        case .Success( _):
                            let trails = self.createTrails(response.data!)
                            self.cache = trails
                            fulfill(trails)
                        case .Failure(let error):
                            print(error)
                            reject(error)
                        }
                }
            }
        }
    }
    
    private func createTrails(data : NSData) -> [Trail] {
        var allTrails: [Trail] = []
        let j = JSON(data: data)
        
        let v = j["total_count"].int
        print("received \(v) records from Trailhead API")
        
        for (_, subJson) in j["data"] {
            allTrails.append(Trail(json: subJson))
        }
        return allTrails

    }
    
    private func createTrailsFromTestData(jsonfile: String) -> [Trail] {
        var allTrails: [Trail] = []
        let data = TestUtility.getJSONDataFromFile(jsonfile)
        let j = JSON(data: data)
        
        let v = j["total_count"].int
        print("received \(v) records from trails test json")
        
        for (_, subJson) in j["data"] {
            allTrails.append(Trail(json: subJson))
        }
      return allTrails
    }
    
     public func clear() {
        cache = nil
    }
    
}



