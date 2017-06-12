//
//  TrailCollectionViewCell.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/19/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import Spring

class TrailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImage: UIImageView! {
        didSet {
            headerImage.layer.cornerRadius = headerImage.frame.size.height / 2
             headerImage.layer.masksToBounds = true
            headerImage.layer.borderColor = UIColor.whiteColor().CGColor
            headerImage.layer.borderWidth = 3.0

        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var blurb: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    
    var trail : Trail!
    
    

}
