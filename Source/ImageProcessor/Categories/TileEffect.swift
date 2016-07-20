//
//  TileEffect.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import CoreImage

protocol TileEffect: ImageFilter {
  var inputTransform: NSValue? { get set }
  var inputCenter: CIVector? { get set }
  var inputAngle: NSNumber? { get set }
  var inputAcuteAngle: NSNumber? { get set }
  var inputWidth: NSNumber? { get set }
  var inputCount: NSNumber? { get set }
  var inputScale: NSNumber? { get set }
  var inputTopLeft: CIVector? { get set }
  var inputTopRight: CIVector? { get set }
  var inputBottomRight: CIVector? { get set }
  var inputBottomLeft: CIVector? { get set }
  var inputPoint: CIVector? { get set }
  var inputSize: NSNumber? { get set }
  var inputRotation: NSNumber? { get set }
  var inputDecay: NSNumber? { get set }
}