//
//  CIVignette.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct VignetteFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  let name = "CIVignette"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  var inputIntensity: NSNumber?
  var inputRadius: NSNumber?
  
  // MARK: Initialization
  
  init(image: UIImage, inputRadius: Float = 1.0, intensity: Float = 0.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputRadius = NSNumber(float: inputRadius)
    self.inputIntensity = NSNumber(float: intensity)
  }
  
}