//
//  UpcomingDetailViewController.swift
//  Platripus
//
//  Created by Thien Tran on 6/14/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//


import UIKit

class UpcomingDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /* Constants of DetailTripView*/
    let recommendataionMessage: String = "Items you might need with your trip"
    let bookingMessage: String = "Buy Now"
    let headerHeight: CGFloat = CGFloat(50.0)
    let customCellHeight: CGFloat = CGFloat(250)
    
    /*var titleText: String?
    var titleImage: String?
    var tripDescription: String?
    var tripLabelArray: [String] = []
    var data: [String: [String]] = [:]
    var booking: [String] = []*/
    
    var titleText: String = "3 days trip in San Francisco"
    var titleImage: String = "trip1"
    var tripLabelArray: [String] = ["Day 1: Golden Gate Bridge", "Day 2: San Francisco", "Day 3: Yosemite"]
    
    var data: [String: [String]] =
        [
            "Day 1: Golden Gate Bridge":[
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
    
    var itemName = ["Thermal Travel Mug ", "Travel Backpacks"]
    var itemImage = ["item1", "item2"]
    
    var booking: [String] = ["Flight to San Francisco", "3 days accommodation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        let screenSize: CGSize = view.frame.size
        let width = screenSize.width
        let height = screenSize.height
        
        let topBar = self.navigationController!.navigationBar.frame.height
        //print(topBar)
        
        let tableView: UITableView = UITableView(frame: CGRect(x: 5, y: topBar, width: width - 10, height: height - topBar), style: .Grouped)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "upcomingTripActivityCell")
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 400, 0)
        
        view.addSubview(tableView)
        
        /*let scrollView: UIScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
         
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
         view.addSubview(scrollView)*/
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return data.count + 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if (section == 0 || section == (tripLabelArray.count + 1)) {
            return 0
        } else {
            let tripName: String = tripLabelArray[section - 1]
            return data[tripName]!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("upcomingTripActivityCell", forIndexPath: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        
        if (section == 0 || section == (tripLabelArray.count + 1)) {
            cell.frame.size.height = 0
        } else {
            let tripName: String = tripLabelArray[section - 1]
            // configure the cell using its properties
            cell.textLabel!.text = data[tripName]![row]//"Test"
            cell.textLabel!.font = UIFont(name:"Avenir", size: 15)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return customCellHeight
        } else if (section == (tripLabelArray.count + 1)) {
            return CGFloat(35 + 70 * booking.count + 15)
        } else {
            return headerHeight
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenSize: CGSize = view.frame.size
        let width = screenSize.width
        let headerView:UIView!
        
        if (section == 0) {
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 250))
            let label = UILabel(frame: CGRectMake(0, 0, width, 30))
            label.textAlignment = NSTextAlignment.Center
            label.text = titleText
            label.font = UIFont(name:"Avenir", size: 20)
            
            let image : UIImage = UIImage(named: titleImage)!
            let imageView: UIImageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 30, width: width, height: 220)
            
            headerView.addSubview(label)
            headerView.addSubview(imageView)
        } else if (section == (tripLabelArray.count + 1)) {
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 250))
            
            let recommendationLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 30))
            recommendationLabel.textAlignment = .Center
            recommendationLabel.textColor = UIColor.whiteColor()
            recommendationLabel.text = recommendataionMessage
            recommendationLabel.backgroundColor = UIColor(hex: 0xEC2C43)
            headerView.addSubview(recommendationLabel)
            
            var screenPoint = recommendationLabel.frame.size.height + 5
            //let itemsNumber = itemName.count - 1
            for (index, item) in itemName.enumerate() {
                print("Index")
                print(index)
                let image: UIImage = UIImage(named: itemImage[index])!
                let imageView: UIImageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 5, y: screenPoint, width: width - 10, height: 200)
                headerView.addSubview(imageView)
                screenPoint += 205
                
                let bookLabel: UILabel = UILabel(frame: CGRect(x: 5, y: screenPoint, width: (width - 10) * 0.6, height: 35))
                bookLabel.text = item
                bookLabel.font = UIFont(name:"Avenir", size: 18)
                bookLabel.textAlignment = .Left
                headerView.addSubview(bookLabel)
                
                let bookButton: UIButton = UIButton(frame: CGRect(x: 10 + bookLabel.frame.size.width, y: screenPoint, width: width - 20 - bookLabel.frame.size.width, height: 35))
                bookButton.setTitle(bookingMessage, forState: .Normal)
                bookButton.titleLabel!.font = UIFont(name: "Avenir", size: 20)
                bookButton.backgroundColor = UIColor(hex: 0xEC2C43)
                headerView.addSubview(bookButton)
                screenPoint += 75
            }
            
            // update height of headerView
            headerView.frame.size.height = screenPoint + 20
        } else {
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: headerHeight))
            headerView.backgroundColor = UIColor(hex: 0xEC2C43)
            
            let headerLabel: UILabel = UILabel(frame: CGRect(x: 5, y: 0, width: width - 5, height: headerHeight))
            headerLabel.text = tripLabelArray[section - 1]
            headerLabel.textColor = UIColor.whiteColor()
            headerView.addSubview(headerLabel)
        }
        
        return headerView
    }
    
}

