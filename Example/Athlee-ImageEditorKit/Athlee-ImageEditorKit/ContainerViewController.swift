//
//  ContainerViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

final class ContainerViewController: UIViewController {
  
  enum State {
    case Filters
    case Brightness
    case Crop
  }
  
  // MARK: Outlets
  
  @IBOutlet weak var filtersView: UIView!
  @IBOutlet weak var brightnessView: UIView!
  @IBOutlet weak var cropView: UIView!
  
  @IBOutlet weak var filtersButton: UIButton!
  @IBOutlet weak var brightnessButton: UIButton!
  @IBOutlet weak var cropButton: UIButton!
  
  // MARK: Properties
  
  struct Children {
    static var image: ImageViewController!
    static var filters: FilterViewController!
    static var brightness: BrightnessViewController!
    static var crop: CropViewController!
  }
  
  var state: State = .Filters { didSet { updateVisibility() } }
  
  // MARK: Life cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addChildren()
    updateVisibility()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  // MARK: Actions
  
  @IBAction func didPressFilterButton(sender: AnyObject) {
    state = .Filters
  }
  
  @IBAction func didPressBrightnessButton(sender: AnyObject) {
    state = .Brightness
  }
  
  @IBAction func didPressCropButton(sender: AnyObject) {
    state = .Crop
  }
  
  // MARK: Utils 
  
  func addChildren() {
    for child in childViewControllers {
      switch child.self {
      case is ImageViewController:
        Children.image = child as! ImageViewController
        
      case is FilterViewController:
        Children.filters = child as! FilterViewController
        
      case is BrightnessViewController:
        Children.brightness = child as! BrightnessViewController
        Children.brightness.parent = self
        
      case is CropViewController:
        Children.crop = child as! CropViewController
        
      default:
        break
      }
    }
  }
  
  func updateVisibility() {
    filtersView.alpha = 0
    brightnessView.alpha = 0
    cropView.alpha = 0
    
    filtersButton.selected = false
    brightnessButton.selected = false
    cropButton.selected = false
    
    switch state {
    case .Filters:
      title = "Select a filter"
      filtersView.alpha = 1
      filtersButton.selected = true
      Children.image.croppingBegan(false)
    case .Brightness:
      title = "Adjust brightness"
      brightnessView.alpha = 1
      brightnessButton.selected = true
      Children.image.croppingBegan(false)
    case .Crop:
      title = "Crop the image"
      cropView.alpha = 1
      cropButton.selected = true
      Children.image.croppingBegan(true)
    }
  }
  
}
