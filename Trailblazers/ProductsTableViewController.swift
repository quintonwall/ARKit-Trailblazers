//
//  ProductsTableViewController.swift
//  Trailblazers
//
//  Created by QUINTON WALL on 6/10/17.
//  Copyright © 2017 me.quinton. All rights reserved.
//

import Foundation
import UIKit


class ProductsTableViewController : UITableViewController {
    
    
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Products"
        fetchProducts()
        self.tableView.reloadData()
    }
    
    
    func fetchProducts() {
        var p1 : Product = Product()
        p1.id = "1"
        p1.imageName = "backpack"
        p1.name = "Aurora Backpack"
        p1.price = 110
        products.append(p1)
        
        var p2 : Product = Product()
        p2.id = "2"
        p2.imageName = "camping"
        p2.name = "Stars Tent"
        p2.price = 299
        products.append(p2)
        
        var p3 : Product = Product()
        p3.id = "3"
        p3.imageName = "sleepingbags"
        p3.name = "Sleeping Bag"
        p3.price = 239
        products.append(p3)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let prod : Product = products[indexPath.row]
        cell.product = prod
        //cell.productImage = UIImageView(image: UIImage(named: "backpack"))
        //cell.productName.text = prod.name
        
        return cell
    }
    
}
