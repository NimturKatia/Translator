//
//  StyleConfigs.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/1/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit

class StyleConfigs: NSObject {
    static let shared = StyleConfigs()
    
    func configureButton(button: UIButton){
        button.layer.cornerRadius  = 5
        button.layer.shadowColor   = UIColor.lightGray.cgColor
        button.layer.shadowOffset  = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius  = 3.0
    }
}
