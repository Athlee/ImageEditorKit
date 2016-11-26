//
//  GaussianBlurFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct GaussianBlurFilter: BlurFilter {
  
  // MARK: Filter
  
  public let name = "CIGaussianBlur"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: BlurFilter
  
  public var inputRadius: NSNumber?
  
  public var inputMask: CIImage? = nil
  public var inputAngle: NSNumber? = nil
  public var inputNoiseLevel: NSNumber? = nil
  public var inputSharpness: NSNumber? = nil
  public var inputCenter: CIVector? = nil
  public var inputAmount: NSNumber? = nil
  
  // MARK: Initialization
  
  public init(image: UIImage, inputRadius: Float) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputRadius = NSNumber(value: inputRadius as Float)
  }
}

