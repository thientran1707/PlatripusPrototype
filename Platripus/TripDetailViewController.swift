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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let width = screenSize.width
        let height = screenSize.height
        var scrollView: UIScrollView!
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: width, height: height))
        scrollView.contentSize = CGSizeMake(width, 940)
        
        bookButton1.backgroundColor = UIColor(hex: 0xEC2C43)

        bookButton2.backgroundColor = UIColor(hex: 0xEC2C43)

        scrollView.addSubview(content1)
        scrollView.addSubview(day1)
        scrollView.addSubview(day2)
        scrollView.addSubview(day3)
        scrollView.addSubview(day4)
        scrollView.addSubview(bookingView)
        
        view.addSubview(scrollView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
