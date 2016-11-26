//
//  SepiaToneFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct SepiaToneFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  public let name = "CISepiaTone"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  public var inputIntensity: NSNumber?
  
  // MARK: Initialization
  
  public init(image: UIImage, intensity: Float = 1.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputIntensity = NSNumber(value: intensity as Float)
  }
  
}
