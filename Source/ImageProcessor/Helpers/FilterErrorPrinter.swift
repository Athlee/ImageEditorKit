//
//  ErrorPrinter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import Foundation

public struct FilterErrorPrinter {
  public static func printError(_ error: FilterError) {
    let message: String
    switch error {
    case .filterDoesNotExist(let name):
      message = "Unable to find filter in CoreFilter library named: \(name)."
    }
    
    print(message)
  }
}
