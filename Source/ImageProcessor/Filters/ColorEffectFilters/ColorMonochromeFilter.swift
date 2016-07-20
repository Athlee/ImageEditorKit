//
//  ColorMonochromeFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct ColorMonochromeFilter: ColorEffectFilter {
 
  // MARK: Filter
  
  let name = "CIColorMonochrome"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  var inputColor: CIColor?
  var inputIntensity: NSNumber?
  
  // MARK: Initialization
  
  init(image: UIImage, color: UIColor, intensity: Float = 1.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputColor = CIColor(color: color)
    self.inputIntensity = NSNumber(float: intensity)
  }
  
}
