//
//  FeedViewController.swift
//  Pods-iMatch
//
//  Created by Iwan Siauw on 8/19/18.
//

import UIKit

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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
