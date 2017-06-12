//
//  Product.swift
//  Trailblazers
//
//  Created by QUINTON WALL on 6/10/17.
//  Copyright © 2017 me.quinton. All rights reserved.
//

import Foundation


public struct Product {
    var id: String = ""
    var name: String = ""
    var imageName: String = ""
    var price: Double = 0
    
    public init() {}
    
    public init(dictionary: [String: Any]) {
        for(key, value) in dictionary {
            switch key.lowercased() {
            case "id":
                self.id = (value as? String)!
            case "name":
                self.name = (value as? String)!
            case "imageName":
                self.imageName = (value as? String)!
            case "price":
                self.price = (value as? Double)!
            default:
                continue
            }
        }
    }
    
    
    
}
