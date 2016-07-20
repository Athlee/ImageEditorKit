//
//  FalseColorFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct FalseColorFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  let name = "CIFalseColor"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  var inputColor0: CIColor?
  var inputColor1: CIColor?
  
  // MARK: Initialization
  
  init(image: UIImage, inputColor0: UIColor, inputColor1: UIColor) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputColor0 = CIColor(color: inputColor0)
    self.inputColor1 = CIColor(color: inputColor1)
  }
  
}
