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
  
  var _parent: ContainerViewController!
  
  let processor = ImageProcessor()
  let image = UIImage(named: "photo")!
  let scale: CGFloat = 3
  let queue = OperationQueue()
  
  var images: [IndexPath: UIImage] = [:]
  var names: [IndexPath: String] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareImages()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let indexPath = IndexPath(item: 0, section: 0)
    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
  }
  
  func prepareImages() {
    for i in 0..<13 {
      let indexPath = IndexPath(item: i, section: 0)
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
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 14
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
    cell.imageView.isOpaque = true
    cell.layer.shouldRasterize = true
    cell.layer.rasterizationScale = UIScreen.main.scale
    
    if let image = images[indexPath] {
      cell.imageView.image = image
    } else {
      let completion: (UIImage?) -> Void = { [cell, indexPath] image in
        OperationQueue.main.addOperation {
          self.images[indexPath] = image
          cell.imageView.image = image
        }
      }
      
      prepareImage(at: indexPath, completion: completion)
    }
    
    cell.filterNameLabel.text = names[indexPath]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if let cell = cell as? FilterCell, let image = images[indexPath] {
      cell.imageView.image = image
      cell.filterNameLabel.text = names[indexPath]
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let image = images[indexPath] {
      ContainerViewController.Children.image.image = image
      
      guard let cell = collectionView.cellForItem(at: indexPath) else {
        return
      }
      
      // TODO: Scroll like in Instagram 
    }
  }
  
  func prepareImage(at indexPath: IndexPath, completion: (UIImage?) -> Void) {
    switch indexPath.item {
    case 0:
      names[indexPath] = "None"
      images[indexPath] = self.image
      
    case 1:
      let filter = ColorInvertFilter(image: image)
      names[indexPath] = "Invert"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 2:
      let filter = ColorMonochromeFilter(image: image, color: .orange)
      names[indexPath] = "Monochrome"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 3:
      let filter = ColorPosterizeFilter(image: image)
      names[indexPath] = "Posterize"
      processor.process(image: self.image, filter: filter, completion: completion)
      
    case 4:
      let filter = FalseColorFilter(image: image, inputColor0: .red, inputColor1: .blue)
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.width / 2.5)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
}
