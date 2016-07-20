//
//  ScalePicker.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 20/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

@IBDesignable
final class ScalePicker: UIControl {
  
  class Cell: UICollectionViewCell {
    static let identifier = "Cell"
  }
  
  @IBInspectable var count: Int = 57
  @IBInspectable var scalar: Float = 1 
  @IBInspectable var offset: Int = 4
  @IBInspectable var tickColor: UIColor = UIColor.blueColor()
  @IBInspectable var distance: CGFloat = 32
  
  var initialValue: Float = 0
  
  var value: Float = 0 {
    didSet {
      sendActionsForControlEvents(.ValueChanged)
    }
  }
  
  var midItem: Int {
    return Int((count - 1) / 2)
  }
  
  var centeredIndexPath: NSIndexPath? {
    let filtered = collectionView.indexPathsForVisibleItems().filter { path in
      guard let cell = collectionView.cellForItemAtIndexPath(path) else {
        return false
      }
      
      return abs((cell.frame.midX - collectionView.contentOffset.x) - bounds.midX) < 32
    }
    
    return filtered.first
  }
  
  var maxX: CGFloat {
    let indexPath = NSIndexPath(forItem: count - 1 - offset, inSection: 0)
    if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
      return cell.frame.maxX
    } else {
      return collectionView.contentSize.width
    }
  }
  
  var minX: CGFloat {
    let indexPath = NSIndexPath(forItem: offset, inSection: 0)
    if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
      return cell.frame.minX
    } else {
      return 0
    }
  }
  
  var midX: CGFloat {
    return collectionView.contentSize.width / 2
  }
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .Horizontal
    let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    return collectionView
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clearColor()
    collectionView.registerClass(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
    collectionView.showsHorizontalScrollIndicator = false
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let anchors = [
      collectionView.topAnchor.constraintEqualToAnchor(topAnchor),
      collectionView.bottomAnchor.constraintEqualToAnchor(bottomAnchor),
      collectionView.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
      collectionView.trailingAnchor.constraintEqualToAnchor(trailingAnchor)
      ].flatMap { $0 }
    
    NSLayoutConstraint.activateConstraints(anchors)
    
    reset()
  }
  
  override func drawRect(rect: CGRect) {
    let side: CGFloat = 5
    let rect = CGRect(
      origin:
      CGPoint(
        x: bounds.midX - side / 2,
        y: bounds.minY + side * 2
      ),
      size: CGSize(width: side, height: side)
    )
    
    let circle = UIBezierPath(ovalInRect: rect)
    tickColor.set()
    circle.fill()
  }
  
  func reset() {
    let indexPath = NSIndexPath(forItem: Int((count - 1) / 2), inSection: 0)
    collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
  }
  
}

extension ScalePicker: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell
    
    cell.backgroundColor = tickColor
    cell.layer.cornerRadius = cell.frame.width / 2
    
    return cell
  }
}

extension ScalePicker: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: 3, height: collectionView.frame.width / 7)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return distance
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 1000
  }
  
}

internal extension UICollectionView {
  func indexPaths(for rect: CGRect) -> [NSIndexPath] {
    guard let allLayoutAttributes = collectionViewLayout.layoutAttributesForElementsInRect(rect) else {
      return []
    }
    
    guard allLayoutAttributes.count > 0 else {
      return []
    }
    
    let indexPaths = allLayoutAttributes.map { $0.indexPath }
    
    return indexPaths
  }
}

extension ScalePicker {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    handleScroll(scrollView)
    
    
    if let indexPath = centeredIndexPath, cell = collectionView.cellForItemAtIndexPath(indexPath) {
      let mid = scrollView.convertPoint(cell.center, toView: self)
      let _d = (bounds.midX - mid.x) / distance
      let d = _d > 0 ? _d : (1 + _d)
      value = Float(indexPath.item - midItem) * scalar + Float(d)
    }
  }
  
  func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
    handleScroll(scrollView)
  }
  
  func handleScroll(scrollView: UIScrollView) {
    var offset = scrollView.contentOffset
    
    if scrollView.contentOffset.x + scrollView.frame.width / 2 < minX {
      offset.x = minX - scrollView.frame.width / 2
    }
    
    if offset.x > 0 {
      if scrollView.contentOffset.x + scrollView.frame.width > maxX + collectionView.frame.width / 2 {
        offset.x = maxX + scrollView.frame.width / 2 - scrollView.frame.width
      }
    }
    
    scrollView.setContentOffset(offset, animated: false)
  }
}
