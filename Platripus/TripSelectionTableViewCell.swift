//
//  TripSelectionTableViewCell.swift
//  Platripus
//
//  Created by Thien Tran on 6/12/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class TripSelectionTableViewCell: UITableViewCell {
    //@IBOutlet weak var postImageView: UIImageView!
        
    //@IBOutlet weak var postTitleLabel: UILabel!

    //@IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
