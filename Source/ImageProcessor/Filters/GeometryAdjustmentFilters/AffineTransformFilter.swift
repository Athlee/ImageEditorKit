//
//  AffineTransformFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct AffineTransformFilter: GeometryAdjustment {
  var image: UIImage
  var inputImage: CIImage?
  var inputTransform: NSValue?
  
  let name = "CIAffineTransform"
  
  init(image: UIImage, inputTransform: CGAffineTransform) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputTransform = NSValue(CGAffineTransform: inputTransform)
  }
}