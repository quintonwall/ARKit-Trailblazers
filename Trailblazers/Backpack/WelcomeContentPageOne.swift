//
//  WelcomeContentPageOne.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/9/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit

class WelcomeContentPageOne: UIViewController {
    
    @IBOutlet weak var tourImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleMessage: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var pageIndicatorControl: UIPageControl!
    
    var pageIndex: Int = 0
    
    var strTitle: String!
    var strPhotoName: String!
    var hideGetStartedButton : Bool!
    
    override func viewDidLoad()
    {
       	super.viewDidLoad()
        
        
        
        
        
        
        //backgroundImage.image = UIImage(named: "default_bg")
        //backgroundImage.blurImageLightly()
        
        titleMessage.text = strTitle
        
        pageIndicatorControl.currentPage = pageIndex
        
        
        
        
    }
    
    
}