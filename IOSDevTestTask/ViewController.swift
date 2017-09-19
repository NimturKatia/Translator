//
//  ViewController.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/1/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var translatorButton: UIButton!
    @IBOutlet weak var imagesButton: UIButton!
    @IBOutlet weak var designButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        StyleConfigs.shared.configureButton(button: self.translatorButton)
        StyleConfigs.shared.configureButton(button: self.imagesButton)
        StyleConfigs.shared.configureButton(button: self.designButton)
        
        self.navigationItem.title = "Main menu"
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.lightText
        self.navigationController?.navigationBar.barStyle = .blackOpaque
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTranslatorButtonPress(_ sender: UIButton) {
        let translatorVC = TranslatorViewController()
        self.navigationController?.pushViewController(translatorVC, animated: true)
    }
    
    @IBAction func onImagesButtonPress(_ sender: Any) {
        let imagesVC = ImagesViewController()
        self.navigationController?.pushViewController(imagesVC, animated: true)
    }
    
    @IBAction func onDesignButtonPress(_ sender: Any) {
        let designVC = DesignViewController()
        self.navigationController?.pushViewController(designVC, animated: true)
    }
}

