//
//  TripSelectionTableViewController.swift
//  Platripus
//
//  Created by Thien Tran on 6/12/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class TripSelectionTableViewController: UITableViewController {
    
    
    @IBOutlet var tripSelectionTableView: UITableView!
    
    /* Data to pass to TripDetailViewController when cell is clicked */
    let tripTitleArray: [String] = [
    
    ]
    
    let tripTitleImageArray: [String] = [
    
    ]
    
    let tripLabelArray: [[String]] = [
      []
    ]
    
    let dataArray: [[String: [String]]] = [
      ["Test": ["Test"]]
    ]
    
    let bookingArray:[[String]] = [
      []
    ]
    
    /* Used to test segue */
    
    let titleText = "3 days in San Francisco"
    let titleImage = "trip1"
    let tripLabel: [String] = ["Day 1: Golden Gate Bridge", "Day 2: San Francisco", "Day 3: Yosemite"]
    let data: [String: [String]] = [
        "Day 1: Golden Gate Bridge":
            [
                "0900 - 1100 : 🌿 Golden Gate Park",
                "1200 - 1300 : 🎢 Golden Gate Bridge",
                "1300 - 1500 : 🏃 Sutro Baths",
                "1500 - 1700 : 🌅 Ocean Beach",
                "1900 - 2000 : 🍽 Cliff House"
        ],
        "Day 2: San Francisco": [
            "0900 - 1100 : 🎢 Lombard Street",
            "1200 - 1300 : 👜 Fisherman's Wharf",
            "1300 - 1500 : 🌿 Golden Gate Park",
            "1500 - 1700 : 🏛 Academy of Sciences",
            "1900 - 2000 : 🖼 Painted Ladies"
        ],
        "Day 3: Yosemite": [
            "0900 - 1100 : 🖼 Tunnel View",
            "1200 - 1300 : 🌿 Bridalveil Falls",
            "1300 - 1500 : 🏃 Yosemite Falls",
            "1500 - 1700 : 🏃 Vernal Falls Trail",
            "1900 - 2000 : 🖼 Valley View"
        ]
        
    ]
    
    let booking: [String] = ["Flight to San Francisco", "3 days accommodation"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem(
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tripCell", forIndexPath: indexPath) as! TripSelectionTableViewCell

        // Configure the cell...
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "trip1")
            cell.postTitleLabel.text = "Golden Gate Bridge, Lombat Street, Chinatown, Alcatraz"
            cell.price.text = "$299"
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "trip2")
            cell.postTitleLabel.text = "Golden Gate Bridge, Alcatraz, Nappa Valley, Yosemite"
            cell.price.text = "$499"
            
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "trip3")
            cell.postTitleLabel.text = "Yosemite National Park, Tunnel View, Glacier Point"
            cell.price.text = "$349"
        } else {
            cell.postImageView.image = UIImage(named: "trip4")
            cell.postTitleLabel.text = "Lake Tahoe, 2 Day Ski Pass, Sacramento"
            cell.price.text = "$449"
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //print(segue.identifier)
        
        if let cell = sender as? UITableViewCell {
            let index = tripSelectionTableView.indexPathForCell(cell)!.row
            if segue.identifier == "viewDetailTrip" {
                print(index)
                let detailViewController = segue.destinationViewController as! TripDetailViewController
                
                detailViewController.titleText = titleText
                detailViewController.titleImage = titleImage
                detailViewController.tripLabelArray = tripLabel
                detailViewController.data = data
                detailViewController.booking = booking
            }
        }
        
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
