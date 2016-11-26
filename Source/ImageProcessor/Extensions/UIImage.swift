//
//  UIImage.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

typealias _CIImage = CIImage

internal extension UIImage {
  var extent: CGRect {
    guard let image = cgImage else {
      return .zero
    }
    
    return _CIImage(cgImage: image).extent
  }
}
