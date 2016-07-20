//
//  ColorEffectFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

protocol ColorEffectFilter: ImageFilter {
  var inputRedCoefficients: CIVector? { get set }
  var inputGreenCoefficients: CIVector? { get set }
  var inputBlueCoefficients: CIVector? { get set }
  var inputCubeDimension: NSNumber? { get set }
  var inputCubeData: NSData? { get set }
  var inputColorSpace: CGColorSpaceRef? { get set }
  var inputGradientImage: CIImage? { get set }
  var inputColor: CIColor? { get set }
  var inputIntensity: NSNumber? { get set }
  var inputLevels: NSNumber? { get set }
  var inputColor0: CIColor? { get set }
  var inputColor1: CIColor? { get set }
  var inputCenter: CIVector? { get set }
  var inputRadius: NSNumber? { get set }
}

extension ColorEffectFilter {
  var inputRedCoefficients: CIVector? {
    get { return nil }
    set { }
  }
  
  var inputGreenCoefficients: CIVector? {
    get { return nil }
    set { }
  }
  
  var inputBlueCoefficients: CIVector? {
    get { return nil }
    set { }
  }
  
  var inputCubeDimension: NSNumber? {
    get { return nil }
    set { }
  }
  
  var inputCubeData: NSData? {
    get { return nil }
    set { }
  }
  
  var inputColorSpace: CGColorSpaceRef? {
    get { return nil }
    set { }
  }
  
  var inputGradientImage: CIImage? {
    get { return nil }
    set { }
  }
  
  var inputColor: CIColor? {
    get { return nil }
    set { }
  }
  
  var inputIntensity: NSNumber? {
    get { return nil }
    set { }
  }
  
  var inputLevels: NSNumber? {
    get { return nil }
    set { }
  }
  
  var inputColor0: CIColor? {
    get { return nil }
    set { }
  }
  
  var inputColor1: CIColor? {
    get { return nil }
    set { }
  }
  
  var inputCenter: CIVector? {
    get { return nil }
    set { }
  }
  
  var inputRadius: NSNumber? {
    get { return nil }
    set { }
  }
}