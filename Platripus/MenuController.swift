//
//  MenuController.swift
//  Platripus
//
//  Created by Thien Tran on 6/7/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    @IBOutlet weak var avatar: UIImageView!

    @IBOutlet weak var header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make avatar round
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.clipsToBounds = true
        
        avatar.layer.borderWidth = 2.0
        avatar.layer.borderColor = UIColor.whiteColor().CGColor
        
        header.layer.backgroundColor = UIColor(hex: 0xEC2C43).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
