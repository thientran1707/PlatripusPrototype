//
//  UpcomingDetailViewController.swift
//  Platripus
//
//  Created by Thien Tran on 6/14/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//


import UIKit

class UpcomingDetailViewController: UIViewController/*, UITableViewDataSource, UITableViewDelegate*/ {
    /* Constants of DetailTripView*/
    let recommendataionMessage: String = "Things you might need"
    let bookingMessage: String = "Book Now"
    let headerHeight: CGFloat = CGFloat(50.0)
    let customCellHeight: CGFloat = CGFloat(250)
    
    var titleText: String?
    var titleImage: String?
    var tripDescription: String?
    var tripLabelArray: [String] = []
    var data: [String: [String]] = [:]
    var booking: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        let screenSize: CGSize = view.frame.size
        let width = screenSize.width
        let height = screenSize.height
        
        let topBar = self.navigationController!.navigationBar.frame.height
        //print(topBar)
        
        let tableView: UITableView = UITableView(frame: CGRect(x: 5, y: 70, width: width - 10, height: height - topBar), style: .Grouped)
        tableView.backgroundColor = UIColor.whiteColor()
        //tableView.dataSource = self
        //tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "detailTripActivityCell")
        
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
    
    /*func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("tripActivityCell", forIndexPath: indexPath)
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
            
            let image : UIImage = UIImage(named: titleImage!)!
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
            
            for book in booking {
                let bookLabel: UILabel = UILabel(frame: CGRect(x: 5, y: screenPoint, width: width, height: 30))
                bookLabel.text = book
                bookLabel.textAlignment = .Center
                headerView.addSubview(bookLabel)
                screenPoint += 35
                
                let bookButton: UIButton = UIButton(frame: CGRect(x: 30, y: screenPoint, width: width - 60, height: 30))
                bookButton.setTitle(bookingMessage, forState: .Normal)
                bookButton.backgroundColor = UIColor(hex: 0xEC2C43)
                headerView.addSubview(bookButton)
                screenPoint += 35
            }
            
            // update height of headerView
            headerView.frame.size.height = screenPoint
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let section = indexPath.section
            let row = indexPath.row
            
            let tripName = tripLabelArray[section - 1]
            var tripData = data[tripName]!
            
            tripData.removeAtIndex(row)
            data[tripName] = tripData
            tableView.reloadData()
        }
    }*/
    
}

