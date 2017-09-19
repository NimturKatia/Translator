//
//  DesignViewController.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/1/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit

class DesignViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var statusMessageLabel: UILabel!
    @IBOutlet weak var pagesView: UIView!
    @IBOutlet weak var followersView: UIView!
    @IBOutlet weak var followingView: UIView!
    @IBOutlet weak var pagesButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var suggestedCollectionView: UICollectionView!
    
    let userNickName      = "Vika@"
    let userName          = "Viktoria Colt"
    let userStatusMessage = "Do you want to go out with me?\n(A) Yes (B) A (C) B."
    let numberOfPages     = 180
    let numberOfFollowers = 1244
    
    let numberOfFollowing  = 12455
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestedCollectionView.register(UINib(nibName: "SuggestedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "suggestedCell")
        self.pageConfigs()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(tapGestureRecognizer)
        self.profileImageView.clipsToBounds = true
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        
        let actionSheet = UIAlertController(title: "Change  profile Image", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Make new image", style: .default, handler:{
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose new image", style: .default, handler:{
            action in
            self.showGallery()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Delete image", style: .default, handler:{
            action in
            self.deleteCurrentProfileImage()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated:  true, completion: nil)
    }
    
    func showCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraPicker           = UIImagePickerController()
            cameraPicker.delegate      = self
            cameraPicker.sourceType    = .camera
            cameraPicker.allowsEditing = true
            
            present(cameraPicker, animated:  true, completion: nil)
        }
    }
    
    func showGallery(){
        let galleryPicker           = UIImagePickerController()
        galleryPicker.delegate      = self
        galleryPicker.sourceType    = .photoLibrary
        galleryPicker.allowsEditing = true
        
        present(galleryPicker, animated: true, completion: nil)
    }
    
    func deleteCurrentProfileImage(){
        self.profileImageView.image = UIImage(named: "noimage")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = editedImage
        } else {
            let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
            selectedImage = originalImage
        }
        
        self.profileImageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil )
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SuggestedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestedCell", for: indexPath) as! SuggestedCollectionViewCell
        cell.configureCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = self.view.frame.width / 3 - 25
        let image = UIImage.init(named: "noimage")
        let height = (width * (image?.size.height)!) / (image?.size.width)! + 30
        
        return CGSize(width: width, height: height)
    }
    
    func setViewBorderColor(view: UIView, red: Double, green: Double, blue: Double){
        let color = UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
        view.layer.borderColor = color.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func setButtonBorderColor(button: UIButton, red: Double, green: Double, blue: Double){
        let color = UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1.0)
        button.layer.borderColor = color.cgColor
    }
    
    func pageConfigs(){
        let screenWidthMultiplier = UIScreen.main.bounds.width / 375.0
        
        self.profileImageView.layer.cornerRadius = (self.profileImageView.frame.size.width / 2) * screenWidthMultiplier
        self.profileView.layer.cornerRadius      = (self.profileView.frame.size.width / 2) * screenWidthMultiplier
        
        self.followButton.layer.cornerRadius     = self.followButton.frame.size.height / 2 * screenWidthMultiplier
        self.shareButton.layer.cornerRadius      = self.shareButton.frame.size.height / 2 * screenWidthMultiplier
        
        self.setButtonBorderColor(button: self.shareButton, red: 55, green: 181, blue: 189)
        self.setButtonBorderColor(button: self.followButton, red: 55, green: 181, blue: 189)
        self.setViewBorderColor(view: self.pagesView, red: 224, green: 227, blue: 227)
        self.setViewBorderColor(view: self.followersView, red: 224, green: 227, blue: 227)
        self.setViewBorderColor(view: self.followingView, red: 224, green: 227, blue: 227)
        
        self.pagesLabel.text     = String(self.numberOfPages)
        self.followersLabel.text = String(self.numberOfFollowers)
        self.followingLabel.text = String(self.numberOfFollowing)
        
        self.followButton.layer.borderWidth  = 1
        self.shareButton.layer.borderWidth   = 1
        self.pagesView.layer.borderWidth     = 1
        self.followersView.layer.borderWidth = 1
        self.followingView.layer.borderWidth = 1
        
        self.setViewBorderColor(view: self.profileView, red: 224, green: 227, blue: 227)
        self.profileView.layer.borderWidth = 1
        
        self.nickNameLabel.text      = self.userNickName
        self.nameLabel.text          = self.userName
        self.statusMessageLabel.text = self.userStatusMessage
        
        self.navigationItem.title = self.userNickName
    }
    
    @IBAction func onFollowButtonPress(_ sender: UIButton) {
        if self.followButton.currentTitle == "+ Follow" {
            self.followButton.setTitle("Following", for: UIControlState.normal)
            self.followButton.backgroundColor = UIColor.white
            let color = UIColor(red: 55/255.0, green: 181/255.0, blue: 189/255.0, alpha: 1.0)
            self.followButton.setTitleColor(color, for: UIControlState.normal)
        } else {
            self.followButton.setTitle("+ Follow", for: UIControlState.normal)
            let color = UIColor(red: 55/255.0, green: 181/255.0, blue: 189/255.0, alpha: 1.0)
            self.followButton.backgroundColor = color
            self.followButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
    }
}
