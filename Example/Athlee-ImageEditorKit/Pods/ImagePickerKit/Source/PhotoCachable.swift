//
//  PhotoCachable.swift
//  Cropable
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import Photos

///
/// Provides caching capabilities.
///
public protocol PhotoCachable: class {
  /// A caching image manager doing all the job.
  var cachingImageManager: PHCachingImageManager { get set }
  
  /// A rectangle area that was previously visible.
  var previousPreheatRect: CGRect { get set }
  
  ///
  /// Resets all cached assets.
  ///
  func resetCachedAssets()
  
  ///
  /// Updates the assets for a given rect area and target size.
  ///
  /// - parameter rect: A given area to update assets from. 
  /// - parameter targetSize: A visible size for assets. 
  ///
  func updateCachedAssets(for rect: CGRect, targetSize: CGSize)
  
  ///
  /// Provides assets for a given rect area.
  ///
  /// - parameter rect: An area to get assets from. 
  /// - returns: An array with assets found. 
  ///
  func cachingAssets(at rect: CGRect) -> [PHAsset]
}

// MARK: - Default implementations 

public extension PhotoCachable {
  ///
  /// Resets all cached assets.
  ///
  func resetCachedAssets() {
    cachingImageManager.stopCachingImagesForAllAssets()
    previousPreheatRect = CGRect.zero
  }
  
  ///
  /// Updates the assets for a given rect area and target size.
  ///
  /// - parameter rect: A given area to update assets from.
  /// - parameter targetSize: A visible size for assets.
  ///
  func updateCachedAssets(for rect: CGRect, targetSize: CGSize) {
    let bounds = rect
    let preheatRect = bounds.insetBy(dx: 0, dy: -0.5 * bounds.height)
    let delta = abs(preheatRect.midY - previousPreheatRect.midY)
    
    if delta > bounds.height / 3.0 {
      let difference = previousPreheatRect.difference(with: preheatRect)
      
      var assetsToStartCaching: [PHAsset] = []
      var assetsToStopCaching: [PHAsset] = []
      
      difference.forEach { diff in
        if case .added(let area) = diff {
          assetsToStartCaching += self.cachingAssets(at: area)
        } else if case .removed(let area) = diff {
          assetsToStopCaching += self.cachingAssets(at: area)
        }
      }
      
      
      cachingImageManager.startCachingImages(for: assetsToStartCaching,
                                                      targetSize: targetSize,
                                                      contentMode: .aspectFill,
                                                      options: nil)
      
      cachingImageManager.stopCachingImages(for: assetsToStopCaching,
                                                     targetSize: targetSize,
                                                     contentMode: .aspectFill,
                                                     options: nil)
      
      previousPreheatRect = preheatRect
    }
  }
}

// MARK: - Util methods 

public extension PhotoCachable {
  ///
  /// Collects assets with provided index paths in the fetch result.
  ///
  /// - parameter indexPaths: The index paths to get indices from. 
  /// - parameter fetchResult: Current fetch result object. 
  /// - returns: An array with assets found.
  /// 
  func assets(at indexPaths: [IndexPath], in fetchResult: PHFetchResult<AnyObject>) -> [PHAsset] {
    guard indexPaths.count > 0 else {
      return []
    }
    
    let assets = indexPaths.map { fetchResult[$0.item] as! PHAsset }
    
    return assets
  }
}
