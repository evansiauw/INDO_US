//
//  FeedViewController.swift
//  Pods-iMatch
//
//  Created by Iwan Siauw on 8/19/18.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class FeedViewController: UITableViewController{
    
    var feeds = [Feed]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: true, afterDelay: 0)
        }
        
        fetchFeed()
        
    }
    
    
    
    func fetchFeed() {
        
        Database.database().reference().child("Feeds").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let feed = Feed()
                feed.setValuesForKeys(dictionary)
                self.feeds.append(feed)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
            
        }, withCancel: nil)
        
        
        
        
        
        // Not finished yet -- removing cell by index when cell is removed
        /*Database.database().reference().child("Feeds").observe(.childRemoved, with: { (snapshot) in
            
            
        let index = snapshot.index(ofAccessibilityElement: Int.self)
            
        print("this is index \(index)")
        let index = self.feeds.
        self.feeds.remove(at: index)
        self.tableView.deleteRows(at: [IndexPath(row: index, section: self.kSectionComments)], with: UITableViewRowAnimation.automatic)
            
            
    }, withCancel: nil)
         */
        
    }
    
    
    
    @objc func handleLogout(){
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        performSegue(withIdentifier: "loginScreen", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
        
        let value = feeds[indexPath.row]
        let imageRef = value.image
        let httpRef = Storage.storage().reference(forURL: imageRef!)
        
        httpRef.getData(maxSize: 5 * 1024 * 1024, completion: { data, error in
            if let error = error {
                print(error)
            } else {
                
                value.realImage = UIImage(data: data!)
                cell.feedImage.image = value.realImage
            }
        })
        
        cell.feedTitle.text = value.title
        cell.feedSubTitle.text = value.details
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueFeedDetails"{
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let value = feeds[indexPath.row]
                
                let destination = segue.destination as! feedCellDetailsViewController
                
                destination.image = value.realImage
                destination.feedTitleDetails = value.title
                destination.feedDetail = value.details
                
            }
            
        }
        
    }
    

}
