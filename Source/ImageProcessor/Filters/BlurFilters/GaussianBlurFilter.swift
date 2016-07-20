//
//  GaussianBlurFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct GaussianBlurFilter: BlurFilter {
  
  // MARK: Filter
  
  let name = "CIGaussianBlur"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: BlurFilter
  
  var inputRadius: NSNumber?
  
  var inputMask: CIImage? = nil
  var inputAngle: NSNumber? = nil
  var inputNoiseLevel: NSNumber? = nil
  var inputSharpness: NSNumber? = nil
  var inputCenter: CIVector? = nil
  var inputAmount: NSNumber? = nil
  
  // MARK: Initialization
  
  init(image: UIImage, inputRadius: Float) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputRadius = NSNumber(float: inputRadius)
  }
}

