//
//  TripDetailViewController.swift
//  Platripus
//
//  Created by Thien Tran on 6/12/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {
    /* Constants of DetailTripView*/
    let recommendataionMessage = "Things you might need"
    let bookingMessage = "Book Now"
    
    var titleText: String?
    var titleImage: String?
    var tripDescription: String?
    var tripLabelArray: [String] = []
    var data: [String: [String]] = [:]
    var booking: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let width = screenSize.width
        let height = screenSize.height
        
        let scrollView: UIScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))

        let headerView = createTripDetailHeaderView()
        scrollView.addSubview(headerView)
        var screenPoint = headerView.frame.size.height + 70
        
        // add the list of trip days
        
        for tripTitle in tripLabelArray {
            let label = UILabel(frame: CGRectMake(5, screenPoint , width - 10, 40))
            
            label.backgroundColor = UIColor(hex: 0xEC2C43)
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            label.text = tripTitle
            scrollView.addSubview(label)
            screenPoint += label.frame.size.height
            
            let value = data[tripTitle]!
            for tripText in value {
                let content = UILabel(frame: CGRectMake(10, screenPoint , width - 20, 25))
                content.textAlignment = .Left
                content.text = tripText
                screenPoint += 30
                scrollView.addSubview(content)
            }
            
            screenPoint += 10
        }

        let recommendationLabel: UILabel = UILabel(frame: CGRect(x: 5, y: screenPoint, width: width - 10, height: 30))
        recommendationLabel.textAlignment = .Center
        recommendationLabel.textColor = UIColor.whiteColor()
        recommendationLabel.text = recommendataionMessage
        recommendationLabel.backgroundColor = UIColor(hex: 0xEC2C43)
        scrollView.addSubview(recommendationLabel)
        screenPoint += 35
        
        for book in booking {
            let bookLabel: UILabel = UILabel(frame: CGRect(x: 5, y: screenPoint, width: width, height: 30))
            bookLabel.text = book
            bookLabel.textAlignment = .Center
            scrollView.addSubview(bookLabel)
            screenPoint += 35
            
            let bookButton: UIButton = UIButton(frame: CGRect(x: 30, y: screenPoint, width: width - 60, height: 30))
            bookButton.setTitle(bookingMessage, forState: .Normal)
            bookButton.backgroundColor = UIColor(hex: 0xEC2C43)
            scrollView.addSubview(bookButton)
            screenPoint += 35
        }

        scrollView.contentSize = CGSizeMake(width, screenPoint)
        view.addSubview(scrollView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTripDetailHeaderView() -> UIView {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let detailHeaderView: UIView = UIView(frame: CGRect(x: 0, y: 30, width: screenSize.width, height: 260))
        let label = UILabel(frame: CGRectMake(0, 30, screenSize.width, 30))
        label.textAlignment = NSTextAlignment.Center
        label.text = titleText
        
        let image : UIImage = UIImage(named: titleImage!)!
        let imageView: UIImageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 60, width: screenSize.width, height: 230)
        
        detailHeaderView.addSubview(label)
        detailHeaderView.addSubview(imageView)
        
        return detailHeaderView
    }


    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "addNewTrip" {
        
        var savedImageNameArray: [String] = []
        var savedtripNameArray: [String] = []
        var format = NSPropertyListFormat.XMLFormat_v1_0 //format of the property list
        var plistData:[String:AnyObject] = [:]  //our data

        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray

        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let plistPath = documentsDirectory.stringByAppendingPathComponent("trips.plist") //the path of the data
        
        let plistXML = NSFileManager.defaultManager().contentsAtPath(plistPath)! //the data in XML format

        do{ //convert the data to a dictionary and handle errors.
            plistData = try NSPropertyListSerialization.propertyListWithData(plistXML,options: .MutableContainersAndLeaves,format: &format)as! [String:AnyObject]
            
            let nameArray = plistData["tripNames"] as! [String]
            let imageArray = plistData["tripImages"] as! [String]

            savedImageNameArray = imageArray
            savedtripNameArray = nameArray
        }
        catch { // error condition
            print("Error reading plist: \(error), format: \(format)")
        }

        let path = documentsDirectory.stringByAppendingPathComponent("trips.plist")


        savedtripNameArray.append(tripDescription!)
        savedImageNameArray.append(titleImage!)
        let data: NSDictionary = [
            "tripNames" : savedtripNameArray,
            "tripImages": savedImageNameArray
        ]
        
        data.writeToFile(path, atomically: true)
      }
    }
    
    // MARK: - Table view data source
    
    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
    }*/


}
