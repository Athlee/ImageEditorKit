//
//  ImageViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import CoreImage

final class ImageViewController: UIViewController, Cropable {
 
  // MARK: Outlets
  
  @IBOutlet weak var cropContainerView: UIView!
  
  // MARK: Cropable properties
  
  var cropView = UIScrollView()
  var childView = UIImageView()
  var linesView = LinesView()
  
  var alwaysShowGuidelines: Bool = true
  
  var topOffset: CGFloat {
    guard let navBar = navigationController?.navigationBar else {
      return 0
    }
    
    return !navBar.hidden ? navBar.frame.height : 0
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
    
    //image = imageView.image!
    
    addCropable(to: cropContainerView)
    cropView.delegate = delegate
    
    // TODO: Fetch photo 
    image = UIImage(named: "photo")!
    addImage(image)
    
    view.userInteractionEnabled = false
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    updateContent()
    highlightArea(false, animated: false)
  }
  
  // MARK: Communication 
  
  func croppingBegan(began: Bool) {
    if began {
      view.userInteractionEnabled = true
      highlightArea(true, animated: true)
    } else {
      view.userInteractionEnabled = false
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
      NSOperationQueue.mainQueue().addOperationWithBlock {
        guard let image = image else { return }
        self.addImage(image, adjustingContent: false)
      }
    }
  }
}
