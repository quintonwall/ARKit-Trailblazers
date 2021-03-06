//
//  Tag.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/19/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Tag : TrailheadObject{
    
    public init(json: JSON) {
        super.init(objectType: TrailheadObjectType.Tag)
        id = json["id"].intValue
        title = json["title"].stringValue
    }
}