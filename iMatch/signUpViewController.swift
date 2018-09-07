//
//  signUpViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 8/30/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class signUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passwordReEnter: UITextField!
    @IBOutlet weak var passEnter: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func signUp(_ sender: UIButton) {
      
        Auth.auth().createUser(withEmail: userName.text!, password: passEnter.text!, completion: { (authResult, error) in
            
            guard let user = authResult?.user else { return }
            
            guard let name = self.name.text, let email = self.userName.text
                else {
                    print("Something is wrong")
                    return
            }
            
            let ref = Database.database().reference(fromURL: "https://imatch-9a18f.firebaseio.com/")
            let userReference = ref.child("Users").child(user.uid)
            let values = ["name": name, "email": email]
            userReference.updateChildValues(values, withCompletionBlock: { (err,ref) in
                
                if err != nil {
                    print(err as Any)
                    return
                }
            })
            
            })
        
        self.DisplayAlert(Message: "User Data Saved")
        self.performSegue(withIdentifier: "tabBarController1", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func DisplayAlert(Message: String){
        
        let controller = UIAlertController(title: "Attention", message: Message, preferredStyle: .alert)
        
        let action = UIAlertAction(title:"Dismiss", style: .default, handler: {(paramAction:UIAlertAction!)
            in print("Di Bilang Jangan Di pencet!!!")})
        
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:215), animated: true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }

    

}

/*if (userName.text == ""){
    DisplayAlert(Message: "All fields are required!!!");
    return;
}
else if (passEnter.text != passwordReEnter.text){
    DisplayAlert(Message: "Passwords do not match!!!");
    return;
}

 if user != nil
 {
 }
 else{
 
 if let myError = error?.localizedDescription
 {
 print(myError)
 }
 else{
 print("ERROR")
 self.DisplayAlert(Message: "Email already exist");
 
 }
 } */
