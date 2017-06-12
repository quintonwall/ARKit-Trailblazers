//
//  WelcomeTourPageViewController.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/9/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import UIKit

class WelcomeTourPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    
    
    override func viewWillAppear(animated: Bool) {
        
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         arrPageTitle = ["Backpack helps you stay up to date on the latest trails, modules, and more.", "Save trails and modules to your todo list, and pick up on the web when you are ready.", "Never miss out on new trails or special badges ever again with push notifications.", "Show your Trailhead pride through emojis with the Trailhead custom keyboard.", "To get started, simply log into your Salesforce account and the trails with Backpack"];
        arrPagePhoto = ["astro_floating_head", "astro_clipboard_2", "astro_trailblazer", "astro_new_sash", "astro_holding_badges"];
        self.dataSource = self
        
        
        self.setViewControllers([getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index: Int
        
        if(viewController.isKindOfClass(WelcomeContentPageOne)) {
            let pageContent: WelcomeContentPageOne = viewController as! WelcomeContentPageOne
            index = pageContent.pageIndex
        } else {
            let pageContent: WelcomeContentViewController = viewController as! WelcomeContentViewController
            index = pageContent.pageIndex
        }
        
        
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
         var index: Int
        
        if(viewController.isKindOfClass(WelcomeContentPageOne)) {
            let pageContent: WelcomeContentPageOne = viewController as! WelcomeContentPageOne
            index = pageContent.pageIndex
        } else {
            let pageContent: WelcomeContentViewController = viewController as! WelcomeContentViewController
            index = pageContent.pageIndex
        }
        
        if (index == NSNotFound)
        {
            return nil;
        }
        index += 1;
        if (index == arrPageTitle.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index)
    
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> UIViewController
    {
        
        //first page is different
        if(index == 0) {
            let p1Controller = self.storyboard?.instantiateViewControllerWithIdentifier("WelcomeContentPageOne") as! WelcomeContentPageOne
            p1Controller.pageIndex = index
            p1Controller.strTitle = "\(arrPageTitle[index])"
            p1Controller.strPhotoName = "\(arrPagePhoto[index])"
            return p1Controller
        } else {
        // Create a new view controller and pass suitable data.
            let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WelcomeContent") as! WelcomeContentViewController
            pageContentViewController.strTitle = "\(arrPageTitle[index])"
            pageContentViewController.strPhotoName = "\(arrPagePhoto[index])"
            pageContentViewController.pageIndex = index
            
            //if we are at the last page of the tour show the get started button.
            if(index == arrPageTitle.count-1) {
                pageContentViewController.hideGetStartedButton = false
            } else {
                pageContentViewController.hideGetStartedButton = true
            }
            return pageContentViewController
        }
    }
    
}
