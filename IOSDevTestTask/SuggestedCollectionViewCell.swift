//
//  SuggestedCollectionViewCell.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/5/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit

class SuggestedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var suggestedNewsImageView: UIImageView!
    @IBOutlet weak var suggestedNewsHeaderLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(){
        self.suggestedNewsImageView.image  = UIImage.init(named: "suggested")
        self.suggestedNewsHeaderLabel.text = "Suggested header"
    }
}
