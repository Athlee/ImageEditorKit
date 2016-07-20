//
//  SepiaToneFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct SepiaToneFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  let name = "CISepiaTone"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  var inputIntensity: NSNumber?
  
  // MARK: Initialization
  
  init(image: UIImage, intensity: Float = 1.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputIntensity = NSNumber(float: intensity)
  }
  
}