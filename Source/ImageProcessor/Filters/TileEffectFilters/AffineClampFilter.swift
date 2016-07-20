//
//  AffineClampFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

struct AffineClampFilter: TileEffect {
  
  // MARK: Filter
  
  let name = "CIAffineClamp"
  
  // MARK: ImageFilter
  
  var image: UIImage
  var inputImage: CIImage?
  
  // MARK: TileEffect 
  
  var inputTransform: NSValue?
  
  var inputCenter: CIVector? = nil
  var inputAngle: NSNumber? = nil
  var inputAcuteAngle: NSNumber? = nil
  var inputWidth: NSNumber? = nil
  var inputCount: NSNumber? = nil
  var inputScale: NSNumber? = nil
  var inputTopLeft: CIVector? = nil
  var inputTopRight: CIVector? = nil
  var inputBottomRight: CIVector? = nil
  var inputBottomLeft: CIVector? = nil
  var inputPoint: CIVector? = nil
  var inputSize: NSNumber? = nil
  var inputRotation: NSNumber? = nil
  var inputDecay: NSNumber? = nil
  
  // MARK: Initialization
  
  init(image: UIImage, inputTransform: NSValue) {
    self.image = image
    self.inputImage = CIImage(image: image)
    self.inputTransform = inputTransform
  }
}