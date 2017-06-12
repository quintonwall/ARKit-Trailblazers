//
//  CGFloat.swift
//  Backpack
//
//  Created by QUINTON WALL on 9/20/16.
//  Copyright © 2016 QUINTON WALL. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}