//
//  GeometryAdjustment.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

protocol GeometryAdjustment: ImageFilter {
  var inputTransform: NSValue? { get set }
}