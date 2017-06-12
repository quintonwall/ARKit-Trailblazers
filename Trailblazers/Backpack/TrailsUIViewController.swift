//
//  TrailsUIViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/13/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import RGCardViewLayout
import SDWebImage


class TrailsUIViewController : ProtectedUIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    


    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    private var _subViews = [UIView]()
    private var allTrails : [Trail] = []
    
    @IBAction func hamburgerTapped(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
      
        
        
        let tk = TrailsKit.sharedInstance
        tk.getAllTrails(refresh: true)
        
        collectionView.reloadData()
        
        /*
        
        let v : TrailCardView = UIView.loadFromNibNamed("TrailCard") as! TrailCardView
        //v.backgroundColor = UIColor.brownColor()
        v.bind()
        let v1 : TrailCardView = UIView.loadFromNibNamed("TrailCard") as! TrailCardView
        v1.bind()
        // v1.backgroundColor = UIColor.yellowColor()
        let v2 : TrailCardView = UIView.loadFromNibNamed("TrailCard") as! TrailCardView
        v2.bind()
        // v2.backgroundColor = UIColor.cyanColor()
        
        
        
        _subViews.append(v)
        _subViews.append(v1)
        _subViews.append(v2)
        */
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return TrailsKit.sharedInstance.cache?.count ?? 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("trailcell", forIndexPath: indexPath) as! TrailCollectionViewCell
        
        self.configureCell(cell, indexPath: indexPath)
        return cell

    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TrailCollectionViewCell
        print("You selected \(cell.title.text)")
        performSegueWithIdentifier("showModules", sender: cell)
        return false
    }
    
    
    
    
    private func configureCell(cell: TrailCollectionViewCell, indexPath: NSIndexPath) {
        if let trail = TrailsKit.sharedInstance.cache?[indexPath.section] {
            cell.title.text = trail.title
            cell.blurb.text = trail.descriptionHTML
            cell.headerView.backgroundColor = trail.headerColor
            cell.headerImage.sd_setImageWithURL(NSURL(string: trail.iconUrl!), placeholderImage: UIImage(named: "astro_floating_head"))
            cell.headerImage.layer.backgroundColor = trail.headerColor?.CGColor
            cell.duration.text = trail.challengeTimeFormatted
            cell.tags.text = trail.levelsFormatted
            cell.trail = trail
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        assert(sender as? TrailCollectionViewCell != nil, "sender is not a trail cell")
        
        let selectedCell = sender as? TrailCollectionViewCell
        
        if segue.identifier == "showModules" {
                
                let detailVC: ModulesUIViewController = segue.destinationViewController as! ModulesUIViewController
                detailVC.modules = selectedCell!.trail.modules
                detailVC.fromTrail = selectedCell!.trail
            
            }
        }
 
    
}





