//
//  Any.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import Foundation

internal func unwrapped(any: Any) -> Any {
  var value = any
  
  while true {
    let mirror = Mirror(reflecting: value)
    if let style = mirror.displayStyle where style == .Optional {
      guard let first = mirror.children.first else {
        break
      }
      
      value = first.value
    } else {
      break
    }
  }
  
  return value
}