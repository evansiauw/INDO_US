//
//  forumViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 9/15/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class forumViewController: UITableViewController{
    
    var forum = [Forum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchForums()
        
        /*let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)*/

    }
    
    /*@objc func dismissKeyboard() {
        view.endEditing(true)
    } */
    
    @IBAction func createNewForum(_ sender: UIBarButtonItem) {
        displayAlert()
    }
    
    func addNewForumToDatabase(name: String){
        
        let values = ["title" : name] as [String : Any]
        
        Database.database().reference().child("Forums").childByAutoId().updateChildValues(values, withCompletionBlock: { (err,ref) in
            
            if err != nil {
                print (err as Any)
                return
            }
            
        })
    }
    
    func displayAlert(){
        
        let alert = UIAlertController(title: "New Forum", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Please Enter Forum Name"
            textField.text = ""
        })
        
        let submit = UIAlertAction(title: "Enter", style: .default, handler: {(paramAction:UIAlertAction!) in
            let textField = alert.textFields![0] as UITextField
            
            // NEED TO BE FIXED, IN THE CASE OF USER DIDN'T INPUT ANYTHING
            if(textField.text != ""){
    
                self.addNewForumToDatabase(name: textField.text!)

            }
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(submit)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
        
    func fetchForums() {
        Database.database().reference().child("Forums").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let forums = Forum()
                forums.setValuesForKeys(dictionary)
                self.forum.append(forums)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }, withCancel: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forum.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForum", for: indexPath)
        as! ForumTableViewCell
        
        let value = forum[indexPath.row]
        cell.title.text = value.title!
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "forumDetails"{
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let value = forum[indexPath.row]
                
                let dest = segue.destination as! message
                dest.navigationItem.title = value.title!
                
            }
            
        }
        
    }



}
