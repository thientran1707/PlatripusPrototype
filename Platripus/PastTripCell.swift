//
//  PastTripCell.swift
//  Platripus
//
//  Created by Thien Tran on 6/14/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class PastTripCell: UITableViewCell {

    @IBOutlet weak var tripImage: UIImageView!
    
    @IBOutlet weak var tripName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
