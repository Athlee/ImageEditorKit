//
//  ImageProcessor.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

public struct ImageProcessor: ImageProcessorType {
  
  private class Store {
    var filters: [String: CIFilter] = [:]
    
    private lazy var queue: NSOperationQueue = {
      let queue = NSOperationQueue()
      queue.maxConcurrentOperationCount = 1
      return queue
    }()
  }
  
  // MARK: Properties
  
  private let context = CIContext()
  private let store = Store()
  private var queue: NSOperationQueue {
    return store.queue
  }
  
  // MARK: ImageProcessorType properties
  
  public func process<T : Filter>(image image: UIImage, filter: T, completion: (UIImage?) -> Void) {
    print("[ImageProcessor]: Unable to find appropriate processing method's overload...")
  }
  
  // MARK: BlurFilter
  
  public func process<T : BlurFilter>(image image: UIImage,
               filter: T,
               completion: (UIImage?) -> Void) {
    let transformValue = NSValue(CGAffineTransform: CGAffineTransformMakeScale(1, 1))
    let transform = AffineClampFilter(image: image, inputTransform: transformValue)
    
    add(filter: filter)
    add(filter: transform)
    
    let _scaleResult = processedImageResult(with: image, filter: transform) { image, _filter in
      self.setValues(for: _filter, with: transform)
    }
    
    guard let scaleResult = _scaleResult else {
      completion(nil)
      return
    }
    
    let _result = processedImageResult(with: scaleResult.image, filter: filter) { (image, _filter) in
      var updatedFilter = filter
      updatedFilter.inputImage = scaleResult.image
      self.setValues(for: _filter, with: updatedFilter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }

    queue.cancelAllOperations()
    queue.addOperationWithBlock {
      let output = self.convertedImage(from: result.image, extent: scaleResult.originalExtent)
      completion(output)
    }
  }
  
  // MARK: TileEffect
  
  public func process<T : TileEffect>(image image: UIImage,
               filter: T,
               completion: (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperationWithBlock {
      let output = self.convertedImage(from: result.image, extent: filter.inputImage?.extent ?? .zero)
      completion(output)
    }
  }
  
  // MARK: ColorEffectFilters
  
  public func process<T : ColorEffectFilter>(image image: UIImage,
               filter: T,
               completion: (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperationWithBlock {
      let output = self.convertedImage(from: result.image, extent: filter.inputImage?.extent ?? .zero)
      completion(output)
    }
  }
  
  // MARK: ColorAdjustment 
  
  public func process<T : ColorAdjustmentFilter>(image image: UIImage,
               filter: T,
               completion: (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperationWithBlock {
      let output = self.convertedImage(from: result.image, extent: filter.inputImage?.extent ?? .zero)
      completion(output)
    }
  }
  
  // MARK: GeometryAdjustment
  
  public func process<T : GeometryAdjustment>(image image: UIImage,
               filter: T,
               completion: (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperationWithBlock {
      let output = self.convertedImage(from: result.image, extent: filter.inputImage?.extent ?? .zero)
      completion(output)
    }
  }
  
  // MARK: Processing CIImage
  
  public typealias Result = (image: CIImage, originalExtent: CGRect)
  public typealias Setup = (CIImage, CIFilter) -> Void
  
  public func processedImageResult<T : Filter>(with image: UIImage,
                            filter: T,
                            setup: Setup) -> Result? {
    guard let image = preparedImage(with: image, filter: filter) else {
      return nil
    }
    
    return processedImageResult(with: image, filter: filter, setup: setup)
  }
  
  public func processedImageResult<T : Filter>(with image: CIImage,
                            filter: T,
                            setup: Setup) -> Result? {
    guard let _filter = store.filters[filter.name] else {
        return nil
    }
    
    setup(image, _filter)
    
    if let output = _filter.outputImage {
      return (output, image.extent)
    } else {
      return nil
    }
  }
  
  // MARK:
  
  private func add<T : Filter>(filter filter: T) {
    guard store.filters[filter.name] == nil else { return }
    
    do {
      let _filter = try filter.filter()
      store.filters[filter.name] = _filter
    } catch let error as FilterError {
      FilterErrorPrinter.printError(error)
    } catch {
      print(error)
    }
  }
  
  private func preparedImage<T : Filter>(with image: UIImage, filter: T) -> CIImage? {
    guard let _image = image.CGImage else {
      return nil
    }
    
    let image = CIImage(CGImage: _image)
    
    return image
  }
  
  private func convertedImage(from image: CIImage, extent: CGRect) -> UIImage {
    let _output = self.context.createCGImage(image,
                                             fromRect: extent)
    let output = UIImage(CGImage: _output)
    
    return output
  }
  
  
  private func setValues<T : Filter>(for filter: CIFilter, with _filter: T) {
    let scanned = _filter.scanned()
    for (key, value) in scanned {
      guard let value = value as? AnyObject else {
        continue
      }
      
      filter.setValue(value, forKey: key)
    }
  }
  
}
