//
//  UIColor.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 20/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

internal extension UIColor {
  convenience init(hex: Int) {
    let red = CGFloat((hex & 0xFF0000) >> 16) / CGFloat(255)
    let green = CGFloat((hex & 0xFF00) >> 8) / CGFloat(255)
    let blue = CGFloat((hex & 0xFF) >> 0) / CGFloat(255)
    
    self.init(red: red, green: green, blue: blue, alpha: 1)
  }
}
