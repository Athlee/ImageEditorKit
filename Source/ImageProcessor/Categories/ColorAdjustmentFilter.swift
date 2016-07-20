//
//  ColorAdjustmentFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

protocol ColorAdjustmentFilter: ImageFilter {
  var inputMinComponents: CIVector? { get set }
  var inputMaxComponents: CIVector? { get set }
  var inputSaturation: NSNumber? { get set }
  var inputBrightness: NSNumber? { get set }
  var inputContrast: NSNumber? { get set }
  var inputRVector: CIVector? { get set }
  var inputGVector: CIVector? { get set }
  var inputBVector: CIVector? { get set }
  var inputAVector: CIVector? { get set }
  var inputBiasVector: CIVector? { get set }
  var inputRedCoefficients: CIVector? { get set }
  var inputGreenCoefficients: CIVector? { get set }
  var inputBlueCoefficients: CIVector? { get set }
  var inputAlphaCoefficients: CIVector? { get set }
  var inputEV: NSNumber? { get set }
  var inputPower: NSNumber? { get set }
  var inputAngle: NSNumber? { get set }
  var inputNeutral: CIVector? { get set }
  var inputTargetNeutral: CIVector? { get set }
  var inputPoint0: CIVector? { get set }
  var inputPoint1: CIVector? { get set }
  var inputPoint2: CIVector? { get set }
  var inputPoint3: CIVector? { get set }
  var inputPoint4: CIVector? { get set }
  var inputAmount: NSNumber? { get set }
  var inputColor: CIColor? { get set }
}

extension ColorAdjustmentFilter {
  var inputMinComponents: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputMaxComponents: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputSaturation: NSNumber? {
    get {
      return nil
    }
    
    set { }
  }
  
  
  var inputBrightness: NSNumber? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputContrast: NSNumber? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputRVector: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputGVector: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputBVector: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputAVector: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputBiasVector: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputRedCoefficients: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputGreenCoefficients: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputBlueCoefficients: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputAlphaCoefficients: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputEV: NSNumber? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputPower: NSNumber? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputAngle: NSNumber? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputNeutral: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputTargetNeutral: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputPoint0: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputPoint1: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputPoint2: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputPoint3: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputPoint4: CIVector? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputAmount: NSNumber? {
    get {
      return nil
    }
    
    set { }
  }
  
  var inputColor: CIColor? {
    get {
      return nil
    }
    
    set { }
  }
}