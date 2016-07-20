//
//  FilterViewController.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

final class FilterViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var parent: ContainerViewController!
  
  let processor = ImageProcessor()
  let image = UIImage(named: "photo")!
  let scale: CGFloat = 3
  let queue = NSOperationQueue()
  
  var images: [NSIndexPath: UIImage] = [:]
  var names: [NSIndexPath: String] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareImages()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    let indexPath = NSIndexPath(forItem: 0, inSection: 0)
    collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
  }
  
  func prepareImages() {
    for i in 0..<13 {
      let indexPath = NSIndexPath(forItem: i, inSection: 0)
      if images[indexPath] == nil {
        let completion: (UIImage?) -> Void = { [indexPath] image in
          self.images[indexPath] = image
        }
        
        prepareImage(at: indexPath, completion: completion)
      }
    }
  }
  
  
}

extension FilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 14
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCell
    cell.imageView.opaque = true
    cell.layer.shouldRasterize = true
    cell.layer.rasterizationScale = UIScreen.mainScreen().scale
    
    if let image = images[indexPath] {
      cell.imageView.image = image
    } else {
      let completion: (UIImage?) -> Void = { [cell, indexPath] image in
        NSOperationQueue.mainQueue().addOperationWithBlock {
          self.images[indexPath] = image
          cell.imageView.image = image
        }
      }
      
      prepareImage(at: indexPath, completion: completion)
    }
    
    cell.filterNameLabel.text = names[indexPath]
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    if let cell = cell as? FilterCell, image = images[indexPath] {
      cell.imageView.image = image
      cell.filterNameLabel.text = names[indexPath]
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if let image = images[indexPath] {
      ContainerViewController.Children.image.image = image
      
      guard let cell = collectionView.cellForItemAtIndexPath(indexPath) else {
        return
      }
      
      // TODO: Scroll like in Instagram 
    }
  }
  
  func prepareImage(at indexPath: NSIndexPath, completion: (UIImage?) -> Void) {
    switch indexPath.item {
    case 0:
      names[indexPath] = "None"
      images[indexPath] = self.image
      
    case 1:
      let filter = ColorInvertFilter(image: image)
      names[indexPath] = "Invert"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 2:
      let filter = ColorMonochromeFilter(image: image, color: .orangeColor())
      names[indexPath] = "Monochrome"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 3:
      let filter = ColorPosterizeFilter(image: image)
      names[indexPath] = "Posterize"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 4:
      let filter = FalseColorFilter(image: image, inputColor0: .redColor(), inputColor1: .blueColor())
      names[indexPath] = "False Color"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 5:
      let filter = PhotoEffectChromeFilter(image: image)
      names[indexPath] = "Chrome"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 6:
      let filter = PhotoEffectFadeFilter(image: image)
      names[indexPath] = "Fade"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 7:
      let filter = PhotoEffectInstantFilter(image: image)
      names[indexPath] = "Instant"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 8:
      let filter = PhotoEffectMonoFilter(image: image)
      names[indexPath] = "Mono"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 9:
      let filter = PhotoEffectNoirFilter(image: image)
      names[indexPath] = "Noir"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 10:
      let filter = PhotoEffectProcessFilter(image: image)
      names[indexPath] = "Process"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 11:
      let filter = PhotoEffectTonalFilter(image: image)
      names[indexPath] = "Tonal"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 12:
      let filter = PhotoEffectTransferFilter(image: image)
      names[indexPath] = "Transfer"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 13:
      let filter = SepiaToneFilter(image: image)
      names[indexPath] = "Sepia Tone"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    default:
      break
    }
  }
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.width / 2.5)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 8
  }
  
}
