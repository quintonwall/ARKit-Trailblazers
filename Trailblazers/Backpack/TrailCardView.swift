//
//  TrailCardView.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/15/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit

class TrailCardView : UIView {
    
   
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var blurb: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    
    
    
    func bind() {
        
        badgeImage.layer.cornerRadius = badgeImage.frame.size.height / 2
        badgeImage.layer.backgroundColor = AppColors.accentSky.CGColor
        badgeImage.layer.masksToBounds = true
        badgeImage.layer.borderColor = UIColor.whiteColor().CGColor
        badgeImage.layer.borderWidth = 3.0
    
    }
    
}
