//
//  TwoSideSlider.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

@IBDesignable
final class TwoSideSlider: UIControl {
  
  // MARK: Outlets
  
  @IBInspectable var minValue: CGFloat = -100
  @IBInspectable var maxValue: CGFloat = 50
  
  @IBInspectable var lineWidth: CGFloat = 1
  @IBInspectable var lineColor: UIColor = .blackColor()
  @IBInspectable var lineTintColor: UIColor = .redColor()
  
  @IBInspectable var thumbImage: UIImage = UIImage() {
    didSet {
      thumb.image = thumbImage
    }
  }
  
  @IBInspectable var centerThickHeight: CGFloat = 8
  @IBInspectable var centerThickColor: UIColor = .redColor()
  
  // MARK: Properties 
  
  var midValue: CGFloat = 0
  
  var currentValue: CGFloat = 0 {
    didSet {
      label.text = "\(Int(currentValue))"
      adjustLabelPosition()
      sendActionsForControlEvents(.ValueChanged)
    }
  }
  
  private let centerThickWidth: CGFloat = 1
  
  private lazy var line = CALayer()
  private lazy var thick = CALayer()
  private lazy var thumb = UIImageView()
  private lazy var label = UILabel()
  
  private lazy var leftLine = UIView()
  private lazy var rightLine = UIView()
  
  private var moving = false
  private var previousPoint: CGPoint = .zero
  
