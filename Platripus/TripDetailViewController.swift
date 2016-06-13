//
//  TripDetailViewController.swift
//  Platripus
//
//  Created by Thien Tran on 6/12/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var content1: UIView!
    @IBOutlet weak var day1: UIView!
    @IBOutlet weak var day2: UIView!
    @IBOutlet weak var day3: UIView!
    @IBOutlet weak var day4: UIView!
    @IBOutlet weak var bookingView: UIView!
    
    @IBOutlet weak var bookButton1: UIButton!
    @IBOutlet weak var bookButton2: UIButton!
    
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
        recommendationLabel.text = "Things you might need"
        recommendationLabel.backgroundColor = UIColor(hex: 0xEC2C43)
        scrollView.addSubview(recommendationLabel)
        screenPoint += 35
        
        for book in booking {
          print(book)
            let bookLabel: UILabel = UILabel(frame: CGRect(x: 5, y: screenPoint, width: width, height: 30))
            bookLabel.text = book
            bookLabel.textAlignment = .Center
            scrollView.addSubview(bookLabel)
            screenPoint += 35
            
            let bookButton: UIButton = UIButton(frame: CGRect(x: 30, y: screenPoint, width: width - 60, height: 30))
            bookButton.setTitle("Book Now", forState: .Normal)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "addNewTrip" {
        let upcomingViewController = segue.destinationViewController as! UpcomingTripsViewController
        upcomingViewController.imageName.append(titleImage!)
        upcomingViewController.tripName.append(tripDescription!)
      }
    }

}
