//
//  ColorMonochromeFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct ColorMonochromeFilter: ColorEffectFilter {
 
  // MARK: Filter
  
  public let name = "CIColorMonochrome"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  public var inputColor: CIColor?
  public var inputIntensity: NSNumber?
  
  // MARK: Initialization
  
  public init(image: UIImage, color: UIColor, intensity: Float = 1.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputColor = CIColor(color: color)
    self.inputIntensity = NSNumber(value: intensity as Float)
  }
  
}
