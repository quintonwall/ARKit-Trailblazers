//
//  NotImplementedUIViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/20/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import Spring
import YouTubePlayer

class NotImplementedUIViewController : ProtectedUIViewController {
    
    @IBAction func hamburgerTapped(sender: AnyObject) {
        toggleSideMenuView()
    }
    @IBOutlet weak var hardHatBtn: SpringButton!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    
    
    override func viewWillAppear(animated: Bool) {
        youtubeView.backgroundColor = UIColor.clearColor()
        youtubeView.hidden = true
    }
    @IBAction func hadHatTapped(sender: AnyObject) {
        youtubeView.hidden = false
        hardHatBtn.animation = "wobble"
        hardHatBtn.duration  = 10.0
         hardHatBtn.animate()
        youtubeView.loadVideoID("DK0iRe812bg")
       
        
    }
}