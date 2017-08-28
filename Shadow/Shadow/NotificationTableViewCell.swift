//
//  NotificationTableViewCell.swift
//  Shadow
//
//  Created by Aditi on 24/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet var imgView_Notification: UIImageView!
    @IBOutlet var lbl_Notification: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
