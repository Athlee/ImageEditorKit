//
//  PhotoFetcher.swift
//  Cropable
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import Photos

///
/// Provides photos' fetching features.
///
public protocol PhotoFetchable {
  /// Current fetch result object.
  var fetchResult: PHFetchResult<PHAsset> { get set }
  
  ///
  /// Checks if a user has given permission to use
  /// her photo assets for the app.
  ///
  func checkPhotoAuth()
}