  // MARK: Life cycle
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  override func drawRect(rect: CGRect) {
    guard !moving else {
      return
    }
    
    backgroundColor = .clearColor()
    
    layer.addSublayer(line)
    line.frame.origin = CGPoint(x: bounds.minX, y: bounds.midY - lineWidth / 2)
    line.frame.size = CGSize(width: bounds.width, height: lineWidth)
    line.backgroundColor = lineColor.CGColor
    line.cornerRadius = lineWidth / 2
    
    addSubview(leftLine)
    leftLine.frame.origin = CGPoint(x: bounds.midX, y: bounds.midY - lineWidth / 2)
    leftLine.frame.size = CGSize(width: 0, height: lineWidth)
    leftLine.backgroundColor = lineTintColor
    leftLine.layer.cornerRadius = lineWidth / 2
    
    addSubview(rightLine)
    rightLine.frame.origin = CGPoint(x: bounds.midX, y: bounds.midY - lineWidth / 2)
    rightLine.frame.size = CGSize(width: 0, height: lineWidth)
    rightLine.backgroundColor = lineTintColor
    rightLine.layer.cornerRadius = lineWidth / 2
    
    layer.addSublayer(thick)
    thick.position = CGPoint(x: bounds.midX - centerThickWidth / 2, y: bounds.midY - centerThickHeight / 2)
    thick.frame.size = CGSize(width: centerThickWidth, height: centerThickHeight)
    thick.backgroundColor = centerThickColor.CGColor
    thick.cornerRadius = centerThickWidth / 2
    
    addSubview(thumb)
    thumb.image = thumbImage
    thumb.sizeToFit()
    thumb.center = CGPoint(x: bounds.midX, y: bounds.midY)
    
    addSubview(label)
    label.textColor = lineTintColor
    label.textAlignment = .Center
    label.font = UIFont.systemFontOfSize(13)
    label.text = "\(Int(midValue))"
    adjustLabelPosition()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(TwoSideSlider.didRecognizePanGesture(_:)))
    addGestureRecognizer(panRecognizer)
  }
  
  // MARK: IBActions
  
  @IBAction func didRecognizePanGesture(recognizer: UIPanGestureRecognizer) {
    let point = recognizer.locationInView(self)
    moving = true
    
    guard recognizer.state != .Began else {
      previousPoint = point
      return
    }
    
    let delta = point.x - previousPoint.x
    previousPoint = point
    moveThumb(dx: delta)
    
    if recognizer.state == .Ended {
      moving = false
      let distance = thumb.center.x - bounds.midX
      if abs(distance) <= 30 {
        currentValue = midValue
        resetLines()
        UIView.animateWithDuration(0.2) {
          let bounds = self.bounds
          self.thumb.center = CGPoint(x: bounds.midX, y: bounds.midY)
          self.adjustLabelPosition()
        }
      }
    }
  }
  
  // MARK: UI movement
  
  func moveThumb(dx dx: CGFloat) {
    var dx = dx
    
    if dx < 0 && thumb.frame.minX + dx < 0 {
      dx -= (thumb.frame.minX + dx)
    } else if dx > 0 && thumb.frame.maxX + dx > bounds.width {
      dx -= (thumb.frame.maxX + dx) - bounds.width
    }
    
    thumb.frame.origin.x += dx
    adjustLabelPosition()
    moveThickLine(dx: dx)
  }
  
  func adjustLabelPosition() {
    label.sizeToFit()
    label.center = CGPoint(x: thumb.center.x, y: thumb.frame.minY - label.frame.height)
    if currentValue == midValue {
      label.alpha = 0
    } else {
      label.alpha = 1
    }
  }
  
  func moveThickLine(dx dx: CGFloat) {
    moveLeftLine(dx: dx)
    moveRightLine(dx: dx)
    
    if thumb.center.x > bounds.midX {
      let x = thumb.center.x > bounds.midX * 1.5 ? // left or right side of right line
        thumb.frame.maxX : thumb.frame.midX
      let value = (x / (bounds.width / 2) - 1) * maxValue
      currentValue = value
    } else if thumb.center.x < bounds.midX {
      let x = thumb.center.x > bounds.midX / 2 ? // left or right side of left line
        thumb.frame.midX : thumb.frame.minX
      let value = abs(x / (bounds.width / 2) - 1) * minValue
      currentValue = value
    } else {
      currentValue = 0
    }
  }
  
  func moveLeftLine(dx dx: CGFloat) {
    var dx = dx
    if dx < 0 {
      guard thumb.center.x < bounds.midX else {
        leftLine.frame.size.width = 0
        return
      }
      
      if leftLine.frame.width > bounds.width / 2 {
        leftLine.frame.size.width = 0
      }
      
      if leftLine.frame.minX + dx < thumb.frame.minX {
        dx -= (leftLine.frame.minX + dx) - thumb.frame.minX
      }
      
      leftLine.frame.size.width += abs(dx)
      leftLine.frame.origin.x = bounds.midX - leftLine.frame.size.width
    } else {
      if leftLine.frame.width > 0 {
        if leftLine.frame.width + dx < 0 {
          dx += leftLine.frame.width + dx
        }
        
        if thumb.center.x > bounds.midX {
          dx = leftLine.frame.width
        }
        
        leftLine.frame.size.width -= abs(dx)
        leftLine.frame.origin.x = bounds.midX - leftLine.frame.width
      }
    }
  }
  
  func moveRightLine(dx dx: CGFloat) {
    var dx = dx
    if dx < 0 {
      if rightLine.frame.width > 0 {
        if rightLine.frame.width + dx < 0 {
          dx -= rightLine.frame.width + dx
        }
        
        if thumb.center.x < bounds.midX {
          dx = -rightLine.frame.width
        }
        
        rightLine.frame.size.width += dx
        rightLine.frame.origin.x = bounds.midX
      }
    } else {
      guard thumb.center.x > bounds.midX else {
        rightLine.frame.size.width = 0
        return
      }
      
      if rightLine.frame.maxX + dx > thumb.frame.maxX {
        dx -= (rightLine.frame.maxX + dx) - thumb.frame.maxX
      }
      
      rightLine.frame.size.width += dx
      rightLine.frame.origin.x = bounds.midX
    }
  }
  
  func resetLines() {
    leftLine.frame.size.width = 0
    rightLine.frame.origin.x = bounds.midX
    rightLine.frame.size.width = 0
  }
  
  func reset() {
    currentValue = 0
    thumb.center = CGPoint(x: bounds.midX, y: bounds.midY)
    resetLines()
  }
  
}