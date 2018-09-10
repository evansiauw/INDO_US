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

    var imageURL: String?
    
    @IBAction func feedSubmission(_ sender: UIButton) {
        
        //let userUID = Auth.auth().currentUser?.uid
        //print("user id is \(userUID!)")
        
        let values = ["title": newFeedTitle.text!, "details": newFeedDetails.text!, "image": imageURL!]
        Database.database().reference().child("Feeds").childByAutoId().updateChildValues(values, withCompletionBlock: { (err,ref) in
            
            if err != nil {
                print (err as Any)
                return
            }
            
        })

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
        
        let imageName = UUID().uuidString
        let imageURL = info[UIImagePickerControllerImageURL] as! URL
        let storageRef = Storage.storage().reference().child("feedPhotos/\(imageName)")

        storageRef.putFile(from: imageURL, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
        
            /*storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                print("url in firebase is \(downloadURL)")
            } */
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToCloud(){
        
        
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
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:215), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    } */


}
