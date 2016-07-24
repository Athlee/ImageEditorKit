//
//  AffineClampFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct AffineClampFilter: TileEffect {
  
  // MARK: Filter
  
  public let name = "CIAffineClamp"
  
  // MARK: ImageFilter
  
  public var image: UIImage
  public var inputImage: CIImage?
  
  // MARK: TileEffect 
  
  public var inputTransform: NSValue?
  
  // MARK: Initialization
  
  init(image: UIImage, inputTransform: NSValue) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputTransform = inputTransform
  }
}