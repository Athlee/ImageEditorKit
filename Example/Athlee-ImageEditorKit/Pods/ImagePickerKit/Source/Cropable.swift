//
//  Cropable.swift
//  Cropable
//
//  Created by mac on 14/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

///
/// A protocol providing zooming features to crop the content.
///
public protocol Cropable {
  /// A type for content view.
  associatedtype ChildView: UIView
  
  /// A cropable area containing the content.
  var cropView: UIScrollView { get set }
  
  /// A view containing the child. It is required to simplify 
  /// any transformations on the child.
  var childContainerView: UIView { get set }
  
  /// A cropable content view.
  var childView: ChildView { get set }
  
  /// This view is shown when cropping is happening.
  var linesView: LinesView { get set }
  
  /// Top offset for cropable content. If your `cropView`
  /// is constrained with `UINavigationBar` or anything on
  /// the top, set this offset so the content can be properly
  /// centered and scaled.
  ///
  /// Default value is `0.0`.
  var topOffset: CGFloat { get }
  
  /// Determines whether the guidelines' grid should be
  /// constantly showing on the cropping view.
  /// Default value is `false`.
  var alwaysShowGuidelines: Bool { get }
  
  ///
  /// Adds a cropable view with its content to the provided
  /// container view.
  ///
  /// - parameter view: A container view.
  ///
  func addCropable(to view: UIView)
  
  ///
  /// Updates the current cropable content area, zoom and scale.
  ///
  func updateContent()
  
  ///
  /// Centers a content view in its superview depending on the size.
  ///
  /// - parameter forcing: Determines whether centering should be done forcing. 
  /// This, generally, means that the content will be forced to get centered.
  ///
  func centerContent(forcing: Bool)
  
  ///
  /// This method is called whenever the zooming
  /// is about to start. It might be useful if
  /// you use a built-in `CropableScrollViewDelegate`.
  ///
  /// **ATTENTION**, default implementation
  /// is a placeholder!
  ///
  func willZoom()
  
  ///
  /// This method is called whenever the zooming
  /// is about to end. It might be useful if
  /// you use a built-in `CropableScrollViewDelegate`.
  ///
  /// **ATTENTION**, default implementation
  /// is a placeholder!
  ///
  func willEndZooming()
  
  ///
  /// Handles zoom gestures.
  ///
  func didZoom()
  
  ///
  /// Handles the end of zooming.
  ///
  func didEndZooming()
  
  ///
  /// Highlights an area of cropping by showing
  /// rectangular zone.
  ///
  /// - parameter highlght: A flag indicating whether it should show or hide the zone.
  /// - parameter animated: An animation flag, it's `true` by default.
  ///
  func highlightArea(_ highlight: Bool, animated: Bool)
}

// MARK: - Default implementations for UIImageView childs

public extension Cropable where ChildView == UIImageView {
  ///
  /// Adds a cropable view with its content to the provided
  /// container view.
  ///
  /// - parameter view: A container view.
  ///
  func addCropable(to view: UIView) {
    cropView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(cropView)
    
    let anchors = [
      cropView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      cropView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      cropView.topAnchor.constraint(equalTo: view.topAnchor),
      cropView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ].flatMap { $0 }
    
    NSLayoutConstraint.activate(anchors)
    
    cropView.backgroundColor = .clear
    cropView.showsHorizontalScrollIndicator = false
    cropView.showsVerticalScrollIndicator = false
    cropView.contentSize = view.bounds.size
    
    childContainerView.addSubview(childView)
    cropView.addSubview(childContainerView)
  }
  
  ///
  /// Adds a cropable view with its image to the provided
  /// container view.
  ///
  /// - parameter view: A container view.
  /// - parameter image: An image to use.
  ///
  func addCropable(to view: UIView, with image: UIImage) {
    addCropable(to: view)
    addImage(image)
  }
  
  ///
  /// Adds an image to the UIImageView child view.
  ///
  /// - parameter image: An image to use.
  /// - parameter adjustingContent: Indicates whether the content should be adjusted or not. Default value is `true`.
  ///
  func addImage(_ image: UIImage, adjustingContent: Bool = true) {
    childView.image = image
    
    if adjustingContent {
      childView.bounds.size = image.size
      childContainerView.bounds.size = image.size
      
      childContainerView.frame.origin = .zero
      childView.frame.origin = .zero
      
      cropView.contentOffset = .zero
      cropView.contentSize = image.size
      
      updateContent()
      highlightArea(false, animated: false)
    }
  }
}

// MARK: - Default implementations

