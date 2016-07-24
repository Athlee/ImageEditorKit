//
//  FalseColorFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct FalseColorFilter: ColorEffectFilter {
  
  // MARK: Filter
  
  public let name = "CIFalseColor"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: ColorEffectFilter
  
  public var inputColor0: CIColor?
  public var inputColor1: CIColor?
  
  // MARK: Initialization
  
  public init(image: UIImage, inputColor0: UIColor, inputColor1: UIColor) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputColor0 = CIColor(color: inputColor0)
    self.inputColor1 = CIColor(color: inputColor1)
  }
  
}
