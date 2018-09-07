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

class feedCreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var newFeedTitle: UITextField!
    @IBOutlet weak var newFeedDetails: UITextView!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func feedSubmission(_ sender: UIButton) {
        
        //let userUID = Auth.auth().currentUser?.uid
        //print("user id is \(userUID!)")
        
        let values = ["title": newFeedTitle.text!, "details": newFeedDetails.text!]
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
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel button was pressed")
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
