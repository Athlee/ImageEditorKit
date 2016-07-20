//
//  ImageFilter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

protocol ImageFilter: Filter {
  var image: UIImage { get set }
  var inputImage: CIImage? { get set }
}

extension ImageFilter {
  var ignoredProperties: [String] {
    return ["name", "image"]
  }
}