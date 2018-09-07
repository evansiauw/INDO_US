//
//  FeedViewController.swift
//  Pods-iMatch
//
//  Created by Iwan Siauw on 8/19/18.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FeedViewController: UITableViewController{
    
    var feeds = [Feed]()
    
    var feedTitle = ["Room For Rent","Studio for sale in Elmhurst","Looking for SE Job"];
    var feedSubtitle = [
        "1 bedroom in 3 bedroom apt is available in Elmhurst\nPlease Call 347-933-2366",
        "Large Bedroom Alcove Area.\nVery Low Maintenance.\nExtremely Convenient Location",
        "Recent college Graduates\nLooking for Software Engineering Jobs\nPlease call me at ###-###-####"];
    
    var feedImage = ["room.jpg","condo.jpg","iwan.jpg"];
    
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
                print("Feeds Added \(dictionary)")

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
    
    @IBAction func refreshTable(_ sender: Any) {
        
        
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
        
        cell.feedImage.image = UIImage(named: feedImage[indexPath.row % 3])
        cell.feedTitle.text = value.title
        cell.feedSubTitle.text = value.details
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueFeedDetails"{
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let destination = segue.destination as! feedCellDetailsViewController
                destination.image = UIImage(named: feedImage[indexPath.row % 3])
                destination.feedTitleDetails = feedTitle[indexPath.row]
                
            }
            
        }
        
    }
    

}