public extension Cropable {
  /// Top offset for cropable content. If your `cropView`
  /// is constrained with `UINavigationBar` or anything on
  /// the top, set this offset so the content can be properly
  /// centered and scaled.
  ///
  /// Default value is `0.0`.
  var topOffset: CGFloat {
    return 0
  }
  
  /// Determines whether the guidelines' grid should be
  /// constantly showing on the cropping view.
  /// Default value is `false`.
  var alwaysShowGuidelines: Bool {
    return false
  }
  
  ///
  /// Updates the current cropable content area, zoom and scale.
  ///
  func updateContent() {
    let childViewSize = childContainerView.bounds.size
    let scrollViewSize = cropView.bounds.size
    
    let widthScale = scrollViewSize.width / childViewSize.width
    let heightScale = scrollViewSize.height / childViewSize.height
    
    let minScale = max(scrollViewSize.width, scrollViewSize.height) / max(childViewSize.width, childViewSize.height)
    let scale = max(heightScale, widthScale)
    
    if let _self = self as? UIScrollViewDelegate {
      cropView.delegate = _self
    }
    
    let maxZoomScale = CGAffineTransform.scalingFactor(toFill: cropView.bounds.size,
                                                        with: childView.bounds.size,
                                                        atAngle: Double(0))
    
    
    cropView.minimumZoomScale = minScale
    cropView.maximumZoomScale = CGFloat(maxZoomScale)
    cropView.zoomScale = scale
    
    centerContent(forcing: true)
    
    highlightArea(alwaysShowGuidelines, animated: false)
  }
  
  ///
  /// Centers a content view in its superview depending on the size.
  ///
  /// - parameter forcing: Determines whether centering should be done forcing.
  /// This, generally, means that the content will be forced to get centered.
  ///
  func centerContent(forcing: Bool = false) {
    var (left, top): (CGFloat, CGFloat) = (0, 0)
    
    if cropView.contentSize.width < cropView.frame.width {
      left = (cropView.frame.width - cropView.contentSize.width) / 2
    } else if forcing {
      cropView.contentOffset.x = abs(cropView.frame.width - cropView.contentSize.width) / 2
    }
    
    if cropView.contentSize.height < cropView.frame.height {
      top = (cropView.frame.height - cropView.contentSize.height) / 2
    } else if forcing {
      cropView.contentOffset.y = abs(cropView.frame.height - cropView.contentSize.height) / 2
    }
    
    cropView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
  }
  
  ///
  /// This method is called whenever the zooming
  /// is about to start. It might be useful if
  /// you use a built-in `CropableScrollViewDelegate`.
  ///
  /// **ATTENTION**, default implementation
  /// is a placeholder!
  ///
  func willZoom() { }
  
  ///
  /// This method is called whenever the zooming
  /// is about to end. It might be useful if
  /// you use a built-in `CropableScrollViewDelegate`.
  ///
  /// **ATTENTION**, default implementation
  /// is a placeholder!
  ///
  func willEndZooming() { }
  
  ///
  /// Handles zoom gestures.
  ///
  func didZoom() {
    centerContent()
    highlightArea(true)
  }
  
  ///
  /// Handles the end of zooming.
  ///
  func didEndZooming() {
    guard !alwaysShowGuidelines else { return }
    highlightArea(false)
  }
  
  ///
  /// Highlights an area of cropping by showing
  /// rectangular zone.
  ///
  /// - parameter highlght: A flag indicating whether it should show or hide the zone.
  /// - parameter animated: An animation flag, it's `true` by default.
  ///
  func highlightArea(_ highlight: Bool, animated: Bool = true) {
    guard UIApplication.shared.keyWindow != nil else {
      return
    }
    
    linesView.setNeedsDisplay()
    if linesView.superview == nil {
      cropView.insertSubview(linesView, aboveSubview: childView)
      linesView.backgroundColor = UIColor.clear
      linesView.alpha = 0
    } else {
      if animated {
        UIView.animate(
          withDuration: 0.3,
          delay: 0,
          options: [.allowUserInteraction],
          animations: {
            self.linesView.alpha = highlight ? 1 : 0
          },
          
          completion: nil
        )
      } else {
        linesView.alpha = highlight ? 1 : 0
      }
      
    }
    
    linesView.frame.size = CGSize(
      width: min(cropView.frame.width, childContainerView.frame.width),
      height: min(cropView.frame.height, childContainerView.frame.height)
    )
    
    let visibleRect = CGRect(origin: cropView.contentOffset, size: cropView.bounds.size)
    let intersection = visibleRect.intersection(childContainerView.frame)
    linesView.frame = intersection
  }
}
