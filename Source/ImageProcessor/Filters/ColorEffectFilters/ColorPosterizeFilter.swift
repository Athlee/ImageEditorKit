//
//  ColorPosterizeFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct ColorPosterizeFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  let name = "CIColorPosterize"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  var inputLevels: NSNumber?
  
  // MARK: Initialization
  
  init(image: UIImage, inputLevels: Float = 6.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputLevels = NSNumber(float: inputLevels)
  }
  
}
