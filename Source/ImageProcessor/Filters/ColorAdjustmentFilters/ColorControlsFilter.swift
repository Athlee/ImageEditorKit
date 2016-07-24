//
//  ColorControlsFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct ColorControlsFilter: ColorAdjustmentFilter {
  
  // MARK: Filter
  
  public let name = "CIColorControls"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: ColorAdjustmentFilter
  
  public var inputSaturation: NSNumber?
  public var inputBrightness: NSNumber?
  public var inputContrast: NSNumber?
  
  // MARK: Initialization
  
  public init(image: UIImage,
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