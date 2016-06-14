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
      "3 days trip in San Francisco",
      "4 days trips in San Francisco",
      "3 days trip in Yosemite",
      "4 days trip in Yellow Stone"
    ]
    
    let tripTitleImageArray: [String] = [
      "trip1",
      "trip2",
      "trip3",
      "trip4"
    ]
    
    let tripLabelArray: [[String]] = [
        ["Day 1: Golden Gate Bridge", "Day 2: San Francisco", "Day 3: Yosemite"],
        ["Day 1: Golden Gate Bridge", "Day 2: San Francisco", "Day 3: Yosemite", "Day 4: Nappa Valley"],
        ["Day 1: Golden Gate Bridge", "Day 2: San Francisco", "Day 3: Yosemite"],
        ["Day 1: Golden Gate Bridge", "Day 2: San Francisco", "Day 3: Yosemite", "Day 4: Nappa Valley"]
    ]
    
    let dataArray: [[String: [String]]] = [
        [
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
        ],
        
        [
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
            ],
            "Day 4: Nappa Valley": [
                "0900 - 1100 : 🖼 Tunnel View",
                "1200 - 1300 : 🌿 Bridalveil Falls",
                "1300 - 1500 : 🏃 Yosemite Falls",
                "1500 - 1700 : 🏃 Vernal Falls Trail",
                "1900 - 2000 : 🖼 Valley View"
            ]
        ],
        [
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
        ],
        [
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
            ],
            "Day 4: Nappa Valley": [
                "0900 - 1100 : 🖼 Tunnel View",
                "1200 - 1300 : 🌿 Bridalveil Falls",
                "1300 - 1500 : 🏃 Yosemite Falls",
                "1500 - 1700 : 🏃 Vernal Falls Trail",
                "1900 - 2000 : 🖼 Valley View"
            ]
        ],
        
    ]
    
    let bookingArray:[[String]] = [
        ["Flight to San Francisco", "3 days accommodation"],
        ["Flight to San Francisco", "3 days accommodation", "Tickets to Yosemite"],
        ["Flight to San Francisco", "3 days accommodation"],
        ["Flight to San Francisco", "3 days accommodation", "Tickets to Yosemite"],
    ]
    
    /* Array data for trip table view */
    let tripNameArray: [String] = [
        "Golden Gate Bridge, Lombat Street, Chinatown, Alcatraz",
        "Golden Gate Bridge, Alcatraz, Nappa Valley, Yosemite",
        "Yosemite National Park, Tunnel View, Glacier Point",
        "Lake Tahoe, 2 Day Ski Pass, Sacramento"
    ]
    
    let tripPriceArray: [String] = [
        "$299",
        "$499",
        "$199",
        "$699"
    ]    
    
    override func viewDidLoad() {
        //self.automaticallyAdjustsScrollViewInsets = false
        //self.tableView.contentInset = UIEdgeInsetsMake(0, 10, 0, 0)
        self.tableView.frame.origin.y = self.tableView.frame.origin.y + 200
        super.viewDidLoad()
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
        return tripNameArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tripCell", forIndexPath: indexPath) as! TripSelectionTableViewCell
        
        let row = indexPath.row
        cell.postImageView.image = UIImage(named: tripTitleImageArray[row])
        cell.postTitleLabel.text = tripNameArray[row]
        cell.price.text = tripPriceArray[row]
        
        return cell
    }
    
    // pass data to TripDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            let index = tripSelectionTableView.indexPathForCell(cell)!.row
            if segue.identifier == "viewDetailTrip" {
                //print(index)
                let detailViewController = segue.destinationViewController as! TripDetailViewController
                
                detailViewController.titleText = tripTitleArray[index]
                detailViewController.titleImage = tripTitleImageArray[index]
                detailViewController.tripDescription = tripNameArray[index]
                detailViewController.tripLabelArray = tripLabelArray[index]//tripLabel
                detailViewController.data = dataArray[index]//data
                detailViewController.booking = bookingArray[index]//booking
            }
        }
        
    }
}
