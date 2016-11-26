//
//  ColorPosterizeFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct ColorPosterizeFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  public let name = "CIColorPosterize"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  public var inputLevels: NSNumber?
  
  // MARK: Initialization
  
  public init(image: UIImage, inputLevels: Float = 6.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputLevels = NSNumber(value: inputLevels as Float)
  }
  
}
