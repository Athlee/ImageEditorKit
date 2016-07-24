//
//  BlurFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public protocol BlurFilter: ImageFilter {
  var inputRadius: NSNumber? { get set }
  var inputMask: CIImage? { get set }
  var inputAngle: NSNumber? { get set }
  var inputNoiseLevel: NSNumber? { get set }
  var inputSharpness: NSNumber? { get set }
  var inputCenter: CIVector? { get set }
  var inputAmount: NSNumber? { get set }
}