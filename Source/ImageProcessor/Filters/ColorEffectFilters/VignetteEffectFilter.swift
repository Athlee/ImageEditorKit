//
//  VignetteEffectFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct VignetteEffectFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  public let name = "CIVignetteEffect"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  public var inputCenter: CIVector?
  public var inputIntensity: NSNumber?
  public var inputRadius: NSNumber?
  
  // MARK: Initialization
  
  public init(image: UIImage,
       inputCenter: CGPoint = CGPoint(x: 150, y: 150),
       inputRadius: Float = 1.0,
       intensity: Float = 0.0) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputCenter = CIVector(cgPoint: inputCenter)
    self.inputRadius = NSNumber(value: inputRadius as Float)
    self.inputIntensity = NSNumber(value: intensity as Float)
  }
  
}
