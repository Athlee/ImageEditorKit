//
//  ErrorPrinter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import Foundation

public struct FilterErrorPrinter {
  public static func printError(error: FilterError) {
    let message: String
    switch error {
    case .FilterDoesNotExist(let name):
      message = "Unable to find filter in CoreFilter library named: \(name)."
    }
    
    print(message)
  }
}