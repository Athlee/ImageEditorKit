//
//  BrightnessViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

final class BrightnessViewController: UIViewController {
  
  @IBOutlet weak var twoSideSlider: TwoSideSlider!
  
  var parent: ContainerViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func didUpdateValue(sender: TwoSideSlider) {
    let value = Float(sender.currentValue) * 0.001
    ContainerViewController.Children.image.brightnessValue = value
  }
}
