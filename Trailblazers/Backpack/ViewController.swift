//
// Home screen for the app.
//  ViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/9/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import UIKit
import SwiftlySalesforce


class ViewController: ProtectedUIViewController {
    
    @IBOutlet weak var bgImage: UIImageView!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        bgImage.blurImage()
    }

    
    
    @IBAction func hamburgerTapped(sender: AnyObject) {
        toggleSideMenuView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

