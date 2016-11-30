//
//  ImageViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage
import ImagePickerKit

final class ImageViewController: UIViewController, Cropable {
 
  // MARK: Outlets
  
  @IBOutlet weak var cropContainerView: UIView!
  
  // MARK: Cropable properties
  
  var cropMaskView = UIView()
  
  var cropView = UIScrollView()
  var childView = UIImageView()
  var childContainerView = UIView()
  var linesView = LinesView()
  
  var alwaysShowGuidelines: Bool = true
  
  var topOffset: CGFloat {
    guard let navBar = navigationController?.navigationBar else {
      return 0
    }
    
    return !navBar.isHidden ? navBar.frame.height : 0
  }
  
  lazy var delegate: CropableScrollViewDelegate<ImageViewController> = {
    return CropableScrollViewDelegate(cropable: self)
  }()
  
  // MARK: Properties
  
  var image: UIImage! {
    didSet {
      addImage(image, adjustingContent: false)
      if let slider = ContainerViewController.Children.brightness?.twoSideSlider {
        slider.reset()
      }
    }
  }
  
  let processor = ImageProcessor()
  
  var brightnessValue: Float = 0 {
    didSet {
      updateBrightness()
    }
  }
  
  // MARK: Life cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addCropable(to: cropContainerView)
    cropView.delegate = delegate
    
    // TODO: Fetch photo 
    image = UIImage(named: "photo")!
    addImage(image)
    
    view.isUserInteractionEnabled = false
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateContent()
    highlightArea(false, animated: false)
  }
  
  // MARK: Communication 
  
  func croppingBegan(_ began: Bool) {
    if began {
      view.isUserInteractionEnabled = true
      highlightArea(true, animated: true)
    } else {
      view.isUserInteractionEnabled = false
      highlightArea(false, animated: false)
    }
  }
  
  // MARK: Utils 
  
  func updateBrightness() {
    let filter = ColorControlsFilter(
      image: image,
      inputSaturation: 1,
      inputBrightness: brightnessValue,
      inputContrast: 1
    )
    
    processor.process(image: image, filter: filter) { image in
      OperationQueue.main.addOperation {
        guard let image = image else { return }
        self.addImage(image, adjustingContent: false)
      }
    }
  }
}
