//
//  Scanable.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import Foundation

public protocol Scanable {
  var ignoredProperties: [String] { get }
  
  func scanned() -> [String: Any]
}

public extension Scanable {
  func scanned() -> [String: Any] {
    let mirror = Mirror(reflecting: self)
    var result: [String: Any] = [:]
    
    for child in mirror.children {
      guard let label = child.label else {
        continue
      }
      
      if !ignoredProperties.contains(label) {
        result[label] = unwrapped(child.value)
      }
    }
    
    return result
  }
}