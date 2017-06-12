//
//  ModulesKit.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/20/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import Foundation
import SwiftlySalesforce
import PromiseKit
import Alamofire
import SwiftyJSON


public final class ModulesKit {
    
    public static let sharedInstance = ModulesKit()
    
    public private(set) var cache : [Module]?
    
    
    func getAllModules(refresh refresh: Bool) -> Promise<[Module]> {
        
        let thm =  TrailheadManager.sharedInstance
        
        if(thm.testMode) {
            return Promise {fulfill, reject in
                print("Using Modules Test Data")
                let modules = self.createModulesFromTestData("modules")
                self.cache = modules
                fulfill(modules)
            }
            
        }
        else {
            return Promise { fulfill, reject in
                print("using: \(thm.getBaseURI()))/modules")
                Alamofire.request(.GET, thm.getBaseURI()+"/modules", headers: thm.getRequestHeaders())
                    .responseJSON { response in
                        switch response.result {
                        case .Success( _):
                            let modules = self.createModules(response.data!)
                            self.cache = modules
                            fulfill(modules)
                        case .Failure(let error):
                            print(error)
                            reject(error)
                        }
                }
            }
        }
    }
    
    private func createModules(data : NSData) -> [Module] {
        var allModules: [Module] = []
        let j = JSON(data: data)
        
        let v = j["total_count"].int
        print("received \(v) modules from Trailhead API")
        
        for (_, subJson) in j["data"] {
            allModules.append(Module(json: subJson))
        }
        return allModules
        
    }
    
    private func createModulesFromTestData(jsonfile: String) -> [Module] {
        var allModules: [Module] = []
        let data = TestUtility.getJSONDataFromFile(jsonfile)
        let j = JSON(data: data)
        
        let v = j["total_count"].int
        print("received \(v) modules from modules test json")
        
        for (_, subJson) in j["data"] {
            allModules.append(Module(json: subJson))
        }
        return allModules
    }
    
    public func clear() {
        cache = nil
    }

}