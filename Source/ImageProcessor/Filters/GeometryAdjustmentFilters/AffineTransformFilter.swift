//
//  AffineTransformFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct AffineTransformFilter: GeometryAdjustment {
  public var image: UIImage
  public var inputImage: CIImage?
  public var inputTransform: NSValue?
  
  public let name = "CIAffineTransform"
  
  public init(image: UIImage, inputTransform: CGAffineTransform) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputTransform = NSValue(CGAffineTransform: inputTransform)
  }
}