//
//  PastTripController.swift
//  Platripus
//
//  Created by Thien Tran on 6/9/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class PastTripTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var tripName = [
      "Napa Valley Wine Train, Sterling Vineyards",
      "Grand Canyon South Rim, Death Valley"
    ]
    
    var tripImage = ["upcoming1", "upcoming2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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
        return tripName.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PastTripCell
        
        let row = indexPath.row
        cell.tripImage.image = UIImage(named: tripImage[row])
        cell.tripName.text = tripName[row]
        
        return cell
    }

}
