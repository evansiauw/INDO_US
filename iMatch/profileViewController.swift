//
//  profileViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 9/4/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class profileViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileInfo()
        imageProfile.roundedCorner()
    
    }
   
    
    // Change the status bar to white instead of black color
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func getProfileInfo(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(uid!).observeSingleEvent(of:DataEventType.value, with: {
            (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.name.text = postDict["name"] as? String
        }, withCancel: nil)
    }
    
    @IBAction func SignOut(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "mainMenu", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    


}

extension UIImageView {
    
    func roundedCorner(){
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
    
    
    
}
