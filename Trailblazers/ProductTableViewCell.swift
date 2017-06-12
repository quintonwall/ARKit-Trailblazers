//
//  ProductTableViewCell.swift
//  Trailblazers
//
//  Created by QUINTON WALL on 6/10/17.
//  Copyright © 2017 me.quinton. All rights reserved.
//

import Foundation
import UIKit

class ProductTableViewCell : UITableViewCell {
    
    var product : Product! {
        didSet {
            self.productImage.image = UIImage(named: product.imageName)
            self.productName.text = product.name
        }
    }
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
}
