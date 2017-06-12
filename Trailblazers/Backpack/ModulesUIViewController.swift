//
//  ModulesUIViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/20/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class ModulesUIViewController : ProtectedUIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var trailStanza: UIView!
    @IBOutlet weak var backToTrailButton: UIButton!
    
    var modules : [Module] = []
    var fromTrail : Trail?
    
    @IBAction func hamburgerTapped(sender: AnyObject) {
        toggleSideMenuView()
    }

    @IBAction func backToTrailTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let mk = ModulesKit.sharedInstance
        
        if fromTrail != nil {
            print("We came from a trail")
            trailStanza.hidden = false
            trailStanza.backgroundColor = fromTrail?.headerColor
            backToTrailButton.setTitle(fromTrail?.title, forState: .Normal)
        } else {
            trailStanza.hidden = true
            mk.getAllModules(refresh: true)
            modules = ModulesKit.sharedInstance.cache!
            
        }
        
        collectionView.reloadData()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        assert(sender as? ModuleCollectionViewCell != nil, "sender is not a trail cell")
        
        let selectedCell = sender as? ModuleCollectionViewCell
        
        if segue.identifier == "showModulesUnits" {
            
           let detailVC: UnitsUIViewController = segue.destinationViewController as! UnitsUIViewController
            detailVC.module = selectedCell!.module
            if fromTrail != nil {
                detailVC.trail = fromTrail
            }
            
        }
    }

   
}

extension ModulesUIViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ModuleCollectionViewCell
        print("You selected \(cell.module?.title)")
        performSegueWithIdentifier("showModulesUnits", sender: cell)
        return false
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modules.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("modulecell", forIndexPath: indexPath) as! ModuleCollectionViewCell
        self.configureCell(cell, indexPath: indexPath)
        return cell
       
    }
    
    func configureCell(cell: ModuleCollectionViewCell, indexPath: NSIndexPath) {
        let m =  modules[indexPath.item]
        cell.badgeImageURL = m.badgeIconURL
        cell.blurb = m.descriptionHTML
        cell.title = m.title
        cell.tags = m.levelsFormatted
        cell.module = m
        cell.color = fromTrail?.headerColor
        let favs = AppDefaults.getFavorites()
        if(favs.contains(m.id!)) {
            cell.isfavorite = true
        } else {
            cell.isfavorite = false
        }
    }
}