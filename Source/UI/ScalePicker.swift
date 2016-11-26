//
//  ScalePicker.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 20/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

@IBDesignable
public final class ScalePicker: UIControl {
  
  class Cell: UICollectionViewCell {
    static let identifier = "Cell"
  }
  
  @IBInspectable public var count: Int = 57
  @IBInspectable public var scalar: Float = 1
  @IBInspectable public var offset: Int = 4
  @IBInspectable public var tickColor: UIColor = UIColor.blue
  @IBInspectable public var distance: CGFloat = 32
  
  public  var initialValue: Float = 0
  
  public var value: Float = 0 {
    didSet {
      sendActions(for: .valueChanged)
    }
  }
  
  fileprivate var midItem: Int {
    return Int((count - 1) / 2)
  }
  
  fileprivate var contentCenteredIndexPath: IndexPath? {
    let filtered = collectionView.indexPathsForVisibleItems.filter { path in
      guard let cell = collectionView.cellForItem(at: path) else {
        return false
      }
      
      return abs((cell.frame.midX - collectionView.contentOffset.x) - bounds.width / 2) < distance / 2
    }
    
    return filtered.last
  }
  
  fileprivate var centeredIndexPath: IndexPath? {
    guard let centered = contentCenteredIndexPath, let cell = collectionView.cellForItem(at: centered) else {
      return nil
    }
    
    let x = (cell.frame.midX - collectionView.contentOffset.x - collectionView.frame.width / 2)
    if x > 0 && centered.item > midItem {
      return IndexPath(item: centered.item - 1, section: centered.section)
    } else if x < 0 && centered.item < midItem {
      return IndexPath(item: centered.item + 1, section: centered.section)
    } else {
      return centered
    }
  }
  
  fileprivate var maxX: CGFloat {
    let indexPath = IndexPath(item: count - 1 - offset, section: 0)
    if let cell = collectionView.cellForItem(at: indexPath) {
      return cell.frame.midX
    } else {
      return collectionView.contentSize.width
    }
  }
  
  fileprivate var minX: CGFloat {
    let indexPath = IndexPath(item: offset, section: 0)
    if let cell = collectionView.cellForItem(at: indexPath) {
      return cell.frame.midX
    } else {
      return 0
    }
  }
  
  fileprivate var midX: CGFloat {
    return collectionView.contentSize.width / 2
  }
  
  fileprivate lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    return collectionView
  }()
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
    collectionView.showsHorizontalScrollIndicator = false
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let anchors = [
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
      ].flatMap { $0 }
    
    NSLayoutConstraint.activate(anchors)
    
    reset()
  }
  
  public override func draw(_ rect: CGRect) {
    let side: CGFloat = 5
    let rect = CGRect(
      origin:
      CGPoint(
        x: bounds.midX - side / 2,
        y: bounds.minY + side * 2
      ),
      size: CGSize(width: side, height: side)
    )
    
    let circle = UIBezierPath(ovalIn: rect)
    tickColor.set()
    circle.fill()
  }
  
  public func reset() {
    let indexPath = IndexPath(item: Int((count - 1) / 2), section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
  }
  
}

extension ScalePicker: UICollectionViewDataSource, UICollectionViewDelegate {
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
    
    cell.backgroundColor = tickColor
    cell.layer.cornerRadius = cell.frame.width / 2
    
    return cell
  }
}

extension ScalePicker: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 3, height: collectionView.frame.width / 7)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return distance
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1000
  }
  
}

internal extension UICollectionView {
  func indexPaths(for rect: CGRect) -> [IndexPath] {
    guard let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect) else {
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
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    handleScroll(scrollView)
    
    
    if let indexPath = centeredIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
      let mid = scrollView.convert(cell.center, to: self)
      let _d = (bounds.midX - mid.x) / distance
      let d = _d > 0 ? _d : (1 + _d)
      
      value = Float(indexPath.item - midItem) * scalar + Float(d)
    }
  }
  
  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    handleScroll(scrollView)
  }
  
  fileprivate func handleScroll(_ scrollView: UIScrollView) {
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
