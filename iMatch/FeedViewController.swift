//
//  FeedViewController.swift
//  Pods-iMatch
//
//  Created by Iwan Siauw on 8/19/18.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var feedTitle = ["Room For Rent","Studio for sale in Elmhurst","Looking for SE Job"];
var feedSubtitle = [
    "1 bedroom in 3 bedroom apt is available in Elmhurst\nPlease Call 347-933-2366",
    "Large Bedroom Alcove Area.\nVery Low Maintenance.\nExtremely Convenient Location",
    "Recent college Graduates\nLooking for Software Engineering Jobs\nPlease call me at ###-###-####"
];

var feedImage = ["room.jpg","condo.jpg","iwan.jpg"];

class FeedViewController: UITableViewController{


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: true, afterDelay: 0)
        }

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
        return feedTitle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
        
        cell.feedImage.image = UIImage(named: feedImage[indexPath.row])
        cell.feedTitle.text = feedTitle[indexPath.row];
        cell.feedSubTitle.text = feedSubtitle[indexPath.row];
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueFeedDetails"{
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let destination = segue.destination as! feedCellDetailsViewController
                destination.image = UIImage(named: feedImage[indexPath.row])
                destination.feedTitleDetails = feedTitle[indexPath.row]
                
            }
            
        }
        
    }
    

}
