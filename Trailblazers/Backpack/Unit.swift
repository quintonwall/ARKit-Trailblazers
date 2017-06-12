//
//  Unit.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/19/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Unit : TrailheadObject{
    
     public var descriptionHTML: String?
    //public var builtDate: NSDate?
    public var headerColor: UIColor?
     public var totalPoints: Int?
    public var archived: Bool?
    public var tags : [Tag] = []
    public var roles : [Role] = []
    public var products : [Product] = []
    public var levels : [Level] = []
    
    public var challengeTimeMins : Int = 0
    public var challengeTimeFormatted : String?
    public var tagsFormatted : String?
    public var levelsFormatted : String?
    
    
    
    
    public init(json: JSON) {
        super.init(objectType: TrailheadObjectType.Unit)
        id = json["id"].intValue
        title = json["title"].stringValue
        descriptionHTML = json["description_html"].stringValue
        webUrl = NSURL(string: json["web_url"].stringValue)
        challengeTimeMins = json["challenge_time"].intValue
        challengeTimeFormatted = challengeTimeToFormattedString(challengeTimeMins)

        totalPoints = json["total_points"].intValue
        archived = json["archived"].boolValue
        headerColor = UIColor.randomColor()
        
        
        
        for (_, subJson) in json["tags"] {
            tags.append(Tag(json: subJson))
        }
        tagsFormatted = arrayToFormattedTitles(tags, delimiter: ",")
        
        for (_, subJson) in json["roles"] {
            roles.append(Role(json: subJson))
        }
        
        for (_, subJson) in json["products"] {
            products.append(Product(json: subJson))
        }
        
        for (_, subJson) in json["levels"] {
            levels.append(Level(json: subJson))
        }
        levelsFormatted = arrayToFormattedTitles(levels, delimiter: "|")

    }
}