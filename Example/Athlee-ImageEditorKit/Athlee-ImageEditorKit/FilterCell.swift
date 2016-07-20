//
//  PreviewCell.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 19/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit

final class FilterCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var filterNameLabel: UILabel!
  
  override var selected: Bool {
    didSet {
      if selected {
        filterNameLabel.textColor = UIColor(hex: 0x876DF3)
        filterNameLabel.alpha = 1
      } else {
        filterNameLabel.textColor = UIColor.grayColor()
        filterNameLabel.alpha = 0.8
      }
    }
  }
}
