//
//  UnitTableViewCell.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/22/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit

class UnitTableViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var challengeTimeLabel: UILabel!
    
    
    var unit : Unit?
    var title : String? {
        didSet {
             self.titleLabel.text = title
        }
    }
    var duration : String? {
        didSet {
            self.challengeTimeLabel.text = duration
        }
    }

    
    
   
}
