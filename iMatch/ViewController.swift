//
//  ViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 8/10/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate{
    
    var controller:UIAlertController?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginChoice: UISegmentedControl!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        
        switch loginChoice.selectedSegmentIndex {
        
        case 1:
            performSegue(withIdentifier: "signUpForm", sender: self)
            break;
        default:
            break;
        }
    }
    
    @IBAction func Login(_ sender: UIButton) {
        
            if(userId.text != "" && password.text != ""){
                Auth.auth().signIn(withEmail: userId.text!, password: password.text!, completion: {(user,error) in
                    
                    if user != nil
                    {
                        self.performSegue(withIdentifier: "tabBarController", sender: self)
                    }
                    else{
                        
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                            self.DisplayAlert(Message: "Email or password is invalid");
                            
                        }
                        else{
                            print("ERROR")
                        }
                    }
                    
                    
                })
            } else {
                self.DisplayAlert(Message: "Please Don't leave it empty")
            }
       
        
    }
    func DisplayAlert(Message: String){
        
        let controller = UIAlertController(title: "Attention", message: Message, preferredStyle: .alert)
        
        let action = UIAlertAction(title:"Dismiss", style: .default, handler: {(paramAction:UIAlertAction!)
            in print("Di Bilang Jangan Di pencet!!!")})
        
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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



