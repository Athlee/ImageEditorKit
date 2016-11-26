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
  
  fileprivate class Store {
    var filters: [String: CIFilter] = [:]
    
    fileprivate lazy var queue: OperationQueue = {
      let queue = OperationQueue()
      queue.maxConcurrentOperationCount = 1
      return queue
    }()
  }
  
  // MARK: Properties
  
  fileprivate let context = CIContext()
  fileprivate let store = Store()
  fileprivate var queue: OperationQueue {
    return store.queue
  }
  
  // Initialization
  
  public init() { }
  
  // MARK: ImageProcessorType properties
  
  public func process<T : Filter>(image: UIImage, filter: T, completion: (UIImage?) -> Void) {
    print("[ImageProcessor]: Unable to find appropriate processing method's overload...")
  }
  
  // MARK: BlurFilter
  
  public func process<T : BlurFilter>(image: UIImage,
               filter: T,
               completion: @escaping (UIImage?) -> Void) {
    let transformValue = NSValue(cgAffineTransform: CGAffineTransform(scaleX: 1, y: 1))
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
    queue.addOperation {
      let output = self.convertedImage(from: result.image, extent: scaleResult.originalExtent)
      completion(output)
    }
  }
  
  // MARK: TileEffect
  
  public func process<T : TileEffect>(image: UIImage,
               filter: T,
               completion: @escaping (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperation {
      let output = self.convertedImage(from: result.image, extent: filter.inputImage?.extent ?? .zero)
      completion(output)
    }
  }
  
  // MARK: ColorEffectFilters
  
  public func process<T : ColorEffectFilter>(image: UIImage,
               filter: T,
               completion: @escaping (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperation {
      let output = self.convertedImage(from: result.image, extent: filter.inputImage?.extent ?? .zero)
      completion(output)
    }
  }
  
  // MARK: ColorAdjustment 
  
  public func process<T : ColorAdjustmentFilter>(image: UIImage,
               filter: T,
               completion: @escaping (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperation {
      let output = self.convertedImage(from: result.image, extent: filter.inputImage?.extent ?? .zero)
      completion(output)
    }
  }
  
  // MARK: GeometryAdjustment
  
  public func process<T : GeometryAdjustment>(image: UIImage,
               filter: T,
               completion: @escaping (UIImage?) -> Void) {
    add(filter: filter)
    
    let _result = processedImageResult(with: image, filter: filter) { image, _filter in
      self.setValues(for: _filter, with: filter)
    }
    
    guard let result = _result else {
      completion(nil)
      return
    }
    
    queue.cancelAllOperations()
    queue.addOperation {
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
  
  fileprivate func add<T : Filter>(filter: T) {
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
  
  fileprivate func preparedImage<T : Filter>(with image: UIImage, filter: T) -> CIImage? {
    guard let _image = image.cgImage else {
      return nil
    }
    
    let image = CIImage(cgImage: _image)
    
    return image
  }
  
  fileprivate func convertedImage(from image: CIImage, extent: CGRect) -> UIImage {
    let _output = self.context.createCGImage(image,
                                             from: extent)
    let output = UIImage(cgImage: _output!)
    
    return output
  }
  
  
  fileprivate func setValues<T : Filter>(for filter: CIFilter, with _filter: T) {
    let scanned = _filter.scanned()
    for (key, value) in scanned {
      guard let value = value as? AnyObject else {
        continue
      }
      
      filter.setValue(value, forKey: key)
    }
  }
  
}
