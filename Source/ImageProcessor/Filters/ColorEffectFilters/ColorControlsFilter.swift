//
//  ColorControlsFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct ColorControlsFilter: ColorAdjustmentFilter {
  
  // MARK: Filter
  
  let name = "CIColorControls"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: ColorAdjustmentFilter
  
  var inputSaturation: NSNumber?
  var inputBrightness: NSNumber?
  var inputContrast: NSNumber?
  
  // MARK: Initialization
  
  init(image: UIImage,
       inputSaturation: Float = 1.0,
       inputBrightness: Float,
       inputContrast: Float = 1.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputSaturation = NSNumber(float: inputSaturation)
    self.inputBrightness = NSNumber(float: inputBrightness)
    self.inputContrast = NSNumber(float: inputContrast)
  }
  
}