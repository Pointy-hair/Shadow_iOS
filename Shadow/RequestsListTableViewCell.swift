//
//  RequestsListTableViewCell.swift
//  Shadow
//
//  Created by Aditi on 28/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class RequestsListTableViewCell: UITableViewCell {

    @IBOutlet var imgView_UserProfile: UIImageView!
    @IBOutlet var lbl_UserName: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var lbl_Time: UILabel!
    @IBOutlet var lbl_RequestStatus: UILabel!
    @IBOutlet var lbl_AverageRating: UILabel!
    @IBOutlet var lbl_TotalRatingCount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
