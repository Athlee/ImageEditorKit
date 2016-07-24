//
//  CIVignette.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct VignetteFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  public let name = "CIVignette"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  public var inputIntensity: NSNumber?
  public var inputRadius: NSNumber?
  
  // MARK: Initialization
  
  public init(image: UIImage, inputRadius: Float = 1.0, intensity: Float = 0.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputRadius = NSNumber(float: inputRadius)
    self.inputIntensity = NSNumber(float: intensity)
  }
  
}