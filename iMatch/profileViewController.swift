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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    /*override func preferredStatusBarStyle() -> UIStatusBarStyle{
        return .lightContent
    }*/
    
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
