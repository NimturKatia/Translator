//
//  ImagesViewController.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/1/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var gifsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        gifsCollectionView.register(UINib(nibName: "GifCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gifCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : GifCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath) as! GifCellCollectionViewCell
        
        let imageName = String(indexPath.row)
        cell.configureWith(imageName:imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.view.frame.width > self.view.frame.height {
            return CGSize(width: (self.view.frame.width / 3 - 16), height: (self.view.frame.height / 3 + 40))
        } else {
            return CGSize(width: (self.view.frame.width / 3 - 16), height: (self.view.frame.height / 3 - 110))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
