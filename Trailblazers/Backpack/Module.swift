//
//  Module.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/19/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Module : TrailheadObject{
    
    public var badgeIconURL: String?
    public var descriptionHTML: String?
    public var headerColor: UIColor?
    //public var builtDate: NSDate?
    public var badgeTitle: String?
    public var archived: Bool?
    public var tags : [Tag] = []
    public var roles : [Role] = []
    public var products : [Product] = []
    public var levels : [Level] = []
    public var units : [Unit] = []
    public var challengeTimeMins : Int = 0
    public var challengeTimeFormatted : String?
    public var tagsFormatted : String?
    public var levelsFormatted : String?
    
    

    
    
    public init(json: JSON) {
        super.init(objectType: TrailheadObjectType.Module)
        id = json["id"].intValue
        title = json["title"].stringValue
        badgeIconURL = json["badge_icon"].stringValue
        descriptionHTML = json["description_html"].stringValue
        badgeTitle = json["badge_title"].stringValue
        webUrl = NSURL(string: json["web_url"].stringValue)
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
        
        for (_, subJson) in json["units"] {
            let u = Unit(json: subJson)
            challengeTimeMins += u.challengeTimeMins ?? 0
            units.append(u)
        }
         challengeTimeFormatted = challengeTimeToFormattedString(challengeTimeMins)
        
    }
}