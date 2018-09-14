//
//  feedCreationViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 9/5/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage

class feedCreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var newFeedTitle: UITextField!
    @IBOutlet weak var newFeedDetails: UITextView!
    @IBOutlet weak var imagePicker: UIButton!

    var imageLocalURL: URL?
    
    @IBAction func feedSubmission(_ sender: UIButton) {
        
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("feedPhotos/\(imageName).jpg")
        
        if let uploadData = imagePicker.currentImage?.compressImage() {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                print(metadata)
                
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                    let values = ["title": self.newFeedTitle.text!, "details": self.newFeedDetails.text!, "image": downloadURL.absoluteString] as [String : Any]
                    
                    self.uploadToCloud(values: values)
                }
            })
        }
    
        performSegue(withIdentifier: "feedCreationToMainMenu", sender: self)
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromImagePicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromImagePicker = editedImage

        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromImagePicker = originalImage

        }
        
        if let selectedImage = selectedImageFromImagePicker {
            imagePicker.setImage(selectedImage, for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func uploadToCloud(values: [String:Any]){
        
        Database.database().reference().child("Feeds").childByAutoId().updateChildValues(values, withCompletionBlock: { (err,ref) in
            
            if err != nil {
                print (err as Any)
                return
            }
            
        })
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIImage {
    
    func compressImage() -> Data? {
        // Reducing file size to a 10th
        var actualHeight: CGFloat = self.size.height
        var actualWidth: CGFloat = self.size.width
        let maxHeight: CGFloat = 1136.0
        let maxWidth: CGFloat = 640.0
        var imgRatio: CGFloat = actualWidth/actualHeight
        let maxRatio: CGFloat = maxWidth/maxHeight
        var compressionQuality: CGFloat = 0.1
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageData = UIImageJPEGRepresentation(img!, compressionQuality)
        return imageData
    }
}



/*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 textField.resignFirstResponder()
 return true
 }
 func textFieldDidBeginEditing(_ textField: UITextField) {
 scrollView.setContentOffset(CGPoint(x:0,y:215), animated: true)
 }
 
 func textFieldDidEndEditing(_ textField: UITextField) {
 scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
 }

//let userUID = Auth.auth().currentUser?.uid
//print("user id is \(userUID!)")
*/
 
