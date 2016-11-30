//
//  CropViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import ImagePickerKit

final class CropViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet weak var scalePicker: ScalePicker!
  
  // MARK: Properties 
  
  var theta: Double = 0
  var beta: Double = 0
  var angle: CGFloat = 0
  
  // MARK: Life cycle 
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scalePicker.reset()
  }
  
  // MARK: IBActions
  
  @IBAction func didPressResetButton(_ sender: AnyObject) {
    theta = 0
    beta = 0
    angle = 0
    
    scalePicker.reset()
    applyAngleTransform()
    
    let imageViewController = ContainerViewController.Children.image
    imageViewController?.updateContent()
  }
  
  @IBAction func didChangeValue(_ sender: ScalePicker) {
    let value = sender.value
    beta = Double(value.toRadians())
    angle = CGFloat(theta + beta)
    
    applyAngleTransform()
  }
  
  @IBAction func didPressRotateButton(_ sender: AnyObject) {
    theta += (-90.0).toRadians()
    
    applyAngleTransform()
  }
  
  // MARK: Utils 
  
  fileprivate func applyAngleTransform() {
    let scrollView = ContainerViewController.Children.image.cropView
    let imageView = ContainerViewController.Children.image.childView
    let transform = CGAffineTransform(rotationAngle: CGFloat(angle))
      .scaling(toFill: scrollView.bounds.size, with: imageView.bounds.size, atAngle: Double(angle))
    
    let maxZoomFactor = CGAffineTransform.scalingFactor(toFill: scrollView.bounds.size,
                                                        with: imageView.bounds.size,
                                                        atAngle: Double(angle))
    
    print("Zoom=\(scrollView.zoomScale), Max=\(maxZoomFactor)")
    
    scrollView.maximumZoomScale = CGFloat(maxZoomFactor)
    imageView.transform = angle != 0 ? transform : .identity
  }
}


