//
//  liveChatViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 9/2/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit
import MessageUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class liveChatViewController: UITableViewController{
    
    var messages = [Message]()

    func fetchFeed() {
        
        Database.database().reference().child("Messages").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let msg = Message()
                msg.setValuesForKeys(dictionary)
                self.messages.append(msg)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }, withCancel: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //fetchFeed()

    }

   

}
