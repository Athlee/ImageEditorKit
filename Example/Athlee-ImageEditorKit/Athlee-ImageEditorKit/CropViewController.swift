//
//  CropViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

final class CropViewController: UIViewController {
  
  // MARK: Outlets 
  
  @IBOutlet weak var scalePicker: ScalePicker!
  
  // MARK: Properties 
  
  var theta: Float = 0
  var beta: Float = 0
  
  var transformView: UIView {
    return ContainerViewController.Children.image.cropContainerView
  }
  
  // MARK: Life cycle 
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scalePicker.reset()
  }
  
  // MARK: IBActions 
  
  @IBAction func didPressResetButton(_ sender: AnyObject) {
    scalePicker.reset()
    transformView.transform = CGAffineTransform.identity
    theta = 0
    beta = 0
  }
  
  @IBAction func didChangeValue(_ sender: ScalePicker) {
    let value = sender.value
    beta = value
    let angle = theta + value
    let transform = CGAffineTransform(rotationAngle: angle.toRadians())
    transformView.transform = transform
  }
  
  @IBAction func didPressRotateButton(_ sender: AnyObject) {
    theta += -90
    let transform = CGAffineTransform(rotationAngle: (theta + beta).toRadians())
    transformView.transform = transform
  }
}

extension Float {
  func toRadians() -> CGFloat {
    return CGFloat(self) * (CGFloat(M_PI) / 180)
  }
}
