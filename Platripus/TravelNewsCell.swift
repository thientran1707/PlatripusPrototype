//
//  TravelNewsCell.swift
//  Platripus
//
//  Created by Leonardo Sjahputra on 6/13/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import Foundation
import UIKit

class TravelNewsCell: UITableViewCell {
    
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var postImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}