//
//  TravelNewsController.swift
//  Platripus
//
//  Created by Thien Tran on 6/9/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class TravelNewsViewController: UITableViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var imageName: [String] = [
        "news_chicago",
        "news_newyork",
        "news_disneyland",
        "news_aurora"
        
    ]
    
    var newsTitle: [String] = [
        "21 Things to do in Chicago",
        "Discover the heart of New York",
        "Discounted tickets to disneyland Anaheim",
        "Northern lights or Aurora Borealis explained"
    ]
    
    var newsDescription: [String] = [
        "From a handpicked list of places, and attractions",
        "Unforgettable views on the Empire State Building",
        "Relive your favourite childhood memories",
        "The greatest mysteries of nature debunked"
        
    ]
    
    var newsLink: [String] = [
        "http://www.choosechicago.com/",
        "http://www.esbnyc.com/",
        "https://disneyland.disney.go.com/tickets/",
        "http://www.northernlightscentre.ca/northernlights.html"
    ]
    
    
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
        return newsTitle.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TravelNewsCell", forIndexPath: indexPath) as! TravelNewsCell
        
        let row = indexPath.row
        cell.postImageView.image = UIImage(named: imageName[row])
        cell.articleTitle.text = newsTitle[row]
        cell.articleDescription.text = newsDescription[row]
        cell.articleDescription.sizeToFit()
        cell.selectionStyle = .None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let url = NSURL(string: newsLink[row])
        UIApplication.sharedApplication().openURL(url!);

        
    }

}
