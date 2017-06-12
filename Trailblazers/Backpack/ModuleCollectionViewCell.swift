//
//  ModuleCollectionViewCell.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/21/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import Spring

class ModuleCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var backingView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToCalendarButton: SpringButton!
   
    @IBOutlet weak var tagsLabel: UILabel!
    
    var title : String?{
        didSet {
            titleLabel.text = title
        }
    }
    
    var blurb : String? {
        didSet {
            descriptionLabel.text = blurb
        }
    }
    
    var badgeImageURL : String? {
        didSet {
            badgeImageView.sd_setImageWithURL(NSURL(string: badgeImageURL!))
        }
    }
    
    var isfavorite : Bool = false {
         didSet {
            if(isfavorite) {
                self.setFavoriteVisual()
            } else {
                self.setNotFavoriteVisual()
            }
        }
    }
    
    var duration : String?
    
    var module : Module?
    
    var tags : String? {
        didSet {
            tagsLabel.text = tags
        }
    }
    
    var color: UIColor? {
        didSet {
           // backingView.backgroundColor = color
           // backingView.layer.borderColor = color?.CGColor
           // backingView.layer.borderWidth = 1
        }
    }
    
    override func awakeFromNib() {
        backingView.layer.cornerRadius = 12
        backingView.layer.masksToBounds = true
    
    }
    @IBAction func addToCalendarTapped(sender: AnyObject) {
        let btn: SpringButton = sender as! SpringButton
        
        if(!isfavorite) {
             dispatch_async(dispatch_get_main_queue()) {
                self.setFavoriteVisual()
            }
            
            AppDefaults.addToFavorites(module!)
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                self.setNotFavoriteVisual()
            }
            AppDefaults.removeFromFavorites(module!)
        }
        btn.animation = "zoomOut"
        btn.animate()
        btn.animation = "zoomIn"
        btn.animate()
        
    }
        
    private func setFavoriteVisual() {
        addToCalendarButton.setImage(UIImage(named: "Red-Favorite"), forState: .Normal)
        addToCalendarButton.selected = true
    }
    
    private func setNotFavoriteVisual() {
        addToCalendarButton.setImage(UIImage(named: "favorite-nofill"), forState: .Normal)
        addToCalendarButton.selected = false
    }
    
}
