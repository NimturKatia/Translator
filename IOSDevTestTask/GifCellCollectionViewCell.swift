//
//  GifCellCollectionViewCell.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/5/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit
import ImageIO
import SwiftGifOrigin

class GifCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(imageName: String){
        gifImageView.loadGif(name: imageName)
        self.gifImageView.layer.cornerRadius = 20
    }
}
