//
//  ContainerViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

final class ContainerViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
  enum State {
    case filters
    case brightness
    case crop
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
  
  let picker = UIImagePickerController()
  
  var image: UIImage? {
    didSet {
      Children.image.image = image
      Children.filters.image = image
    }
  }
  
  var state: State = .filters { didSet { updateVisibility() } }
  
  // MARK: Life cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //picker.allowsEditing = false
    picker.sourceType = .photoLibrary
    picker.delegate = self
    picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    
    addChildren()
    updateVisibility()
    
    image = UIImage(named: "photo")
  }
  
  override var prefersStatusBarHidden : Bool {
    return true
  }
  
  // MARK: Actions
  
  @IBAction func didPressFilterButton(_ sender: AnyObject) {
    state = .filters
  }
  
  @IBAction func didPressBrightnessButton(_ sender: AnyObject) {
    state = .brightness
  }
  
  @IBAction func didPressCropButton(_ sender: AnyObject) {
    state = .crop
  }
  
  @IBAction func didPressLibraryButton(_ sender: Any) {
    present(picker, animated: true, completion: nil)
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
        Children.brightness._parent = self
        
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
    
    filtersButton.isSelected = false
    brightnessButton.isSelected = false
    cropButton.isSelected = false
    
    switch state {
    case .filters:
      title = "Select a filter"
      filtersView.alpha = 1
      filtersButton.isSelected = true
      Children.image.croppingBegan(false)
    case .brightness:
      title = "Adjust brightness"
      brightnessView.alpha = 1
      brightnessButton.isSelected = true
      Children.image.croppingBegan(false)
    case .crop:
      title = "Crop the image"
      cropView.alpha = 1
      cropButton.isSelected = true
      Children.image.croppingBegan(true)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      self.image = image
    }
    
    dismiss(animated: true, completion: nil)
  }
  
}
