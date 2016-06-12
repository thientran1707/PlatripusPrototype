//
//  ExploreController.swift
//  Platripus
//
//  Created by Thien Tran on 6/9/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        //helloText.userInteractionEnabled = false
        //selectionView.layer.borderWidth = 1
        //selectionView.layer.borderColor = UIColor.redColor().CGColor
        
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
}
