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

    
    var imageNameArray: [String] = []
    
    var tripNameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        readPropertyList()
    }
    
    func readPropertyList(){
        var format = NSPropertyListFormat.XMLFormat_v1_0 //format of the property list
        var plistData:[String:AnyObject] = [:]  //our data
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        print("Paths")
        print(paths)
        let documentsDirectory = paths[0] as! NSString
        let plistPath = documentsDirectory.stringByAppendingPathComponent("trips.plist")
        
        if !NSFileManager.defaultManager().fileExistsAtPath(plistPath) {
            // copy form bundle to resources
            let plistPathInBundle = NSBundle.mainBundle().pathForResource("trips", ofType: "plist")!
            
            do {
                try NSFileManager.defaultManager().copyItemAtPath(plistPathInBundle, toPath: plistPath)
                print("plist copied")
            } catch {
                print("error copying plist!")
            }
        }
        else{
            print("plst exists \(plistPath)")
        }
        
        let plistXML = NSFileManager.defaultManager().contentsAtPath(plistPath)! //the data in XML format
        do { //convert the data to a dictionary and handle errors.
            plistData = try NSPropertyListSerialization.propertyListWithData(plistXML,options: .MutableContainersAndLeaves,format: &format) as! [String:AnyObject]
            
            let nameArray = plistData["tripNames"] as! [String]
            let imageArray = plistData["tripImages"] as! [String]
            tripNameArray = nameArray
            imageNameArray = imageArray
        }
        catch{ // error condition
            print("Error reading plist: \(error), format: \(format)")
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
        return tripNameArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UpcomingTripsViewCell

        let row = indexPath.row
        cell.postImageView.image = UIImage(named: imageNameArray[row])
        cell.postTitleLabel.text = tripNameArray[row]

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("Delete")
            let index = indexPath.row
            print("Index")
            print(index)
            print(imageNameArray)
            print(tripNameArray)
            imageNameArray.removeAtIndex(index)
            tripNameArray.removeAtIndex(index)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
            
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            let documentsDirectory = paths.objectAtIndex(0) as! NSString
            let path = documentsDirectory.stringByAppendingPathComponent("trips.plist")
            let data: NSDictionary = [
                "tripNames" : tripNameArray,
                "tripImages": imageNameArray
            ]
            
            data.writeToFile(path, atomically: true)
        }
    }

}
