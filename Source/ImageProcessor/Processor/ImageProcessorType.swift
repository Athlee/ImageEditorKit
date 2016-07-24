//
//  ImageProcessorType.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

public protocol ImageProcessorType {
  func process<T : Filter>(image image: UIImage, filter: T, completion: (UIImage?) -> Void)
}
