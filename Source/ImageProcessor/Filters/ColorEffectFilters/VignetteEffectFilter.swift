//
//  VignetteEffectFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct VignetteEffectFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  let name = "CIVignetteEffect"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  var inputCenter: CIVector?
  var inputIntensity: NSNumber?
  var inputRadius: NSNumber?
  
  // MARK: Initialization
  
  init(image: UIImage,
       inputCenter: CGPoint = CGPoint(x: 150, y: 150),
       inputRadius: Float = 1.0,
       intensity: Float = 0.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputCenter = CIVector(CGPoint: inputCenter)
    self.inputRadius = NSNumber(float: inputRadius)
    self.inputIntensity = NSNumber(float: intensity)
  }
  
}