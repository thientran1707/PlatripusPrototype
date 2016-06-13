//
//  NewsTableViewController.swift
//  Platripus
//
//  Created by Thien Tran on 6/7/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class UpcomingTripsViewController: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    
    var imageName: [String] = [
      "upcoming1",
      "upcoming2"
    ]
    
    var tripName: [String] = [
        "Napa Valley Wine Train, Sterling Vineyards,Castello di Amoroso",
        "Grand Canyon South Rim, Death Valley"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Trip name")
        print(tripName)
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UpcomingTripsViewCell

        let row = indexPath.row
        cell.postImageView.image = UIImage(named: imageName[row])
        cell.postTitleLabel.text = tripName[row]

        return cell
    }

}
